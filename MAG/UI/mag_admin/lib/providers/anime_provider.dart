import 'package:mag_admin/providers/base_provider.dart';

import '../models/anime.dart';

class AnimeProvider extends BaseProvider<Anime> {
  AnimeProvider() : super("Anime");

  @override
  Anime fromJson(data) {
    return Anime.fromJson(data);
  }
}
