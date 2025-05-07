import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findtutor/features/forum/presentation/widgets/forum_post_item.dart';

import '../../bloc/forum_bloc.dart';

class ForumPostList extends StatefulWidget {
  final int forumId;

  const ForumPostList({super.key, required this.forumId});

  @override
  State<ForumPostList> createState() => _ForumPostListState();
}

class _ForumPostListState extends State<ForumPostList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadPosts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMorePosts();
    }
  }

  void _loadPosts() {
    context.read<ForumBloc>().add(
      GetForumPosts(forumId: widget.forumId, page: 1),
    );
  }

  void _loadMorePosts() {
    final state = context.read<ForumBloc>().state;
    if (state is ForumPostsLoaded && state.posts.links.next != null) {
      context.read<ForumBloc>().add(
        GetForumPosts(
          forumId: widget.forumId,
          page: 1, // TODO: Extract page from next URL
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForumBloc, ForumState>(
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
                  onPressed: _loadPosts,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is ForumPostsLoaded) {
          if (state.posts.results.isEmpty) {
            return const Center(child: Text('No posts yet'));
          }

          return RefreshIndicator(
            onRefresh: () async => _loadPosts(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount:
                  state.posts.results.length +
                  (state.posts.links.next != null ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.posts.results.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final post = state.posts.results[index];
                return ForumPostItem(
                  post: post,
                  onLike: () {
                    context.read<ForumBloc>().add(LikePost(post.id));
                  },
                  onUnlike: () {
                    context.read<ForumBloc>().add(UnlikePost(post.id));
                  },
                  onComment: () {
                    // TODO: Show comment dialog
                  },
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
