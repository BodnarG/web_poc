import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const favoriteBooksBoxName = 'favorite_books';
const List<String> books = [
  'Harry Potter',
  'To Kill a Mockingbird',
  'The Hunger Games',
  'The Giver',
  'Brave New World',
  'Unwind',
  'World War Z',
  'The Lord of the Rings',
  'The Hobbit',
  'Moby Dick',
  'War and Peace',
  'Crime and Punishment',
  'The Adventures of Huckleberry Finn',
  'Catch-22',
  'The Sound and the Fury',
  'The Grapes of Wrath',
  'Heart of Darkness',
];

class FavoriteBooksHome extends StatelessWidget {
  static const String id = favoriteBooksBoxName;

  const FavoriteBooksHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('FavoriteBooksHome  >  build()');
    return FutureBuilder(
      future: Hive.openBox<String>(favoriteBooksBoxName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.error != null) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Text('Something went wrong :/'),
              ),
            );
          } else {
            return const FavoriteBooks();
          }
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Opening Hive...'),
            ),
          );
        }
      },
    );
  }
}

class FavoriteBooks extends StatefulWidget {
  const FavoriteBooks({Key? key}) : super(key: key);

  @override
  _FavoriteBooksState createState() => _FavoriteBooksState();
}

class _FavoriteBooksState extends State<FavoriteBooks> {
  late Box<String> favoriteBooksBox;

  @override
  void initState() {
    super.initState();
    favoriteBooksBox = Hive.box(favoriteBooksBoxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Books'),
      ),
      body: ValueListenableBuilder(
        valueListenable: favoriteBooksBox.listenable(),
        builder: (context, Box<String> box, _) {
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, listIndex) {
              return ListTile(
                title: Text(books[listIndex]),
                leading: IconButton(
                  icon: getIcon(listIndex),
                  onPressed: () => onFavoritePress(listIndex),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget getIcon(int index) {
    if (favoriteBooksBox.containsKey(index)) {
      return const Icon(Icons.favorite, color: Colors.red);
    }
    return const Icon(Icons.favorite_border);
  }

  void onFavoritePress(int index) {
    if (favoriteBooksBox.containsKey(index)) {
      favoriteBooksBox.delete(index);
      return;
    }
    favoriteBooksBox.put(index, books[index]);
  }
}
