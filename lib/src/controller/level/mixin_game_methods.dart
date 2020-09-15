import 'dart:ui';

import 'mixin_game_actions.dart';

mixin MixinGameMethods on MixinGameActions{
  Future init();
  void resize();
  void render(Canvas canvas);
  void update(double dt);

}