import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_api/business_logic/characters_cubit.dart';
import 'package:rick_and_morty_api/data/repository/characters_repository.dart';
import 'package:rick_and_morty_api/data/web_services/web_services.dart';
import 'package:rick_and_morty_api/presentation/screens/character_datails.dart';
import 'package:rick_and_morty_api/presentation/screens/characters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(WebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(charactersRepository),
            child: const CharactersScreen(),
          ),
        );
      case '/character_details':
        return MaterialPageRoute(
            builder: (_) => const CharactersDetailsScreen());
    }
    return null;
  }
}
