import 'package:flutter/material.dart';

class FavoriteQuotesList extends StatelessWidget {
  final List<String> favoriteQuotes;

  const FavoriteQuotesList({Key? key, required this.favoriteQuotes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: favoriteQuotes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteQuotes[index]),
          );
        },
      ),
    );
  }
}
