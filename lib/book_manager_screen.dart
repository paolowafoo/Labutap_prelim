import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'book_service.dart'; // Import the BookNotifier provider
import 'package:uuid/uuid.dart'; // To generate unique IDs

class BookManagerScreen extends ConsumerWidget {
  BookManagerScreen({super.key});

  // Controllers for the input fields
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(bookNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Book Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field for book title
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Book Title'),
            ),
            // Input field for book author
            TextField(
              controller: authorController,
              decoration: const InputDecoration(labelText: 'Author'),
            ),
            const SizedBox(height: 16),
            // Button to add a book
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final author = authorController.text;
                if (title.isNotEmpty && author.isNotEmpty) {
                  final id = Uuid().v4(); // Generate unique ID
                  ref
                      .read(bookNotifierProvider.notifier)
                      .addBook(id, title, author);
                  // Clear input fields
                  titleController.clear();
                  authorController.clear();
                }
              },
              child: const Text('Add Book'),
            ),
            const SizedBox(height: 16),
            // Display the list of books
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Remove the book by its ID
                        ref
                            .read(bookNotifierProvider.notifier)
                            .removeBook(book.id);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
