import 'package:flutter/material.dart';
import 'package:quote_of_the_day_app/quote_service.dart';
import 'package:quote_of_the_day_app/favorite_quotes_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class QuoteHomeScreen extends StatefulWidget {
  @override
  _QuoteHomeScreenState createState() => _QuoteHomeScreenState();
}

class _QuoteHomeScreenState extends State<QuoteHomeScreen> {
  String dailyQuote = "";
  List<String> favoriteQuotes = [];

  @override
  void initState() {
    super.initState();
    _loadDailyQuote(); // Load quote on app startup
    _loadFavoriteQuotes(); // Load saved favorites
  }

  // Load a random quote asynchronously on app launch
  void _loadDailyQuote() async {
    String quote = await QuoteService.getRandomQuote();
    setState(() {
      dailyQuote = quote;
    });
  }

  // Load saved favorite quotes
  void _loadFavoriteQuotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteQuotes = prefs.getStringList('favoriteQuotes') ?? [];
    });
  }

  // Save favorite quotes locally and update UI immediately
  void _saveFavoriteQuote(String quote) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!favoriteQuotes.contains(quote)) {
      setState(() {
        favoriteQuotes.add(quote);  // Update the local list immediately
      });

      // Save the updated list to shared preferences
      prefs.setStringList('favoriteQuotes', favoriteQuotes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Quote added to favorites")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Quote already in favorites")),
      );
    }
  }

  // Share the current quote
  void _shareQuote(String quote) {
    Share.share(quote);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quote of the Day',
          style: TextStyle(
            fontWeight: FontWeight.bold,  // Make the title bold
            fontSize: 26,  // Increase the font size for the title
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            dailyQuote.isNotEmpty
                ? Text(
              dailyQuote,
              style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            )
                : CircularProgressIndicator(), // Display loading indicator while fetching the quote
            SizedBox(height: 20),  // Space between the quote and buttons
            ElevatedButton(
              onPressed: _loadDailyQuote,
              child: Text('New Quote'),
            ),
            SizedBox(height: 10),  // Space between buttons
            ElevatedButton(
              onPressed: () => _shareQuote(dailyQuote),
              child: Text('Share Quote'),
            ),
            SizedBox(height: 10),  // Space between buttons
            ElevatedButton(
              onPressed: () => _saveFavoriteQuote(dailyQuote),
              child: Text('Add to Favorites'),
            ),
            SizedBox(height: 30),  // Space between buttons and favorites list
            Text(
              'Favorite Quotes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FavoriteQuotesList(favoriteQuotes: favoriteQuotes),
            ),
          ],
        ),
      ),
    );
  }
}