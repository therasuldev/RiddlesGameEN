// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'game_bloc.dart';

abstract class GameEvent {}

class GetGameRiddles extends GameEvent {
  final String category;
  GetGameRiddles(this.category);
}

class AddGameRiddles extends GameEvent {
  final String category;
  AddGameRiddles(this.category);
}