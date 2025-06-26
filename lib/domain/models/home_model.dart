// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:minhacarteira/domain/models/depesa_model.dart';

class HomeModel {
  double receitaTotal;
  double despesasTotal;
  String? receitaDisplay;

  List<DespesaModel> despesas;

  HomeModel({
    required this.receitaTotal,
    required this.despesasTotal,
    required this.despesas,
  });

  HomeModel copyWith({
    double? receitaTotal,
    double? despesasTotal,
    List<DespesaModel>? despesas,
  }) {
    return HomeModel(
      receitaTotal: receitaTotal ?? this.receitaTotal,
      despesasTotal: despesasTotal ?? this.despesasTotal,
      despesas: despesas ?? this.despesas,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receitaTotal': receitaTotal,
      'despesasTotal': despesasTotal,
      'despesas': despesas.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      receitaTotal: map['receitaTotal'] as double,
      despesasTotal: map['despesasTotal'] as double,
      despesas: List<DespesaModel>.from(
        (map['despesas'] as List<int>).map<DespesaModel>(
          (x) => DespesaModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'HomeModel(receitaTotal: $receitaTotal, despesasTotal: $despesasTotal, despesas: $despesas)';

  @override
  bool operator ==(covariant HomeModel other) {
    if (identical(this, other)) return true;

    return other.receitaTotal == receitaTotal &&
        other.despesasTotal == despesasTotal &&
        listEquals(other.despesas, despesas);
  }

  @override
  int get hashCode =>
      receitaTotal.hashCode ^ despesasTotal.hashCode ^ despesas.hashCode;
}
