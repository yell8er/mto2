import 'package:flutter/foundation.dart';

import '../models/object_card.dart';

class ObjectProvider with ChangeNotifier {
  List<ObjectCard> _items = [];

  List<ObjectCard> get item {
    return [..._items];
  }
}
