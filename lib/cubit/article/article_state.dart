part of 'article_cubit.dart';

@immutable
sealed class ArticleState {}

final class ArticleInitial extends ArticleState {}
class ArticleRestoLoading extends ArticleState {}

class ArticleRestoLoaded extends ArticleState {
  final List<Map<String, dynamic>> articles;
  ArticleRestoLoaded(this.articles);
}

class ArticleRestoError extends ArticleState {
  final String message;
  ArticleRestoError(this.message);
}
class AddArticleLoading extends ArticleState {}

class AddArticleLoaded extends ArticleState {
  final String successMessage;
  AddArticleLoaded(this.successMessage);
}

class AddArticleError extends ArticleState {
  final String errorMessage;
  AddArticleError(this.errorMessage);
}