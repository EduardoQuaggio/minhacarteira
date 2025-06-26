// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DespesaModel {
  final String Nome;
  final double Valor;
  final String Tipo;

  DespesaModel({required this.Nome, required this.Valor, required this.Tipo});

  DespesaModel copyWith({String? Nome, double? Valor, String? Tipo}) {
    return DespesaModel(
      Nome: Nome ?? this.Nome,
      Valor: Valor ?? this.Valor,
      Tipo: Tipo ?? this.Tipo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'Nome': Nome, 'Valor': Valor, 'Tipo': Tipo};
  }

  factory DespesaModel.fromMap(Map<String, dynamic> map) {
    return DespesaModel(
      Nome: map['Nome'] as String,
      Valor: map['Valor'] as double,
      Tipo: map['Tipo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DespesaModel.fromJson(String source) =>
      DespesaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DespesaModel(Nome: $Nome, Valor: $Valor, Tipo: $Tipo)';

  @override
  bool operator ==(covariant DespesaModel other) {
    if (identical(this, other)) return true;

    return other.Nome == Nome && other.Valor == Valor && other.Tipo == Tipo;
  }

  @override
  int get hashCode => Nome.hashCode ^ Valor.hashCode ^ Tipo.hashCode;
}
