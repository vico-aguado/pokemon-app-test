// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'poke_desk_bloc.dart';

abstract class PokeDeskState extends Equatable {
  final PokeDeskModel model;
  const PokeDeskState(this.model);

  @override
  List<Object> get props => [model];
}

class InitialPokeDeskState extends PokeDeskState {
  const InitialPokeDeskState(super.model);
}

class FilterPokeDeskState extends PokeDeskState {
  const FilterPokeDeskState(super.model);
}

class PokeDeskModel extends Equatable {
  final ScrollController scrollController;
  final TextEditingController searchController;
  final bool isFilter;

  const PokeDeskModel({
    required this.scrollController,
    required this.searchController,
    required this.isFilter,
  });

  PokeDeskModel copyWith({
    ScrollController? scrollController,
    TextEditingController? searchController,
    bool? isFilter,
  }) {
    return PokeDeskModel(
      scrollController: scrollController ?? this.scrollController,
      searchController: searchController ?? this.searchController,
      isFilter: isFilter ?? this.isFilter,
    );
  }

  @override
  List<Object> get props => [scrollController, searchController, isFilter];
}
