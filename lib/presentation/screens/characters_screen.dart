import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:rick_and_morty_api/business_logic/characters_cubit.dart';
import 'package:rick_and_morty_api/constants/my_colors.dart';
import 'package:rick_and_morty_api/presentation/widgets/Character_item.dart';

import '../../data/models/characters.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedCharacters;
  bool isSearching = false;
  final searchTextController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildSearchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: Colors.black54,
      decoration: const InputDecoration(
        hintText: 'find a character',
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
        ),
      ),
      style: const TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      itemCount: searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedCharacters.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedCharacters[index],
        );
      },
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = state.characters;
        return buildLoadedListWidget();
      } else {
        return const LoadingIndicator(indicatorType: Indicator.ballGridBeat);
      }
    });
  }

  Widget buildAppBarTitle() {
    return const Text(
      "Characters",
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: isSearching ? buildSearchField() : buildAppBarTitle(),
        actions: buildAppBarActions(),
        leading: isSearching
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
      ),
      body: OfflineBuilder(connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if (connected) {
          return buildBlocWidget();
        } else {
          return buildNoInternetWidget();
        }
      },

      child: const LoadingIndicator(indicatorType: Indicator.ballGridBeat),
      ),
      // buildBlocWidget(),
    );

  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: MyColors.myWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            const SizedBox(
              height: 80,
            ),
            Image.asset('assets/images/Mini Offline.png'),
          ],
        ),
      ),
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedCharacters = allCharacters
        .where((charcter) =>
            charcter.name.toLowerCase().contains(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }
}
