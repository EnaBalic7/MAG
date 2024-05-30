import '../models/club_cover.dart';
import '../providers/base_provider.dart';

class ClubCoverProvider extends BaseProvider<ClubCover> {
  ClubCoverProvider() : super("ClubCover");

  @override
  ClubCover fromJson(data) {
    return ClubCover.fromJson(data);
  }
}
