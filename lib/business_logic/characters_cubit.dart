import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/models/characters.dart';
import '../data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  late final CharactersRepository charactersRepository;
   List<Character> characters=[];
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharacters(){
    charactersRepository.getAllCharacters().then((characters){
      emit(CharactersLoaded(characters));
      this.characters=characters;
    });
    return characters;

  }
}
