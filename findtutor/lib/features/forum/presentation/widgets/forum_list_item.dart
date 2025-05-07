import 'package:flutter/material.dart';
import 'package:findtutor/core/models/forum.dart';

class ForumListItem extends StatelessWidget {
  final Forum forum;
  final VoidCallback onJoin;
  final VoidCallback onLeave;
  final VoidCallback onFollow;
  final VoidCallback onUnfollow;

  const ForumListItem({
    super.key,
    required this.forum,
    required this.onJoin,
    required this.onLeave,
    required this.onFollow,
    required this.onUnfollow,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        forum.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        forum.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                if (forum.isPrivate) const Icon(Icons.lock, color: Colors.grey),
              ],
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
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onFollow,
                  icon: const Icon(Icons.favorite_border),
                  label: const Text('Follow'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: onJoin,
                  icon: const Icon(Icons.login),
                  label: const Text('Join'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
    );
  }
}
