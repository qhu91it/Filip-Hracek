import 'package:flutter/material.dart';

import 'package:animator/animator.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import '../../blocs/main_bloc.dart';
import '../../blocs/bloc_provider.dart';

class CartButton extends StatelessWidget {
  final String cardName;
  final Color badgeColor;
  final Color badgeTextColor;

  CartButton({
    Key key,
    this.cardName = "0",
    this.badgeColor: Colors.red,
    this.badgeTextColor: Colors.white,
  })  : assert(badgeColor != null),
        assert(badgeTextColor != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainBloc = BlocProvider.of<MainBloc>(context);
    return StateBuilder(
      stateID: "cartButtonState_$cardName",
      blocs: [mainBloc,],
      builder: (_) {
        return IconButton(
          icon: Stack(
            overflow: Overflow.visible,
            children: [
              Icon(Icons.shopping_cart),
              Positioned(
                top: -8.0,
                right: -3.0,
                child: Animator(
                  tween: Tween<Offset>(begin: const Offset(-0.5, 0.9), end: const Offset(0.0, 0.0)),
                  duration: Duration(milliseconds: 100),
                  cycles: 1,
                  builder: (anim) => SlideTransition(
                    position: anim,
                    child: Material(
                        type: MaterialType.circle,
                        elevation: 2.0,
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            mainBloc.itemCount.toString(),
                            style: TextStyle(
                              fontSize: 13.0,
                              color: badgeTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                    ),
                  ),
                )
              ),
            ],
          ),
          onPressed: () => Navigator.of(context).pushNamed("/cart"),
        );
      },
    );
  }
}
