import 'package:flutter/material.dart';
import 'package:findtutor/core/models/forum.dart';
import 'package:timeago/timeago.dart' as timeago;

class ForumPostItem extends StatelessWidget {
  final ForumPost post;
  final VoidCallback onLike;
  final VoidCallback onUnlike;
  final VoidCallback onComment;

  const ForumPostItem({
    super.key,
    required this.post,
    required this.onLike,
    required this.onUnlike,
    required this.onComment,
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
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    post.author.profilePic ??
                        'https://via.placeholder.com/150',
                  ),
                  radius: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author.user.username,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        timeago.format(DateTime.now()),//post.createdAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(post.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(post.content, style: Theme.of(context).textTheme.bodyMedium),
            if (post.images.isNotEmpty) ...[
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: post.images.length,
                  itemBuilder: (context, index) {
                    final image = post.images[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          image.image,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            if (post.links.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    post.links.map((link) {
                      return Chip(
                        label: Text(link.title),
                        avatar: const Icon(Icons.link),
                        onDeleted: () {
                          // TODO: Handle link deletion
                        },
                      );
                    }).toList(),
              ),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: onLike,
                ),
                Text('${post.likesCount}'),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.comment_outlined),
                  onPressed: onComment,
                ),
                Text('${post.comments.length}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
