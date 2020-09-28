import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';

class DialogEmojiPage extends StatefulWidget {
  const DialogEmojiPage({Key key, this.accept}) : super(key: key);

  static Future<String> call(BuildContext context) async {
    String _emoji;

    final page = DialogEmojiPage(
      accept: (e) {
        _emoji = e?.emoji;
        Navigator.of(context).pop();
      },
    );

    await showDialog(context: context, builder: (context) => page);

    return _emoji;
  }

  final Function(Emoji) accept;

  @override
  State<StatefulWidget> createState() => _DialogEmojiPageState();
}

class _DialogEmojiPageState extends State<DialogEmojiPage> {
  Emoji _selected;
  Category _category = Category.SMILEYS;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            elevation: 1,
            color: Colors.white70,
            borderOnForeground: true,
            child: Text(
              (_selected?.emoji) ?? "",
              style: TextStyle(fontSize: 50),
            ),
          ),
          EmojiPicker(
            
            rows: 3,
            buttonMode: ButtonMode.MATERIAL,
            noRecentsText: "Sem emojis recentemente!",
            indicatorColor: Colors.black54,
            selectedCategory: _category,
            // noRecentsStyle: TextStyle(fontWeight: FontWeight.bold, ),
            onEmojiSelected: (emoji, category) {
              final current = emoji;
              setState(() {
                _selected = current;
                _category = category;
              });
            },
          ),
          RaisedButton.icon(
              onPressed: () => widget.accept(_selected),
              icon: Icon(
                Icons.touch_app,
                size: 30,
              ),
              label: Text(
                "Confirmar",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),)
        ],
      ),
    );
  }
}
