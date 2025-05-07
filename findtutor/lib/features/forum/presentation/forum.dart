import 'package:findtutor/core/navigation/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findtutor/features/forum/presentation/widgets/forum_list_item.dart';
import 'package:findtutor/features/forum/presentation/widgets/create_forum_dialog.dart';
import 'package:findtutor/features/forum/presentation/screens/forum_detail_screen.dart';

import '../bloc/forum_bloc.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  final _searchController = TextEditingController();
  bool _showPrivateOnly = false;

  @override
  void initState() {
    super.initState();
    _loadForums();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadForums() {
    context.read<ForumBloc>().add(
      GetForums(
        search: _searchController.text.isEmpty ? null : _searchController.text,
        isPrivate: _showPrivateOnly ? true : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forums'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const CreateForumDialog(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search forums...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _loadForums(),
                  ),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Private Only'),
                  selected: _showPrivateOnly,
                  onSelected: (selected) {
                    setState(() {
                      _showPrivateOnly = selected;
                    });
                    _loadForums();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ForumBloc, ForumState>(
              builder: (context, state) {
                if (state is ForumLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ForumError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: ${state.message}',
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadForums,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is ForumLoaded) {
                  if (state.forums.results.isEmpty) {
                    return const Center(child: Text('No forums found'));
                  }

                  return RefreshIndicator(
                    onRefresh: () async => _loadForums(),
                    child: ListView.builder(
                      itemCount: state.forums.results.length,
                      itemBuilder: (context, index) {
                        final forum = state.forums.results[index];
                        return InkWell(
                          onTap: () {
                            AppNavigator.pushForumsBloc(
                              context,
                              ForumDetailScreen(forum: forum),
                            );
                          },
                          child: ForumListItem(
                            forum: forum,
                            onJoin: () {
                              context.read<ForumBloc>().add(
                                JoinForum(forum.id),
                              );
                            },
                            onLeave: () {
                              context.read<ForumBloc>().add(
                                LeaveForum(forum.id),
                              );
                            },
                            onFollow: () {
                              context.read<ForumBloc>().add(
                                FollowForum(forum.id),
                              );
                            },
                            onUnfollow: () {
                              context.read<ForumBloc>().add(
                                UnfollowForum(forum.id),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
