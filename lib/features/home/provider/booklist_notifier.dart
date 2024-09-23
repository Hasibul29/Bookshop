import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api_service.dart';
import '../../../core/constants.dart';
import '../../../core/datastate.dart';
import '../models/booklist_model.dart';

class BookListNotifier extends StateNotifier<AsyncValue<List<Book>>> {
  BookListNotifier(this._apiService) : super(const AsyncValue.loading()) {
    loadMoreBooks();
  }

  final ApiService _apiService;
  int _currentPage = 1;
  bool _hasMoreBooks = true;

  bool get hasMoreBooks => _hasMoreBooks;

  Future<void> loadMoreBooks() async {
    if (!_hasMoreBooks) return;

    final result = await _apiService.getRequest<BookListModel>(
      url,
      queryParameters: {'page': _currentPage},
      fromJson: (json) => BookListModel.fromJson(json),
    );

    if (result is DataSuccess) {
      final data = result.data;
      final newBooks = data?.books ?? [];
      final currentBooks = state.value ?? [];

      state = AsyncValue.data([...currentBooks, ...newBooks]);

      _currentPage++;
      _hasMoreBooks = (data?.page ?? 1) < (data?.totalPages ?? 1);
    } else if (result is DataFailed) {
      if (state.value == null) {
        state = AsyncValue.error(
            result.error ?? "Something went wrong!", StackTrace.current);
      }
    }
  }

  void refresh() {
    state = const AsyncValue.loading();
    _currentPage = 1;
    _hasMoreBooks = true;
    loadMoreBooks();
  }
}
