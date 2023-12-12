import 'package:mag_admin/models/user_profile_picture.dart';
import 'package:mag_admin/providers/base_provider.dart';

class UserProfilePictureProvider extends BaseProvider<UserProfilePicture> {
  UserProfilePictureProvider() : super("UserProfilePicture");

  @override
  UserProfilePicture fromJson(data) {
    return UserProfilePicture.fromJson(data);
  }
}
