import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes/features/notes/widgets/post_card.dart';
import 'package:shimmer/shimmer.dart';
import '../viewmodel/posts_viewmodel.dart';
// import 'post_card.dart';

class PostsView extends ConsumerWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsyncValue = ref.watch(postsViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('API Posts')),
      body: postsAsyncValue.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const Center(child: Text('No posts found.'));
          }
          return ListView.builder(
            itemCount: posts.length + 1,
            itemBuilder: (context, index) {
              if (index < posts.length) {
                return PostCard(post: posts[index]);
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => ref.read(postsViewModelProvider.notifier).loadMore(),
                      child: const Text('Load More'),
                    ),
                  ),
                );
              }
            },
          );
        },
        loading: () => ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: const PostCardPlaceholder(), // A placeholder widget
          ),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              ElevatedButton(
                onPressed: () => ref.read(postsViewModelProvider.notifier).fetchPosts(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// A simple placeholder widget for the loading state
class PostCardPlaceholder extends StatelessWidget {
  const PostCardPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 20, color: Colors.white),
            const SizedBox(height: 8),
            Container(height: 10, width: 150, color: Colors.white),
          ],
        ),
      ),
    );
  }
}