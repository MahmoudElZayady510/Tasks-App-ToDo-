import '../bloc_exports.dart';
import 'package:equatable/equatable.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends HydratedBloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchInitial(switchValue: false)) {
    on<SwitchOn>((SwitchOn event, Emitter emit) {
      emit(
        SwitchState(switchValue: true)
      );
    });
    on<SwitchOff>((SwitchOff event, Emitter emit) {
      emit(
          SwitchState(switchValue: false)
      );
    });
  }

  @override
  SwitchState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return SwitchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SwitchState state) {
    // TODO: implement toJson
    return state.toMap();
  }
}
