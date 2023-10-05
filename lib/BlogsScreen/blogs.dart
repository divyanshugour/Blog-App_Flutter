import 'dart:convert';
import 'package:blog_explorer/BlogDetailsScreen/blog_details.dart';
import 'package:blog_explorer/BlogsScreen/blogs_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataModels/blog_model.dart';
import '../FavoriteBlogsScreen/favorite_blogs.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  BlogsBloc blogsBloc = BlogsBloc();

  @override
  void initState() {
    // TODO: implement initState
    blogsBloc.add(CallingApiEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(
                Icons.bookmark_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoriteBlogs()),
                );
              },
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogsBloc, BlogsState>(
        bloc: blogsBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case InternetConnectivityNotAvailableState:
              return const Center(
                child: Text(
                  'Intenet Connection Not Available !',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            case CallingApiState:
              blogsBloc.add(FetchDataFromAPIEvent());
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            case FetchedDataFailedState:
              return const Center(
                  child: Text(
                'No data found',
                style: TextStyle(
                  color: Colors.white,
                ),
              ));
            case FetchedDataSuccessState:
              final successState = state as FetchedDataSuccessState;
              final List body =
                  json.decode(successState.response.body)["blogs"];
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
