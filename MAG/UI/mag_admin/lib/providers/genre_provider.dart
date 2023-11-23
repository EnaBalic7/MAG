import 'package:mag_admin/providers/base_provider.dart';

import '../models/genre.dart';

class GenreProvider extends BaseProvider<Genre> {
  GenreProvider() : super("Genre");

  @override
  Genre fromJson(data) {
    return Genre.fromJson(data);
  }
}
