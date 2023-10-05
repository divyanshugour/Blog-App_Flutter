import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'blog_details_event.dart';
part 'blog_details_state.dart';

class BlogDetailsBloc extends Bloc<BlogDetailsEvent, BlogDetailsState> {
  BlogDetailsBloc() : super(BlogDetailsInitial()) {
    on<DisplayDataOnScreenEvent>(displayDataOnScreenEvent);
  }

  FutureOr<void> displayDataOnScreenEvent(
      DisplayDataOnScreenEvent event, Emitter<BlogDetailsState> emit) {
    emit(DisplayDataOnScreenState(
        id: event.id,
        title: event.title,
        image_url: event.image_url,
        is_favorite: false));
  }
}
