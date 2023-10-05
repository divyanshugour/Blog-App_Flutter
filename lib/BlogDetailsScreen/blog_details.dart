import 'package:blog_explorer/BlogDetailsScreen/blog_details_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogDetails extends StatefulWidget {
  BlogDetails(
      {super.key,
      required this.title,
      required this.id,
      required this.image_url});
  String title, id, image_url;

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  BlogDetailsBloc blogsDetailsBloc = BlogDetailsBloc();
  bool is_favorite = false;

  @override
  void initState() {
    // TODO: implement initState
    blogsDetailsBloc.add(DisplayDataOnScreenEvent(
        id: widget.id, title: widget.title, image_url: widget.image_url));
    print('hii');
    super.initState();
  }

  Widget dataTile(icon, title, subtitle) {
    return ListTile(
      leading: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(10),
          ),
          child: icon),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: blogsDetailsBloc,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DisplayDataOnScreenState) {
            final successState = state as DisplayDataOnScreenState;
            return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniCenterFloat,
              extendBodyBehindAppBar: true,
              floatingActionButton: is_favorite
                  ? FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      label: const Text(
                        'Remove From Favorites',
                        style: TextStyle(fontSize: 18),
                      ),
                      icon: const Icon(Icons.bookmark_rounded),
                      onPressed: () {
                        is_favorite = false;
                        blogsDetailsBloc.add(DisplayDataOnScreenEvent(
                            id: successState.id,
                            title: successState.title,
                            image_url: successState.image_url));
                      },
                    )
                  : FloatingActionButton.extended(
                      backgroundColor: Colors.white,
                      label: const Text(
                        'Mark as Favorite',
                        style: TextStyle(fontSize: 18),
                      ),
                      icon: Icon(Icons.bookmark_add_rounded),
                      onPressed: () {
                        is_favorite = true;
                        blogsDetailsBloc.add(DisplayDataOnScreenEvent(
                            id: successState.id,
                            title: successState.title,
                            image_url: successState.image_url));
                      },
                    ),
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: successState.image_url,
                      imageBuilder: (context, imageProvider) => Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(11),
                          image: DecorationImage(
                            image: NetworkImage(successState.image_url),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: const Center(
                            child: Icon(
                          Icons.error_outline,
                          size: 35,
                          color: Colors.white,
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            successState.title,
                            style: const TextStyle(
                                fontSize: 30, color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          dataTile(
                              const Icon(
                                Icons.account_circle,
                                size: 30,
                              ),
                              "SubSpace",
                              'Publisher'),
                          dataTile(
                              const Icon(
                                Icons.calendar_month_rounded,
                                size: 30,
                              ),
                              '22 April, 2023 | 5:50 PM',
                              'Published On'),
                          SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              'Description',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Text(
                              'A blog (a truncation of "weblog")[1] is an informational website published on the World Wide Web consisting of discrete, often informal diary-style text entries (posts). Posts are typically displayed in reverse chronological order so that the most recent post appears first, at the top of the web page. Until 2009, blogs were usually the work of a single individual,[citation needed] occasionally of a small group, and often covered a single subject or topic. In the 2010s, "multi-author blogs" (MABs) emerged, featuring the writing of multiple authors and sometimes professionally edited. MABs from newspapers, other media outlets, universities, think tanks, advocacy groups, and similar institutions account for an increasing quantity of blog traffic. The rise of Twitter and other "microblogging" systems helps integrate MABs and single-author blogs into the news media. Blog can also be used as a verb, meaning to maintain or add content to a blog.',
                              textAlign: TextAlign.justify,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        });
  }
}
