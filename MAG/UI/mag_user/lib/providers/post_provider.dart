import 'dart:convert';

import 'package:mag_user/utils/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/base_provider.dart';
import '../models/post.dart';
import 'package:http/http.dart' as http;

class PostProvider extends BaseProvider<Post> {
  PostProvider() : super("Post");

  @override
  Post fromJson(data) {
    return Post.fromJson(data);
  }

  Future<void> toggleLike(Post post) async {
    String? userAction = await _getUserAction(post.id!);

    if (userAction == 'like') {
      post.likesCount = post.likesCount! - 1;
      await _saveUserAction(post.id!, 'none');
    } else {
      if (userAction == 'dislike') {
        post.dislikesCount = post.dislikesCount! - 1;
      }

      post.likesCount = post.likesCount! + 1;
      await _saveUserAction(post.id!, 'like');
    }

    notifyListeners();
    _updatePostOnServer(post);
  }

  Future<void> toggleDislike(Post post) async {
    String? userAction = await _getUserAction(post.id!);

    if (userAction == 'dislike') {
      post.dislikesCount = post.dislikesCount! - 1;
      await _saveUserAction(post.id!, 'none');
    } else {
      if (userAction == 'like') {
        post.likesCount = post.likesCount! - 1;
      }

      post.dislikesCount = post.dislikesCount! + 1;
      await _saveUserAction(post.id!, 'dislike');
    }

    notifyListeners();
    _updatePostOnServer(post);
  }

  Future<void> _saveUserAction(int postId, String action) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('post_$postId', action);
    // Send the action to the server
    await _sendUserActionToServer(postId, action);
  }

  Future<String?> _getUserAction(int postId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('post_$postId');
  }

  Future<void> _sendUserActionToServer(int postId, String action) async {
    final username = Authorization.username;
    final password = Authorization.password;

    final credentials = base64Encode(utf8.encode('$username:$password'));

    final response = await http.post(
      Uri.parse('https://yourapi.com/api/posts/action/$postId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic $credentials',
      },
      body: jsonEncode({
        'action': action,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send user action to server');
    }
  }

  Future<void> _updatePostOnServer(Post post) async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final password = prefs.getString('password');

    final credentials = base64Encode(utf8.encode('$username:$password'));

    final response = await http.put(
      Uri.parse('https://yourapi.com/api/posts/${post.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic $credentials',
      },
      body: jsonEncode({
        'likesCount': post.likesCount,
        'dislikesCount': post.dislikesCount,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update post on server');
    }
  }
}
