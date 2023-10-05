import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'blogs_event.dart';
part 'blogs_state.dart';

class BlogsBloc extends Bloc<BlogsEvent, BlogsState> {
  BlogsBloc() : super(FetchingDataState()) {
    on<CallingApiEvent>(callingApiEvent);
    on<FetchDataFromAPIEvent>(fetchDataFromAPIEvent);
  }

  FutureOr<void> fetchDataFromAPIEvent(
      FetchDataFromAPIEvent event, Emitter<BlogsState> emit) async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        final response = await http.get(Uri.parse(url), headers: {
          'x-hasura-admin-secret': adminSecret,
        });
        if (response.statusCode == 200) {
          emit(FetchedDataSuccessState(response: response));
        } else {
          emit(FetchedDataFailedState());
        }
      } else {
        emit(InternetConnectivityNotAvailableState());
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      emit(FetchedDataFailedState());
    }
  }

  FutureOr<void> callingApiEvent(
      CallingApiEvent event, Emitter<BlogsState> emit) {
    emit(CallingApiState());
  }
}
