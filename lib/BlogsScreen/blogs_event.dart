part of 'blogs_bloc.dart';

@immutable
abstract class BlogsEvent {}

class CallingApiEvent extends BlogsEvent {}

class FetchDataFromAPIEvent extends BlogsEvent {}
