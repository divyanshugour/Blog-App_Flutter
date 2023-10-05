part of 'blog_details_bloc.dart';

@immutable
abstract class BlogDetailsState {}

class BlogDetailsInitial extends BlogDetailsState {}

class DisplayDataOnScreenState extends BlogDetailsState {
  final id, title, image_url, is_favorite;
  DisplayDataOnScreenState(
      {this.id, this.title, this.image_url, this.is_favorite});
}
