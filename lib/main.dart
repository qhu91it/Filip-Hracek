import 'package:flutter/material.dart';
import 'common/widgets/cart_page.dart';
import 'common/widgets/cart_button.dart';
import 'common/widgets/product_square.dart';
import 'common/widgets/theme.dart';

import 'package:states_rebuilder/states_rebuilder.dart';
import 'blocs/bloc_provider.dart';
import 'blocs/main_bloc.dart';
import 'blocs/tab_bloc.dart';

main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
      bloc: MainBloc(),
      child: MaterialApp(
        title: 'SetState',
        theme: appTheme,
        home: MyHomePage(),
        routes: <String, WidgetBuilder>{
          "/cart": (context) => BlocProvider<TabBloc>(
            bloc: TabBloc(),
            child: CartPage(),
          ),
        },
      ),
    );
  }
}

/// The sample app's main page
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    final mainBloc = BlocProvider.of<MainBloc>(context);
    return StateBuilder(
      initState: (state) => mainBloc.init(state),
      builder: (_) => mainBloc.isLoaded
          ? GridView.count(
              crossAxisCount: 2,
              children: mainBloc.products.map(
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
