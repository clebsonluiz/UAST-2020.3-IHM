
class RankUtils{

  static final RankUtils _this = RankUtils._();
  
  int vidasRestantes = 0;
  String tempoDecorridoStr = "";

  set tempoDecorrido(Duration d){
    final str = d.toString().substring(3, 8).split(":");


    this.tempoDecorridoStr = "${0};${d.inHours};${str[0]};${str[1].replaceAll('.', '')}";
  }

  Duration get inDuration => convertStringToDuration(this.tempoDecorridoStr);

  static Duration convertStringToDuration(String duration){
    final _splited = duration.split(";");

    final _days = int.parse(_splited[0]);
    final _hours = int.parse(_splited[1]);
    final _minutes = int.parse(_splited[2]);
    final _seconds = int.parse(_splited[3]);
    return Duration(days: _days, hours: _hours, minutes: _minutes, seconds: _seconds);
  }

  factory RankUtils() => _this;

  RankUtils._();

}