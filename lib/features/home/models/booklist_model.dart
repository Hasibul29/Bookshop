class BookListModel {
  final int? page;
  final int? perPage;
  final int? totalBooks;
  final int? totalPages;
  final List<Book>? books;

  BookListModel({
    this.page,
    this.perPage,
    this.totalBooks,
    this.totalPages,
    this.books,
  });

  factory BookListModel.fromJson(Map<String, dynamic> json) {
    return BookListModel(
      page: json['page'],
      perPage: json['per_page'],
      totalBooks: json['total_books'],
      totalPages: json['total_pages'],
      books:
          (json['books'] as List).map((book) => Book.fromJson(book)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
      'total_books': totalBooks,
      'total_pages': totalPages,
      'books': books?.map((v) => v.toJson()).toList(),
    };
  }
}

class Book {
  final String id;
  final String bookImage;
  final String bookCoverImage;
  final String bookName;
  final String bookWriter;
  final String bookStatus;
  final String bookAvailable;
  final String bookNotAvailable;
  final String bookReview;
  final String bookType;
  final String bookPublisher;
  final String totalRead;
  final String bookAverageReview;
  final String bookCategory;
  final String bookState;

  Book({
    required this.id,
    required this.bookImage,
    required this.bookCoverImage,
    required this.bookName,
    required this.bookWriter,
    required this.bookStatus,
    required this.bookAvailable,
    required this.bookNotAvailable,
    required this.bookReview,
    required this.bookType,
    required this.bookPublisher,
    required this.totalRead,
    required this.bookAverageReview,
    required this.bookCategory,
    required this.bookState,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      bookImage: json['book_image'],
      bookCoverImage: json['book_cover_image'],
      bookName: json['book_name'],
      bookWriter: json['book_writer'],
      bookStatus: json['book_status'],
      bookAvailable: json['book_available'],
      bookNotAvailable: json['book_notavailable'],
      bookReview: json['book_review'],
      bookType: json['book_type'],
      bookPublisher: json['book_publisher'],
      totalRead: json['totalread'],
      bookAverageReview: json['book_average_review'],
      bookCategory: json['book_catagory'],
      bookState: json['book_state'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'book_image': bookImage,
      'book_cover_image': bookCoverImage,
      'book_name': bookName,
      'book_writer': bookWriter,
      'book_status': bookStatus,
      'book_available': bookAvailable,
      'book_notavailable': bookNotAvailable,
      'book_review': bookReview,
      'book_type': bookType,
      'book_publisher': bookPublisher,
      'totalread': totalRead,
      'book_average_review': bookAverageReview,
      'book_catagory': bookCategory,
      'book_state': bookState,
    };
  }
}
