import 'package:flutter/widgets.dart';

enum AppTab { cart, stats }

class TabModel {
  static final tabKey = const Key('TabKey');
  static final tabCartKey = const Key('TabCartKey');
  static final tabStatsKey = const Key('TabStatsKey');
}