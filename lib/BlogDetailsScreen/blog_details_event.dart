part of 'blog_details_bloc.dart';

@immutable
abstract class BlogDetailsEvent {}

class DisplayDataOnScreenEvent extends BlogDetailsEvent {
  final id, title, image_url;
  DisplayDataOnScreenEvent({this.id, this.title, this.image_url});
}

class CheckForFavoriteEvent extends BlogDetailsEvent {}
