import 'package:bookshop/core/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/booklist_model.dart';
import 'booklist_notifier.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final bookListProvider =
    StateNotifierProvider<BookListNotifier, AsyncValue<List<Book>>>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return BookListNotifier(apiService);
});
