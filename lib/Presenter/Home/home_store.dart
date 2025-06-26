import 'package:flutter/material.dart';
import 'package:minhacarteira/Presenter/Home/home_state.dart';
import 'package:minhacarteira/domain/models/depesa_model.dart';
import 'package:minhacarteira/domain/models/home_model.dart';

class HomeStore extends ChangeNotifier {
  HomeState state = InitialHomeState();

  Future<void> searchModelData(int mes) async {
    state = LoadingHomeState();
    notifyListeners();

    Future.delayed(const Duration(seconds: 9000));

    state = SuccessHomeState(
      HomeModel(
        receitaTotal: 10000.60 * mes,
        despesasTotal: 3000.00 * mes,
        despesas: [
          DespesaModel(Nome: "Mercado Semanal", Valor: 300.00, Tipo: 'Mercado'),
          DespesaModel(Nome: "Mercado Semanal", Valor: 300.00, Tipo: 'Mercado'),
          DespesaModel(Nome: "Mercado Semanal", Valor: 300.00, Tipo: 'Mercado'),
          DespesaModel(Nome: "Mercado Semanal", Valor: 300.00, Tipo: 'Mercado'),
        ],
      ),
    );

    notifyListeners();
  }
}
