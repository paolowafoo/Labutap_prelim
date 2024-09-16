import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- Models ---
class Book {
  final String id;
  final String title;
  final String author;

  Book({required this.id, required this.title, required this.author});

  @override
  String toString() {
    return 'ID: $id, Title: $title, Author: $author';
  }
}

// --- StateNotifier for managing books ---
class BookNotifier extends StateNotifier<List<Book>> {
  BookNotifier() : super([]);

  // Add a book
  void addBook(String id, String title, String author) {
    state = [...state, Book(id: id, title: title, author: author)];
  }

  // Remove a book
  void removeBook(String id) {
    state = state.where((book) => book.id != id).toList();
  }
}

// Create a StateNotifierProvider for the BookNotifier
final bookNotifierProvider =
    StateNotifierProvider<BookNotifier, List<Book>>((ref) {
  return BookNotifier();
});
