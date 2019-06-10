import 'ImgurAlbum.dart';
import '../util/HttpWrapper.dart';
import 'ImgurComment.dart';
import 'dart:async';

/// Imagur's gallery, can be gallery or subreddit gallery.
class ImgurGallery extends ImgurAlbum {
  /// Upvotes for the image
  int ups;

  /// Number of downvotes for the image
  int downs;

  /// Upvotes minus downvotes
  int points;

  /// Imgur popularity score
  int score;

  /// if it's an album or not
  bool isAlbum;

  /// The current user's vote on the album. null if not signed in or if the user hasn't voted on it.
  String vote;

  /// Number of comments on the gallery album.
  int commentCount;

  /// Topic of the gallery album.
  String topic;

  /// Topic ID of the gallery album.
  int topicId;

  /// Indicates if the album is in the most viral gallery or not
  bool inMostViral;

  HttpWrapper _http;

  /// Creates new instance of Gallery
  ImgurGallery(Map<String, dynamic> raw, this._http) : super(raw, _http) {
    ups = raw['ups'];
    downs = raw['downs'];
    points = raw['points'];
    score = raw['score'];
    isAlbum = raw['is_album'];
    vote = raw['vote'];
    commentCount = raw['comment_count'];
    topic = raw['topic'];
    topicId = raw['topic_id'];
    inMostViral = raw['in_most_viral'];
  }

  /// Returns list of comments attached to this Gallery
  Future<List<ImgurComment>> getComments({String commentSort: "best"}) async {
    var res = await _http.createRequest(
        "GET", "/gallery/${this.id}/comments/$commentSort");

    var tmp = new List<ImgurComment>();
    res.response['data'].forEach((o) {
      tmp.add(new ImgurComment(o));
    });

    return tmp;
  }
}
