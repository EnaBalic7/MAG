import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_comment_action.dart';
import '../providers/base_provider.dart';
import '../utils/util.dart';

class UserCommentActionProvider extends BaseProvider<UserCommentAction> {
  final String _endpoint = "UserCommentAction";
  UserCommentActionProvider() : super("UserCommentAction");

  @override
  UserCommentAction fromJson(data) {
    return UserCommentAction.fromJson(data);
  }

  Future<void> saveUserAction(int commentId, String action) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('comment_$commentId', action);

    await _sendUserActionToServer(commentId, action);
  }

  Future<String?> getUserAction(int commentId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('comment_$commentId');
  }

  Future<void> _sendUserActionToServer(int commentId, String action) async {
    var url = "${BaseProvider.baseUrl}$_endpoint/action/$commentId";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode({
      "action": action,
      "userId": LoggedUser.user!.id,
      "commentId": commentId,
    });
    var response = await http!.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      notifyListeners();
    } else {
      throw Exception("Unknown error");
    }
  }
}
