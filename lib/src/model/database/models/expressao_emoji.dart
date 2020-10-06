class ExpressaoEmoji {
  int id;
  String expressaoEmoji;
  String respostas;
  String erradas;

  ExpressaoEmoji(
      {this.id, this.expressaoEmoji, this.respostas, this.erradas});

  ExpressaoEmoji.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expressaoEmoji = json['expressao_emoji'];
    respostas = json['respostas'];
    erradas = json['erradas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expressao_emoji'] = this.expressaoEmoji;
    data['respostas'] = this.respostas;
    data['erradas'] = this.erradas;
    return data;
  }
}
