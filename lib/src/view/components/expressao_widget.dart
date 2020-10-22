import 'package:flutter/material.dart';

class ExpressaoWidget extends StatelessWidget {
  final int id;
  final String expressao;
  final Function onTap;

  const ExpressaoWidget({Key key, this.id = 0, this.expressao, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.black, width: 3),
        ),
        child: Stack(
          children: <Widget>[
            // _buildImageSized(image: AnotherConsts.BG_TIMER),
            ListTile(
              key: Key(id.toString() + expressao),
              title: Text(
                this.expressao,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              subtitle: Text(
                "Selecione-me.",
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.end,
              ),
              dense: true,
              onTap: onTap,
            ),
          ],
        ));
  }

  // Widget _buildImageSized(
  //     {String image,
  //     BoxFit fit = BoxFit.fill,
  //     // double maxHeight = double.infinity,
  //     // double maxWidth = double.infinity,
  //     Color color}) {
  //   return Image.asset(
  //     'assets/images/' + image.toString(),
  //     color: color,
  //     fit: fit,
  //     // width: maxWidth,
  //     // height: maxHeight,
  //     colorBlendMode: BlendMode.modulate,
  //   );
  // }
}
