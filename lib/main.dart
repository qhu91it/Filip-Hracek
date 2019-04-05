import 'package:flutter/material.dart';
import 'common/widgets/cart_page.dart';
import 'common/widgets/cart_button.dart';
import 'common/widgets/product_square.dart';
import 'common/widgets/theme.dart';

import 'blocs/bloc.dart';
import 'blocs/main_bloc.dart';
import 'blocs/tab_bloc.dart';

void main() => runApp(
    MyApp()
//  StateBuilder(
//    initState: (_) => { mainBloc = MainBloc(), tabBloc = TabBloc() },
//    dispose: (_) => { mainBloc = null, tabBloc.dispose(), tabBloc = null },
//    builder: (_) => MyApp(),
//  ),
);

class MyApp extends StatelessWidget {
  final mainBloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    print("MyApp build");
    return BlocProvider(
      bloc: mainBloc,
      child: MaterialApp(
        title: 'SetState',
        theme: appTheme,
        home: MyHomePage(),
        routes: <String, WidgetBuilder>{
          "/cart": (context) => BlocProvider(
            bloc: TabBloc(),
            child: CartPage(mainBloc.pageCount)
          )
        },
      )
    );
  }
}

/// The sample app's main page
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MyHomePage build");
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc"),
        actions: <Widget>[
          CartButton()
        ],
      ),
      body: ProductGrid(),
    );
  }
}

/// Displays a tappable grid of products
class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("ProductGrid build");
    final MainBloc _mainBloc = BlocProvider.of<MainBloc>(context);

    return StateBuilder(
      initState: (state) => _mainBloc.init(state),
      builder: (_) => _mainBloc.isLoaded
        ? GridView.count(
            physics: const AlwaysScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: _mainBloc.products.map(
              (product) {
                return ProductSquare(
                  product: product,
                );
              },
            ).toList(),
          )
        : Center(
            child: CircularProgressIndicator(),
          ),
    );
  }
}
