part of 'blogs_bloc.dart';

@immutable
abstract class BlogsState {}

class BlogsInitial extends BlogsState {}

class CallingApiState extends BlogsState {}

class InternetConnectivityNotAvailableState extends BlogsState {}

class FetchingDataState extends BlogsState {}

class FetchedDataSuccessState extends BlogsState {
  final response;
  FetchedDataSuccessState({
    required this.response,
  });
}

class FetchedDataFailedState extends BlogsState {}
