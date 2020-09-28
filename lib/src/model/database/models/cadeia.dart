class Cadeia {
  static const VAL_TRUE = "1";
  static const VAL_FALSE = "0";
  static const OP_INTERROGACAO = "?";
  static const OP_PARENTESE_E = "(";
  static const OP_PARENTESE_D = ")";
  static const OP_VARIAVEL_A = "A";
  static const OP_VARIAVEL_B = "B";
  static const OP_VARIAVEL_C = "C";
  static const OP_NEGACAO = "NOT";
  static const OP_CONJUNCAO = "AND";
  static const OP_DISJUNCAO = "OR";
  static const OP_CONDICIONAL = "CON";
  static const OP_BICONDICIONAL = "BICON";

  int id;
  String nome;
  String verdadeiro;
  String falso;
  String negacao;
  String conjuncao;
  String dijuncao;
  String condicional;
  String bicondicional;

  Cadeia(
      {this.id,
      this.nome,
      this.verdadeiro,
      this.falso,
      this.negacao,
      this.conjuncao,
      this.dijuncao,
      this.condicional,
      this.bicondicional});

  Cadeia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    verdadeiro = json['verdadeiro'];
    falso = json['falso'];
    negacao = json['negacao'];
    conjuncao = json['conjuncao'];
    dijuncao = json['dijuncao'];
    condicional = json['condicional'];
    bicondicional = json['bicondicional'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['verdadeiro'] = this.verdadeiro;
    data['falso'] = this.falso;
    data['negacao'] = this.negacao;
    data['conjuncao'] = this.conjuncao;
    data['dijuncao'] = this.dijuncao;
    data['condicional'] = this.condicional;
    data['bicondicional'] = this.bicondicional;
    return data;
  }
}
