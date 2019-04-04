import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../models/product.dart';
import '../utils/is_dark.dart';

import '../../blocs/bloc.dart';
import '../../blocs/main_bloc.dart';

class ProductSquare extends StatelessWidget {
  final Product product;

  ProductSquare({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainBloc _mainBloc = BlocProvider.of<MainBloc>(context);
    return Material(
      color: product.color,
      child: InkWell(
        onTap: () => _mainBloc.cartAddition(product),
        child: Center(
          child: Text(
            product.name,
            style: TextStyle(
              color: isDark(product.color) ? Colors.white : Colors.black
            ),
          )
        ),
      ),
    );
  }
}
