import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';

class CreditoWidget extends StatefulWidget {
  final Map element;

  const CreditoWidget({Key key, @required this.element}) : super(key: key);

  @override
  State<CreditoWidget> createState() => _CreditoWidgetState();
}

class _CreditoWidgetState extends State<CreditoWidget> {
  final List<Widget> list = [];

  @override
  Widget build(BuildContext context) => Card(
        borderOnForeground: true,
        elevation: 1,
        color: Colors.black45,
        child: ExpansionTile(
          onExpansionChanged: _loadTile,
          title: Text(widget.element['Name'] ?? '',
              style: new TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold)),
          children: list,
        ),
      );

  void _loadTile(bool b) async {
    final animations = (widget.element['Animations'] as List);

    final first = animations?.first;
    final last = animations?.last;

    setState(() {
      if (b && this.list.length <= 0) {
        final leading = Flame.util.animationAsWidget(
            Position(
                first.textureWidth.toDouble(), first.textureHeight.toDouble()),
            first.createAnimation(0, loop: true, stepTime: 0.05));
        final trailing = first != last
            ? Flame.util.animationAsWidget(
                Position(last.textureWidth.toDouble(),
                    last.textureHeight.toDouble()),
                last.createAnimation(0, loop: true, stepTime: 0.05))
            : leading;

        this.list
          ..add(Card(
            borderOnForeground: true,
            elevation: 0,
            child: ListTile(
              leading: leading,
              title: Text('By',
                  style:
                      new TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
              subtitle: Text(widget.element['By'],
                  style: new TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
              trailing: trailing,
            ),
          ));
      }
    });
  }
}
