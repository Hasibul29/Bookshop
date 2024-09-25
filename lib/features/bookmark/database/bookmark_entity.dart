import 'package:floor/floor.dart';

import '../../booklist/models/booklist_model.dart';

@Entity(tableName: 'level_bookmark')
class LevelBookmarkEntity {
  @primaryKey
  @ColumnInfo(name: 'level_num')
  final int levelNum;
  @ColumnInfo(name: 'level_title')
  final String levelTitle;

  LevelBookmarkEntity(this.levelNum, this.levelTitle);
}

@Entity(tableName: 'word_bookmark')
class WordBookmarkEntity {
  @primaryKey
  @ColumnInfo(name: 'serial_num')
  final int serialNum;
  final String arabic;
  final String english;

  WordBookmarkEntity(this.serialNum, this.arabic, this.english);
}

@Entity(tableName: 'book_bookmark')
class BookBookmarkEntity {
  @primaryKey
  final String id;

  @ColumnInfo(name: 'book_image')
  final String bookImage;

  @ColumnInfo(name: 'book_cover_image')
  final String bookCoverImage;

  @ColumnInfo(name: 'book_name')
  final String bookName;

  @ColumnInfo(name: 'book_writer')
  final String bookWriter;

  @ColumnInfo(name: 'book_status')
  final String bookStatus;

  @ColumnInfo(name: 'book_available')
  final String bookAvailable;

  @ColumnInfo(name: 'book_notavailable')
  final String bookNotAvailable;

  @ColumnInfo(name: 'book_review')
  final String bookReview;

  @ColumnInfo(name: 'book_type')
  final String bookType;

  @ColumnInfo(name: 'book_publisher')
  final String bookPublisher;

  @ColumnInfo(name: 'total_read')
  final String totalRead;

  @ColumnInfo(name: 'book_average_review')
  final String bookAverageReview;

  @ColumnInfo(name: 'book_category')
  final String bookCategory;

  @ColumnInfo(name: 'book_state')
  final String bookState;

  BookBookmarkEntity({
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

  factory BookBookmarkEntity.fromBook(Book book) {
    return BookBookmarkEntity(
      id: book.id,
      bookImage: book.bookImage,
      bookCoverImage: book.bookCoverImage,
      bookName: book.bookName,
      bookWriter: book.bookWriter,
      bookStatus: book.bookStatus,
      bookAvailable: book.bookAvailable,
      bookNotAvailable: book.bookNotAvailable,
      bookReview: book.bookReview,
      bookType: book.bookType,
      bookPublisher: book.bookPublisher,
      totalRead: book.totalRead,
      bookAverageReview: book.bookAverageReview,
      bookCategory: book.bookCategory,
      bookState: book.bookState,
    );
  }

  Book toBook() {
    return Book(
      id: id,
      bookImage: bookImage,
      bookCoverImage: bookCoverImage,
      bookName: bookName,
      bookWriter: bookWriter,
      bookStatus: bookStatus,
      bookAvailable: bookAvailable,
      bookNotAvailable: bookNotAvailable,
      bookReview: bookReview,
      bookType: bookType,
      bookPublisher: bookPublisher,
      totalRead: totalRead,
      bookAverageReview: bookAverageReview,
      bookCategory: bookCategory,
      bookState: bookState,
    );
  }
}
