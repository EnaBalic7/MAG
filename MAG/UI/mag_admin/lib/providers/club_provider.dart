import 'package:mag_admin/providers/base_provider.dart';

import '../models/club.dart';

class ClubProvider extends BaseProvider<Club> {
  ClubProvider() : super("Club");

  @override
  Club fromJson(data) {
    return Club.fromJson(data);
  }
}
