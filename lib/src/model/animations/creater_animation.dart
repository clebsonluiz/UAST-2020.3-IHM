import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_sheet.dart';

class CreaterAnimation {
  final String spriteSheetName;

  const CreaterAnimation(this.spriteSheetName);

  CustomSpriteSheet createSpriteSheet(
          {int tWidth,
          int tHeight,
          int cols,
          int rows,
          int iX,
          int iY,
          int jumpPX,
          int jumpPY,
          int ignoreFirsts,
          int ignoreLasts}) =>
      CustomSpriteSheet(
          imageName: spriteSheetName,
          textureWidth: tWidth,
          textureHeight: tHeight,
          columns: cols,
          rows: rows,
          initialX: iX,
          initialY: iY,
          jumpPixelX: jumpPX,
          jumpPixelY: jumpPY,
          ignoreFirsts: ignoreFirsts ?? 0,
          ignoreLasts: ignoreLasts ?? 0);

  CustomSpriteSheet createSpriteSheetFromPositions({
    int tWidth,
    int tHeight,
    List<Map<String, int>> positions,
  }) =>
      CustomSpriteSheet.fromMapPositions(
          imageName: spriteSheetName,
          textureWidth: tWidth,
          textureHeight: tHeight,
          positions: positions);

  CustomAnimation createAnimations(
      {int textureWidth,
      int textureHeight,
      int columns,
      int rows,
      int initialX,
      int initialY,
      int jumpPixelX,
      int jumpPixelY,
      int ignoreFirsts,
      int ignoreLasts,
      int fromRow,
      double stepTime,
      bool loop = false,
      int from,
      int to,
      bool reversed = false}) {
    final spriteSheet = createSpriteSheet(
        tWidth: textureWidth,
        tHeight: textureHeight,
        cols: columns,
        rows: rows,
        iX: initialX,
        iY: initialY,
        jumpPX: jumpPixelX,
        jumpPY: jumpPixelY,
        ignoreFirsts: ignoreFirsts ?? 0,
        ignoreLasts: ignoreLasts ?? 0);
    if (reversed)
      return spriteSheet
          .createAnimation(fromRow,
              from: from, to: to, stepTime: stepTime, loop: loop)
          .reversed();
    else
      return spriteSheet.createAnimation(fromRow,
          from: from, to: to, stepTime: stepTime, loop: loop);
  }
}
