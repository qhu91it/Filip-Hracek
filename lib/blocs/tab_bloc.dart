import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import '../common/models/tab_model.dart';

class TabBloc extends StatesRebuilder {

  PageController tabController;

  AppTab _tab;
  get activeTab => _tab;
  int get activeIndex {
    switch (_tab) {
      case AppTab.cart:
        return 0;
      case AppTab.stats:
        return 1;
      default:
        return 0;
    }
  }

  TabBloc() : super() {
    _tab = AppTab.cart;
    tabController = PageController();
  }

  moveTab(AppTab tab) {
    _tab = tab;
    tabController.animateToPage(activeIndex, duration: kTabScrollDuration, curve: Curves.ease);
    rebuildStates(ids: ["tabState"]);
  }

  updateTabAtPage(int page) {
    switch (page) {
      case 0:
        _tab = AppTab.cart;
        break;
      case 1:
        _tab = AppTab.stats;
        break;
    }
    rebuildStates(ids: ["tabState"]);
  }

  @override
  void dispose() {
    tabController.dispose();
    if (mounted) {
      super.dispose();
    }
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return super.toString();
  }
}

TabBloc tabBloc;