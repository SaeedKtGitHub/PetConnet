

import 'package:pet_connect/data/model/user.dart';

class Post {
  String date;
  String image;
  String title;
  String animalIcon;
  User user;
  String content;
  List<String> tags;

  Post({
    required this.date,
    required this.image,
    required this.title,
    required this.animalIcon,
    required this.user,
    required this.content,
    required this.tags,
  });
}

// void main() {
//   // Example usage:
//   User author = User(/* Initialize user properties */);
//
//   Post myPost = Post(
//     date: "2023-12-06",
//     image: "path/to/image.jpg",
//     title: "My Awesome Post",
//     animalIcon: "🐾",
//     user: author,
//     content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
//     tags: ["tag1", "tag2", "tag3"],
//   );

//   // Accessing post attributes
//   print("Post Title: ${myPost.title}");
//   print("Author: ${myPost.user.name}"); // Assuming User class has a 'name' property
//   print("Tags: ${myPost.tags.join(', ')}");
// }

