/// Represents comment of gallery/image
class ImgurComment {
  /// The ID for the comment
  int id;

  /// The ID of the image that the comment is for
  String imageId;

  /// The comment itself.
  String comment;

  /// Username of the author of the comment
  String author;

  /// The account ID for the author
  int authorId;

  /// If this comment was done to an album
  bool onAlbum;

  /// The ID of the album cover image, this is what should be displayed for album comments
  String albumCover;

  /// Number of upvotes for the comment
  int ups;

  /// The number of downvotes for the comment
  int downs;

  /// the number of upvotes - downvotes
  int points;

  /// Timestamp of creation, epoch time
  int datetime;

  /// If this is a reply, this will be the value of the comment_id for the caption this a reply for.
  int parentId;

  /// Marked true if this caption has been deleted
  bool deleted;

  /// The current user's vote on the comment. null if not signed in or if the user hasn't voted on it.
  String vote;

  /// Array of comments	All of the replies for this comment. If there are no replies to the comment then this is an empty set.
  Map<int, ImgurComment> children;

  /// Raw data returned by API
  Map<String, dynamic> raw;

  /// Creates new instance of Comment
  ImgurComment(this.raw) {
    id = raw['id'];
    imageId = raw['image_id'];
    comment = raw['comment'];
    author = raw['author'];
    authorId = raw['author_id'];
    onAlbum = raw['on_album'];
    ups = raw['ups'];
    downs = raw['downs'];
    points = raw['points'];
    datetime = raw['datetime'];
    parentId = raw['parent_id'];
    deleted = raw['deleted'];
    vote = raw['vote'];

    if (raw['children'] != null) {
      raw['children'].forEach((o) {
        new ImgurComment(o);
      });
    }
  }
}
