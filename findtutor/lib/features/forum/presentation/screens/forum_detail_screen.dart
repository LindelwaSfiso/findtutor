import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findtutor/core/models/forum.dart';
import 'package:findtutor/features/forum/presentation/widgets/forum_post_list.dart';
import 'package:findtutor/features/forum/presentation/widgets/create_post_dialog.dart';

import '../../bloc/forum_bloc.dart';

class ForumDetailScreen extends StatelessWidget {
  final Forum forum;

  const ForumDetailScreen({super.key, required this.forum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(forum.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              context.read<ForumBloc>().add(FollowForum(forum.id));
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<ForumBloc>().add(LeaveForum(forum.id));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  forum.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Wrap(
                  children: [
                    _buildInfoChip(
                      context,
                      Icons.people,
                      '${forum.membersCount} members',
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      context,
                      Icons.favorite,
                      '${forum.followersCount} followers',
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      context,
                      Icons.chat,
                      '${forum.membersCount} posts',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: ForumPostList(forumId: forum.id)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => CreatePostDialog(forumId: forum.id),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
