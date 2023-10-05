part of 'favorite_blogs_bloc.dart';

@immutable
abstract class FavoriteBlogsEvent {}

class FetchingDataFromSql extends FavoriteBlogsEvent {}
