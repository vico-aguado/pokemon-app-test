// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  final DetailModel model;
  const DetailState(this.model);

  @override
  List<Object> get props => [model];
}

class InitialDetailState extends DetailState {
  const InitialDetailState(super.model);
}

class ItemSelectedState extends DetailState {
  const ItemSelectedState(super.model);
}

class ScrollPositionChangedState extends DetailState {
  const ScrollPositionChangedState(super.model);
}

class DetailModel extends Equatable {
  final int focusIndex;
  final double panelScrollPosition;

  const DetailModel({
    this.focusIndex = 0,
    this.panelScrollPosition = 0,
  });

  DetailModel copyWith({
    int? focusIndex,
    double? panelScrollPosition,
  }) {
    return DetailModel(
      focusIndex: focusIndex ?? this.focusIndex,
      panelScrollPosition: panelScrollPosition ?? this.panelScrollPosition,
    );
  }

  @override
  List<Object?> get props => [
        focusIndex,
        panelScrollPosition,
      ];
}
