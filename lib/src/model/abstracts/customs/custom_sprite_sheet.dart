import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'custom_sprite_animation.dart';

/// Baseado no package:flame/spritesheet.dart, Customizado para mais Completude
/// Devido a SpriteSheets mais complexos ordenados por Matriz com inumeros sprites
class CustomSpriteSheet {
  String imageName;
  int textureWidth;
  int textureHeight;
  int columns;
  int rows;

  int ignoreFirsts;
  int ignoreLasts;

  List<List<Sprite>> _sprites;

  CustomSpriteSheet({
    this.imageName,
    this.textureWidth,
    this.textureHeight,
    this.columns,
    this.rows,
    this.ignoreFirsts = 0,
    this.ignoreLasts = 0,
    int initialX = 0,
    int initialY = 0,
    int jumpPixelX = 0,
    int jumpPixelY = 0,
  }) {
    _sprites = List.generate(
        rows,
        (y) => List.generate(
            columns,
            (x) => Sprite(imageName,
                x: (initialX + (x * textureWidth) + (x * jumpPixelX))
                    .toDouble(),
                y: (initialY + (y * textureHeight) + (y * jumpPixelY))
                    .toDouble(),
                width: textureWidth.toDouble(),
                height: textureHeight.toDouble())));

    assert(ignoreFirsts >= 0 && ignoreLasts >= 0,
        'Somente positivos são permitidos nos parametros ignoreFirsts e ignoreLasts');
  }

  CustomSpriteSheet.fromMapPositions({
    this.imageName,
    this.textureWidth,
    this.textureHeight,
    List<Map<String, int>> positions,
  }) {
    assert(positions != null && positions.length > 0);
    
    this.ignoreFirsts = 0;
    this.ignoreLasts = 0;
    
    rows ??= 1;
    columns ??= positions.length;

    _sprites = List.generate(
        rows,
        (row) => List.generate(
            columns,
            (col) => Sprite(imageName,
                x: positions[col]['x'].toDouble(),
                y: positions[col]['y'].toDouble(),
                width: textureWidth.toDouble(),
                height: textureHeight.toDouble())));
  }

  Sprite getSprite(int row, int column) {
    final Sprite s = _sprites[row][column];

    assert(
        s != null, 'Nenhum sprite encontrado na linha $row e coluna $column');

    return s;
  }

  /// Documentação similar a do metodo
  /// ```dart
  /// Animation createAnimation(int fromRow,
  ///  {double stepTime,
  ///  bool loop = true,
  ///  int from = 0,
  ///  int to,
  ///  int toRow,
  ///  int toColumn});
  /// ```
  /// Diferenciando-se no tipo de retorno
  List<SpriteComponent> mySpriteComponentList(
      {int fromRow = 0, int from = 0, int to, int toRow, int toColumn}) {
    final spriteList = mySpriteList(
        fromRow: fromRow, from: from, to: to, toRow: toRow, toColumn: toColumn);
    return List.generate(
        spriteList.length,
        (i) => SpriteComponent.fromSprite(
            textureWidth.toDouble(), textureHeight.toDouble(), spriteList[i]));
  }

  /// Documentação similar a do metodo
  /// ```dart
  /// Animation createAnimation(int fromRow,
  ///  {double stepTime,
  ///  bool loop = true,
  ///  int from = 0,
  ///  int to,
  ///  int toRow,
  ///  int toColumn});
  /// ```
  /// Diferenciando-se no tipo de retorno
  List<Sprite> mySpriteList(
      {int fromRow = 0, int from = 0, int to, int toRow, int toColumn}) {
    toRow ??= _sprites.length - 1;
    toColumn ??= _sprites[fromRow].length;

    assert(
        fromRow != null &&
            toRow != null &&
            toColumn != null &&
            toRow >= fromRow,
        'Não existe um indice de Sprites válido definido para '
        '[fromRow = $fromRow], [toRow = $toRow], [toColumn = $toColumn]');

    List<Sprite> spriteRow = [];

    for (int row = fromRow; row <= toRow; row++) {
      if (row == toRow)
        spriteRow.addAll(_sprites[row].sublist(0, toColumn));
      else
        spriteRow.addAll(_sprites[row]);
    }

    return spriteRow.sublist(
        from + ignoreFirsts, (to ??= spriteRow.length - 1) - ignoreLasts);
  }

  /// Cria uma animação a partir do SpriteSheet
  ///
  /// Os Parametros `from` e `to` indicam onde na coluna da SpriteRow se deve ser animado.
  /// Os Parametros `fromRow`, `toRow` e `toColumn` são respectivos à Matriz de animação para
  /// Sprites de uma mesma animação mas que não se encontram em uma mesma linha da Matriz.
  ///
  /// Ex, A matriz de Sprites esteja ordenada assim,
  ///
  /// `[0, 1, 2, 3]`
  ///
  /// `[4, 5, 6, 7]`
  ///
  /// `[8, 9, 10, 11]`
  ///
  /// A animação desejada inicia no Sprite 0 e termina no 9, Os parametros irão ficar assim:
  /// `from = 0`, `to = 9`, `fromRow = 0`, `toRow = 2` e `toColumn = 2`
  /// Assim os Sprites em `10` e `11` não são incluidos.
  ///
  /// `Notação*`
  ///
  /// Se nenhum `to` for definido o padrão é ser igual ao numero de colunas presentes na spriteRow.
  ///
  /// Se nenhum `toRow` for definido o padrão é ser igual ao fromRow animando somente uma linha da matriz
  ///
  /// Se nenhum `toColumn` for definido o padrão é ser igual ao numero de colunas na linha da matriz.
  ///
  CustomAnimation createAnimation(int fromRow,
      {double stepTime,
      bool loop = true,
      int from = 0,
      int to,
      int toRow,
      int toColumn}) {
    final spriteList = mySpriteList(
        fromRow: fromRow, from: from, to: to, toRow: toRow, toColumn: toColumn);

    return CustomAnimation.spriteList(
      spriteList,
      stepTime: stepTime,
      loop: loop,
    );
  }
}
