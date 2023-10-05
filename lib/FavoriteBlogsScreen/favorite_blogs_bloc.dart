import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_explorer/Database/database_helper.dart';
import 'package:meta/meta.dart';

part 'favorite_blogs_event.dart';
part 'favorite_blogs_state.dart';

DatabaseHelper dbHelper = DatabaseHelper();

class FavoriteBlogsBloc extends Bloc<FavoriteBlogsEvent, FavoriteBlogsState> {
  FavoriteBlogsBloc() : super(FavoriteBlogsInitial()) {
    on<FetchingDataFromSql>(fetchingDataFromSql);
  }

  FutureOr<void> fetchingDataFromSql(
      FetchingDataFromSql event, Emitter<FavoriteBlogsState> emit) async {
    List<Map<String, dynamic>> response = await dbHelper.queryAllRows();
    emit(FetchedFavoriteBlogsDataSuccessState(response: response));
  }
}
