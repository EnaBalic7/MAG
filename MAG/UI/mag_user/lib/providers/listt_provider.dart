import '../providers/base_provider.dart';
import '../models/listt.dart';

class ListtProvider extends BaseProvider<Listt> {
  ListtProvider() : super("List");

  @override
  Listt fromJson(data) {
    return Listt.fromJson(data);
  }
}
