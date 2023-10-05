import 'dart:convert';

import 'package:blog_explorer/FavoriteBlogsScreen/favorite_blogs_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../BlogDetailsScreen/blog_details.dart';
import '../DataModels/blog_model.dart';

class FavoriteBlogs extends StatefulWidget {
  const FavoriteBlogs({super.key});

  @override
  State<FavoriteBlogs> createState() => _FavoriteBlogsState();
}

class _FavoriteBlogsState extends State<FavoriteBlogs> {
  FavoriteBlogsBloc favoriteBlogsBloc = FavoriteBlogsBloc();

  @override
  void initState() {
    // TODO: implement initState
    favoriteBlogsBloc.add(FetchingDataFromSql());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: const Text('Favorites'),
      ),
      body: BlocConsumer<FavoriteBlogsBloc, FavoriteBlogsState>(
        bloc: favoriteBlogsBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case FavoriteBlogsInitial:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            case FetchedFavoriteBlogsDataFailedState:
              return const Center(
                  child: Text(
                'No data found',
                style: TextStyle(
                  color: Colors.white,
                ),
              ));
            case FetchedFavoriteBlogsDataSuccessState:
              final successState =
                  state as FetchedFavoriteBlogsDataSuccessState;
              print(successState.response.toString());
              final body = List<Map<String, dynamic>>.from(
                  jsonDecode(successState.response.toString()));
              final blogs = body.map((e) => BlogModel.fromJson(e)).toList();
              if (blogs.isEmpty) {
                return const Center(
                  child: Text('No Data Found'),
                );
              } else {
                return ListView.builder(
                    itemCount: blogs.length,
                    itemBuilder: (context, index) {
                      final blog = blogs[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlogDetails(
                                      id: blog.id,
                                      image_url: blog.image_url,
                                      title: blog.title,
                                    )),
                          );
                        },
                        child: Card(
                          borderOnForeground: true,
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 16),
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: blog.image_url,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(11),
                                    image: DecorationImage(
                                      image: NetworkImage(blog.image_url),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: const Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: const Center(
                                      child: Icon(
                                    Icons.error_outline,
                                    size: 35,
                                    color: Colors.white,
                                  )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  blog.title,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }
          }
          return const Center(
            child: Text(
              'Something went wrong !',
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
