class Expressao {
  int id;
  String expressao;

  Expressao({this.id, this.expressao});

  Expressao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expressao = json['expressao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expressao'] = this.expressao;
    return data;
  }
}
