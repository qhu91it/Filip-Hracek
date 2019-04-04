import 'package:flutter/material.dart';

import '../utils/is_dark.dart';

import '../../blocs/bloc.dart';
import '../../blocs/main_bloc.dart';
import '../../blocs/tab_bloc.dart';
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
    print("CartPage build");
    final TabBloc _tabBloc = BlocProvider.of<TabBloc>(context);
    return StateBuilder(
      blocs: [_tabBloc],
      dispose: (_) => _tabBloc.dispose(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
            actions: <Widget>[
              CartButton(cardName: "1")
            ]
        ),
        body: PageView.builder(
          controller: _tabBloc.tabController,
          itemCount: _children.length,
          itemBuilder: (context, page) => _children[page],
          onPageChanged: (page) => _tabBloc.updateTabAtPage(page),
        ), /*PageView(
          controller: _tabBloc.tabController,
          children: _children,
          onPageChanged: (page) => _tabBloc.updateTabAtPage(page)
        )*/ /*StateBuilder(
        stateID: "tabBodyState",
        blocs: [_tabBloc],
        builder: (_) => _children[_tabBloc.activeIndex],
      ),*/
        bottomNavigationBar: TabBody(),
      ),
    );
  }
}

class CartPageBody extends StatefulWidget {
  @override
  _CartPageBodyState createState() => _CartPageBodyState();
}

class _CartPageBodyState extends State<CartPageBody> with AutomaticKeepAliveClientMixin<CartPageBody> {

  @override
  void initState() {
    print("_CartPageBodyState initState");
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print("_CartPageBodyState build");
    final MainBloc _mainBloc = BlocProvider.of<MainBloc>(context);
    return StateBuilder(
      stateID: "cartPageBodyState",
      blocs: [_mainBloc],
      builder: (_) => _mainBloc.items.isEmpty
        ? Center(
          child: Text('Empty', style: Theme.of(context).textTheme.display1),
        )
        : ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _mainBloc.items.length,
          itemBuilder: (_, index) => ItemTile(index),
        ),
    );
  }
}

//class CartPageBody extends StatelessWidget {
//  CartPageBody() : super() {
//    print("CartPageBody init");
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    print("CartPageBody build");
//    return StateBuilder(
//      key: PageStorageKey<String>("CartPageBody"),
//      stateID: "cartPageBodyState",
//      blocs: [mainBloc],
//      builder: (_) => mainBloc.items.isEmpty
//        ? Center(
//            child: Text('Empty', style: Theme.of(context).textTheme.display1),
//          )
//        : ListView.builder(
//            physics: const AlwaysScrollableScrollPhysics(),
//            itemCount: mainBloc.items.length,
//            itemBuilder: (_, index) => ItemTile(index),
//          ),
//    );
//  }
//}

class StatsBodyPage extends StatefulWidget {
  @override
  _StatsBodyPageState createState() => _StatsBodyPageState();
}

class _StatsBodyPageState extends State<StatsBodyPage> with AutomaticKeepAliveClientMixin<StatsBodyPage> {

  @override
  void initState() {
    print("_StatsBodyPageState initState");
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    print("_StatsBodyPageState build");
    return Center(
      child: Text("AAAAA"),
    );
  }
}


//class StatsBodyPage extends StatelessWidget {
//  StatsBodyPage() : super() {
//    print("StatsBodyPage init");
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    print("StatsBodyPage build");
//    return Center(
//      key: PageStorageKey<String>("StatsBodyPage"),
//      child: Text("AAAAA"),
//    );
//  }
//}

class TabBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final TabBloc _tabBloc = BlocProvider.of<TabBloc>(context);
    return StateBuilder(
      stateID: "tabState",
      blocs: [_tabBloc],
      builder: (_) => TabSelector(
        activeTab: _tabBloc.activeTab,
        onTabSelected: (tab) => _tabBloc.moveTab(tab),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  ItemTile(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    final MainBloc _mainBloc = BlocProvider.of<MainBloc>(context);
    final textStyle = TextStyle(
      color: isDark(_mainBloc.items[index].product.color)
        ? Colors.white
        : Colors.black);

    return StateBuilder(
      blocs: [_mainBloc],
      builder: (state) => Container(
        color: _mainBloc.items[index].product.color,
        child: ListTile(
          title: Text(
            _mainBloc.items[index].product.name,
            style: textStyle,
          ),
          trailing: CircleAvatar(
            backgroundColor: const Color(0x33FFFFFF),
            child: Text(
                _mainBloc.items[index].count.toString(),
              style: textStyle
            )
          ),
          onTap: () => _mainBloc.cartRemoval(_mainBloc.items[index], state),
        ),
      ),
    );
  }
}
