import 'package:rick_and_morty_api/data/web_services/web_services.dart';

import '../models/characters.dart';

class CharactersRepository{
  late final WebServices webServices;
  CharactersRepository(this.webServices);

  Future<List<Character>> getAllCharacters()async{
    final Map<String,dynamic> charcters=await webServices.getAllCharacters();
    try{
      final ggwp=charcters['results'].map((character)=>Character.fromJson(character)).toList();
      final iHateThisApp=ggwp.cast<Character>();
      return iHateThisApp;
    }catch(e){
      print("shiiiiiiiiiiiiiiit");
      print(e);
      throw e;
    }

  }

}