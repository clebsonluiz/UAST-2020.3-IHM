import 'package:flutter/material.dart';

class DpadWidget extends StatefulWidget {

  final Widget topButtom;
  final List<Widget> botoesDirecionais;
  final List<Widget> botoesAcao;

  const DpadWidget({Key key, this.botoesDirecionais = const [], this.botoesAcao = const [], this.topButtom ,}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DpadWidgetState();
}

class _DpadWidgetState extends State<DpadWidget> {
  @override
  Widget build(BuildContext context) => Stack(
    children: <Widget>[
      Center(
        child: widget.topButtom ?? Center(),
      ),
     Padding(padding: EdgeInsets.only(top: 30), 
     child:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: <Widget>[
        _dpadEsquerdo(children: widget.botoesDirecionais),

        _dpadDireito(children: widget.botoesAcao),
      ]))
    ],
  );

  Widget _dpadModel(
          {var isEditable = true,
          var padding = const EdgeInsets.only(),
          var margin = const EdgeInsets.only(bottom: 10.0, top: 5.0),
          var color = Colors.transparent,
          var radius = 100.0,
          var elevation = 2.0,
          int height = 180,
          int width = 180,
          List<Widget> children = const []}) =>
      Container(
        color: Colors.transparent,
        padding: padding,
        margin: margin,
        child: Material(
          borderRadius: new BorderRadius.circular(radius.toDouble()),
          elevation: elevation,
          color: color,
          child: SizedBox(
            height: height.toDouble(),
            width: width.toDouble(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: children),
          ),
        ),
      );

  Widget _dpadEsquerdo({List<Widget> children}) => _dpadModel(
        height: 90,
        width: 150,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children,
          ),
        ],
        color: Colors.black38
      );

  Widget _dpadDireito({List<Widget> children}) => _dpadModel(
        children: <Widget>[
          children[0],
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              children[1],
              
              children[2],

              children[3],
            ],
          ),
          children[4],
        ],
        color: Colors.black38
      );
}
