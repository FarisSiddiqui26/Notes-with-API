import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/post.dart';
import '../service/posts_service.dart';

final postsViewModelProvider = StateNotifierProvider<PostsViewModel, AsyncValue<List<Post>>>((ref) {
  final service = ref.watch(postsServiceProvider);
  return PostsViewModel(service);
});

class PostsViewModel extends StateNotifier<AsyncValue<List<Post>>> {
  final PostsService _service;
  int _page = 0;
  static const int _limit = 10;
  bool _isLoadingMore = false;

  PostsViewModel(this._service) : super(const AsyncValue.loading()) {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;

    state = const AsyncValue.loading();
    try {
      final newPosts = await _service.fetchPosts(start: _page * _limit, limit: _limit);
      _page++;
      state = AsyncValue.data(newPosts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> loadMore() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;

    try {
      final newPosts = await _service.fetchPosts(start: _page * _limit, limit: _limit);
      if (newPosts.isNotEmpty) {
        final currentPosts = state.value ?? [];
        state = AsyncValue.data([...currentPosts, ...newPosts]);
        _page++;
      }
    } catch (e, st) {
      // Handle error state for loading more
    } finally {
      _isLoadingMore = false;
    }
  }
}