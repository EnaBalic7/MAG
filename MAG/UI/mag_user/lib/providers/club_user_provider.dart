import '../providers/base_provider.dart';
import '../models/club_user.dart';

class ClubUserProvider extends BaseProvider<ClubUser> {
  ClubUserProvider() : super("ClubUser");

  @override
  ClubUser fromJson(data) {
    return ClubUser.fromJson(data);
  }
}
