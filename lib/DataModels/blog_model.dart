class BlogModel {
  late String id, title, image_url;

  BlogModel({required this.id, required this.title, required this.image_url});

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image_url = json['image_url'];
  }
}
