part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends DetailEvent {
  const InitEvent();
}

class SelectItemEvent extends DetailEvent {
  const SelectItemEvent(this.index);
  final int index;
}

class ChangeScrollPositionEvent extends DetailEvent {
  const ChangeScrollPositionEvent(this.value);
  final double value;
}
