import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../common/models/tab_model.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: TabModel.tabKey,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.cart ? Icons.list : Icons.show_chart,
            key: tab == AppTab.cart
                ? TabModel.tabCartKey
                : TabModel.tabStatsKey,
            color: Colors.grey,
          ),
          activeIcon: Icon(
            tab == AppTab.cart ? Icons.list : Icons.show_chart,
            key: tab == AppTab.cart
                ? TabModel.tabCartKey
                : TabModel.tabStatsKey,
            color: Colors.grey[700],
          ),
          title: Text(tab == AppTab.stats
              ? "Stats"
              : "Cart",
            style: TextStyle(color: Colors.grey[700]),
          ),
        );
      }).toList(),
    );
  }
}