import 'package:flutter/material.dart';

import '../utils/is_dark.dart';

import '../../blocs/bloc.dart';
import '../../blocs/main_bloc.dart';
import '../../blocs/tab_bloc.dart';
import '../../common/widgets/cart_button.dart';
import 'tab_selector.dart';

class CartPage extends StatelessWidget {
  final int page;
  CartPage(this.page) : super();

  @override
  Widget build(BuildContext context) {
    print("CartPage build");
    final TabBloc _tabBloc = BlocProvider.of<TabBloc>(context);
    final MainBloc _mainBloc = BlocProvider.of<MainBloc>(context);

    final List<Widget> _children = <Widget>[
      CartPageBody(page),
      StatsBodyPage(page)
    ];

    return StateBuilder(
      blocs: [_mainBloc, _tabBloc],
      dispose: (_) => {
        _tabBloc.dispose()
      },
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
            actions: <Widget>[
              CartButton(cardName: "$page")
            ]
        ),
        body: WillPopScope(
          child: PageView.builder(
            controller: _tabBloc.tabController,
            itemCount: _children.length,
            itemBuilder: (context, page) => _children[page],
              onPageChanged: (page) => _tabBloc.updateTabAtPage(page),
          ),
          onWillPop: () async {
            _mainBloc.pageCount -= 1;
            return true;
          }
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
  final int page;
  CartPageBody(this.page) : super();

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
    final MainBloc _mainBloc = BlocProvider.of<MainBloc>(context);
    if (_mainBloc.pageCount > widget.page) {
      return Container();
    }
    print("_CartPageBodyState build");
    return StateBuilder(
      key: PageStorageKey<String>("CartPageBody"),
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
//    final MainBloc _mainBloc = BlocProvider.of<MainBloc>(context);
//    return StateBuilder(
//      key: PageStorageKey<String>("CartPageBody"),
//      stateID: "cartPageBodyState",
//      blocs: [_mainBloc],
//      builder: (_) => _mainBloc.items.isEmpty
//        ? Center(
//            child: Text('Empty', style: Theme.of(context).textTheme.display1),
//          )
//        : ListView.builder(
//            physics: const AlwaysScrollableScrollPhysics(),
//            itemCount: _mainBloc.items.length,
//            itemBuilder: (_, index) => ItemTile(index),
//          ),
//    );
//  }
//}

class StatsBodyPage extends StatefulWidget {
  final int page;
  StatsBodyPage(this.page) : super();

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
    final MainBloc _mainBloc = BlocProvider.of<MainBloc>(context);
    if (_mainBloc.pageCount > widget.page) {
      return Container();
    }
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
