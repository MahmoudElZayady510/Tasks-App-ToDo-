part of 'switch_bloc.dart';

class SwitchState extends Equatable {
  bool switchValue;
  SwitchState({required this.switchValue});

  @override
  // TODO: implement props
  List<Object?> get props => [switchValue];

  Map<String, dynamic> toMap() {
    return {
      'switchValue': this.switchValue,
    };
  }

  factory SwitchState.fromMap(Map<String, dynamic> map) {
    return SwitchState(
      switchValue: map['switchValue'] ?? false,
    );
  }
}

class SwitchInitial extends SwitchState {
  SwitchInitial({required super.switchValue});

  @override
  List<Object> get props => [];
}
