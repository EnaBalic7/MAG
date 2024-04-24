import '../providers/base_provider.dart';
import '../models/list.dart';

class ListProvider extends BaseProvider<List> {
  ListProvider() : super("List");

  @override
  List fromJson(data) {
    return List.fromJson(data);
  }
}
