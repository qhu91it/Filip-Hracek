import 'dart:math';
import 'package:flutter/material.dart';

import 'package:animator/animator.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class AnimationBloc extends StatesRebuilder {

  static final double pi2 = 2 * pi;

  final badgePositionAnimation = AnimationSetup(
    tweenMap: {
      "opacityAnim": Tween<double>(begin: 0.5, end: 1),
      "rotationAnim": Tween<double>(begin: 0, end: pi2),
      "translateAnim": Tween<Offset>(begin: Offset.zero, end: const Offset(1, 0)),
      "positionAnim": Tween<Offset>(begin: const Offset(-0.5, 0.9), end: const Offset(0.0, 0.0))
    },
    duration: Duration(microseconds: 100),
  );

  init() {
    badgePositionAnimation.initAnimation(
      bloc: this,
      ids: ["PositionWidget"],
      cycles: 1,
      endAnimationListener: (_) => print("animation finished"),
    );
  }
}

//AnimationBloc animationBloc;