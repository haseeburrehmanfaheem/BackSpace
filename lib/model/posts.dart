import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
part 'posts.g.dart';

@JsonSerializable(explicitToJson: true)
class Post {
  @Collection<Post>('post')
  final usersRef = PostCollectionReference();
  Post({
    required this.postId,
    required this.userEmail,
    this.subspaceId,
    required this.postTitle,
    required this.postContent,
    required this.postLikes,
    this.postImage,
  });

  final int postId;
  final String userEmail;
  final String? subspaceId;
  final String postTitle;
  final String postContent;
  final int postLikes;
  final String? postImage;
  final DateTime createdAt = DateTime.now();
}
