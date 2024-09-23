import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/booklist_provider.dart';
import 'widgets/appbar.dart';
import 'widgets/bottom_navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(title: 'Demo'),
      bottomNavigationBar: bottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Container(color: Colors.amber, child: const BookListView()),
          Container(
            color: Colors.green,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.blue,
            width: double.infinity,
            height: double.infinity,
          ),
        ],
      ),
    );
  }
}

class BookListView extends ConsumerWidget {
  const BookListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookListState = ref.watch(bookListProvider);

    return bookListState.when(
      data: (books) {
        if (books.isEmpty) {
          return const Center(child: Text('No books available'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.read(bookListProvider.notifier).refresh();
          },
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: books.length +
                (ref.read(bookListProvider.notifier).hasMoreBooks ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == books.length) {
                ref.read(bookListProvider.notifier).loadMoreBooks();
                return const Center(child: CircularProgressIndicator());
              }

              final book = books[index];
              return ListTile(
                title: Text(book.bookName),
                subtitle: Text(book.bookWriter),
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
