import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riddles_game_en/core/database/riddle_db.dart';
import 'package:riddles_game_en/core/model/riddle_model/riddle_model.dart';
import 'package:riddles_game_en/core/repository/cache_repository.dart';
import 'package:riddles_game_en/core/utils/enum.dart';

part 'riddle_event.dart';
part 'riddle_state.dart';

class RiddleBloc extends Bloc<RiddleEvent, RiddleState> {
  final _controller = RiddleRepository(
    cahceRepo: CacheRepository(),
    path: DataPath.riddles.getPath(),
  );

  RiddleBloc() : super(RiddleState.initial()) {
    on<GetRiddles>(_onGetRiddles);
    on<AddRiddles>(_onAddRiddles);
  }
  _onGetRiddles(GetRiddles event, Emitter<RiddleState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      var allRidd = await _controller.getRiddles(event.category);
      var riddles = allRidd.map((json) => RiddleModel.fromJson(json)).toList();
      emit(state.copyWith(isSuccess: true, riddles: riddles));
    } catch (_) {}
  }

  _onAddRiddles(AddRiddles event, Emitter<RiddleState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _controller.loadRiddles(event.category);
    } catch (_) {}
  }
}
