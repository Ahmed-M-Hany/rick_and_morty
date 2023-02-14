import 'package:flutter/material.dart';
import 'package:rick_and_morty_api/app_router.dart';

void main() {
  runApp( RickAndMortyApp(appRouter: AppRouter(),));
}

class RickAndMortyApp extends StatelessWidget {
  final AppRouter appRouter;
  const RickAndMortyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick & Morty',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
      theme: ThemeData.dark(),
    );
  }
}
