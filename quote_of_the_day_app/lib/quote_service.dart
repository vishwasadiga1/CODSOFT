import 'dart:math';

class QuoteService {
  static List<String> quotes = [
    "The best way to predict the future is to create it.",
    "You miss 100% of the shots you don't take.",
    "Success is not the key to happiness. Happiness is the key to success.",
    "Don't watch the clock; do what it does. Keep going.",
    "Your limitation—it’s only your imagination.",
    "Push yourself, because no one else is going to do it for you.",
    "Great things never come from comfort zones.",
    "Dream it. Wish it. Do it.",
    "Success doesn’t just find you. You have to go out and get it.",
    "The harder you work for something, the greater you’ll feel when you achieve it.",
    "Don’t stop when you’re tired. Stop when you’re done.",
    "Wake up with determination. Go to bed with satisfaction.",
    "Do something today that your future self will thank you for.",
    "Little things make big days.",
    "It’s going to be hard, but hard does not mean impossible.",
    "Don’t wait for opportunity. Create it.",
    "Sometimes we’re tested not to show our weaknesses, but to discover our strengths.",
    "The key to success is to focus on goals, not obstacles.",
    "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle.",
    "Keep going. Everything you need will come to you at the perfect time.",
    "Difficult roads often lead to beautiful destinations.",
    "Don’t be afraid to give up the good to go for the great.",
    "Keep your eyes on the stars, and your feet on the ground.",
    "Hard work beats talent when talent doesn’t work hard.",
    "The only limit to our realization of tomorrow is our doubts of today.",
    "Success usually comes to those who are too busy to be looking for it.",
    "The way to get started is to quit talking and begin doing.",
    "If you really look closely, most overnight successes took a long time.",
    "Opportunities don’t happen, you create them.",
    "The only place where success comes before work is in the dictionary.",
  ];

  static Future<String> getRandomQuote() async {
    final random = Random();
    return quotes[random.nextInt(quotes.length)];
  }
}
