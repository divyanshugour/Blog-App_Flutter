part of 'favorite_blogs_bloc.dart';

@immutable
abstract class FavoriteBlogsState {}

class FavoriteBlogsInitial extends FavoriteBlogsState {}

class FetchedFavoriteBlogsDataSuccessState extends FavoriteBlogsState {
  final response;
  FetchedFavoriteBlogsDataSuccessState({
    required this.response,
  });
}

class FetchedFavoriteBlogsDataFailedState extends FavoriteBlogsState {}
