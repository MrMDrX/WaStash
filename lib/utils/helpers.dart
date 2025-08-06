import 'package:flutter/material.dart';
import 'package:heroine/heroine.dart';

final springNotifier = ValueNotifier(Spring.bouncy);
final flightShuttleNotifier = ValueNotifier<HeroineShuttleBuilder>(
  const FlipShuttleBuilder(),
);
final adjustSpringTimingToRoute = ValueNotifier(false);
