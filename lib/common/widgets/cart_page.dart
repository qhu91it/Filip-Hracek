import 'package:flutter/material.dart';

import '../utils/is_dark.dart';

import 'package:states_rebuilder/states_rebuilder.dart';
import '../../blocs/bloc_provider.dart';
import '../../blocs/main_bloc.dart';
import '../../blocs/tab_bloc.dart';
import '../../blocs/animation_bloc.dart';
import '../../common/widgets/cart_button.dart';
import 'tab_selector.dart';

class CartPage extends StatelessWidget {

  final List<Widget> _children = <Widget>[
    CartPageBody(),
    StatsBodyPage()
//    Offstage(
//      offstage: tabBloc.activeIndex() != 0,
//      child: TickerMode(
//        enabled: tabBloc.activeIndex() == 0,
//        child: CartPageBody(),
//      ),
//    ),
//    Offstage(
//      offstage: tabBloc.activeIndex() != 1,
//      child: TickerMode(
//        enabled: tabBloc.activeIndex() == 1,
//        child: StatsBodyPage(),
//      ),
//    ),
  ];

  @override
  Widget build(BuildContext context) {
    final tabBloc = BlocProvider.of<TabBloc>(context);
    return StateBuilder(
      blocs: [tabBloc],
      dispose: (_) => tabBloc.dispose(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
            actions: <Widget>[
              CartButton(cardName: "1")
            ]
        ),
        body: PageView(
          controller: tabBloc.tabController,
          children: _children,
        ), /*StateBuilder(
        stateID: "tabBodyState",
        blocs: [tabBloc],
        builder: (_) => _children[tabBloc.activeIndex],//_dynamicBody(),
      ),*/
        bottomNavigationBar: TabBody(),
      ),
    );
  }
}

class CartPageBody extends StatelessWidget {
  CartPageBody() : super() {
    print("CartPageBody init");
  }

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context);
    return StateBuilder(
      key: PageStorageKey<String>("CartPageBody"),
      stateID: "cartPageBodyState",
      blocs: [mainBloc],
      builder: (_) => mainBloc.items.isEmpty
          ? Center(
              child: Text('Empty', style: Theme.of(context).textTheme.display1),
            )
          : ListView.builder(
              itemCount: mainBloc.items.length,
              itemBuilder: (_, index) => ItemTile(index),
            ),
    );
  }
}

class StatsBodyPage extends StatelessWidget {
  StatsBodyPage() : super() {
    print("StatsBodyPage init");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      key: PageStorageKey<String>("StatsBodyPage"),
      child: Text("AAAAA"),
    );
  }
}

class TabBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabBloc = BlocProvider.of<TabBloc>(context);
    return StateBuilder(
      stateID: "tabState",
      blocs: [tabBloc],
      builder: (_) => TabSelector(
        activeTab: tabBloc.activeTab,
        onTabSelected: (tab) => tabBloc.updateTab(tab),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  ItemTile(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context);

    final textStyle = TextStyle(
        color: isDark(mainBloc.items[index].product.color)
            ? Colors.white
            : Colors.black);

    return StateBuilder(
      builder: (state) => Container(
            color: mainBloc.items[index].product.color,
            child: ListTile(
              title: Text(
                mainBloc.items[index].product.name,
                style: textStyle,
              ),
              trailing: CircleAvatar(
                  backgroundColor: const Color(0x33FFFFFF),
                  child: Text(mainBloc.items[index].count.toString(),
                      style: textStyle)),
              onTap: () => mainBloc.cartRemoval(mainBloc.items[index], state),
            ),
          ),
    );
  }
}
