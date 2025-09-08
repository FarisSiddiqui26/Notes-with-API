import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/post.dart';

class PostsService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts({int start = 0, int limit = 10}) async {
    try {
      final response = await _dio.get('$_baseUrl/posts?_start=$start&_limit=$limit');
      return (response.data as List).map((json) => Post.fromJson(json)).toList();
    } on DioException {
      throw Exception('Failed to load posts.');
    }
  }
}

final postsServiceProvider = Provider<PostsService>((ref) => PostsService());