part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState{
  late final List<Character> characters;
  CharactersLoaded(this.characters);
}

