import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import '../common/models/cart_item.dart';
import '../common/models/cart.dart';
import '../common/models/catalog.dart';
import '../common/models/product.dart';

class MainBloc extends StatesRebuilder {
  List<Product> products;
  List<CartItem> items = <CartItem>[];
  int itemCount = 0;
  bool isLoaded = false;
  int pageCount = 0;

  final cart = Cart();

  init(state) async {
    final Catalog catalog = await fetchCatalog();
    products = catalog.products;
    isLoaded = true;
    rebuildStates(states: [state]);
  }

  cartAddition(Product product) {
    cart.add(product);
    items = cart.items;
    itemCount = cart.itemCount;
    rebuildStates(ids: ["cartButtonState_0", "cartButtonState_1"]);
  }

  cartRemoval(CartItem item, state) {
    cart.remove(item.product);
    items = cart.items;
    itemCount = cart.itemCount;
    item.count > 1
        ? rebuildStates(ids: ["cartButtonState_1"], states: [state])
        : rebuildStates(ids: ["cartPageBodyState", "cartButtonState_1"]);
  }

  getIcon() => (itemCount > 2) ? Icon(Icons.add) : Text("noop");

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return super.toString();
  }
}

//MainBloc mainBloc;
