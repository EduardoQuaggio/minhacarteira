import 'package:minhacarteira/domain/models/home_model.dart';

abstract class HomeState {}

class InitialHomeState extends SuccessHomeState {
  InitialHomeState()
    : super(HomeModel(receitaTotal: 0.0, despesasTotal: 0.0, despesas: []));
}

class LoadingHomeState implements HomeState {}

class SuccessHomeState implements HomeState {
  final HomeModel data;

  SuccessHomeState(this.data);
}

class ErrorHomeState implements HomeState {
  final String message;

  ErrorHomeState(this.message);
}
