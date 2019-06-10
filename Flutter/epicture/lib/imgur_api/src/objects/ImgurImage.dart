import 'ImgurAlbum.dart';
import 'ImgurComment.dart';

import '../util/HttpWrapper.dart';

import 'dart:async';

/// Represent single image
class ImgurImage {
  /// The ID for the image
  String id;

  /// The title of the image.
  String title;

  /// Description of the image.
  String description;

  /// Time uploaded, epoch time
  int datetime;

  /// Image MIME type.
  String type;

  /// is the image animated
  bool animated;

  /// The width of the image in pixels
  int width;

  /// The height of the image in pixels
  int height;

  /// The size of the image in bytes
  int size;

  /// The number of image views
  int views;

  /// Bandwidth consumed by the image in bytes
  int bandwidth;

  /// OPTIONAL, the deletehash, if you're logged in as the image owner
  String deleteHash;

  /// OPTIONAL, the original filename, if you're logged in as the image owner
  String name;

  /// If the image has been categorized by our backend then this will contain the section the image belongs in. (funny, cats, adviceanimals, wtf, etc)
  String section;

  /// The direct link to the the image. (Note: if fetching an animated GIF that was over 20MB in original size, a .gif thumbnail will be returned)
  String link;

  /// OPTIONAL, The .gifv link. Only available if the image is animated and type is 'image/gif'.
  String gifv;

  /// OPTIONAL, The direct link to the .mp4. Only available if the image is animated and type is 'image/gif'.
  String mp4;

  /// OPTIONAL, The Content-Length of the .mp4. Only available if the image is animated and type is 'image/gif'. Note that a zero value (0) is possible if the video has not yet been generated
  int mp4Size;

  /// OPTIONAL, Whether the image has a looping animation. Only available if the image is animated and type is 'image/gif'.
  bool looping;

  /// Indicates if the current user favorited the image. Defaults to false if not signed in.
  bool favorite;

  /// Indicates if the image has been marked as nsfw or not. Defaults to null if information is not available.
  bool nsfw;

  /// The current user's vote on the album. null if not signed in, if the user hasn't voted on it, or if not submitted to the gallery.
  String vote;

  /// True if the image has been submitted to the gallery, false if otherwise.
  bool inGallery;

  /// Album in which images is.
  ImgurAlbum album;

  /// Raw response returned by API
  Map<String, dynamic> raw;

  HttpWrapper _http;

  /// Creates new instance of Image
  ImgurImage(this.raw, this._http, this.album) {
    id = raw['id'];
    title = raw['title'];
    description = raw['description'];
    datetime = raw['datetime'];
    type = raw['type'];
    animated = raw['animated'];
    width = raw['width'];
    height = raw['height'];
    size = raw['size'];
    views = raw['views'];
    bandwidth = raw['bandwidth'];
    deleteHash = raw['deletehash'];
    name = raw['name'];
    section = raw['section'];
    link = raw['link'];
    gifv = raw['gifv'];
    mp4 = raw['mp4'];
    mp4Size = raw['mp4_size'];
    looping = raw['looping'];
    favorite = raw['favorite'];
    nsfw = raw['nsfw'];
    vote = raw['vote'];
    inGallery = raw['in_gallery'];

    if (this.album != null) this.album.images[id] = this;
  }

  @deprecated

  /// Get comments of image
  Future<List<ImgurComment>> getComments({String commentSort: "best"}) async {
    var res = await _http.createRequest(
        "GET", "/gallery/${this.id}/comments/$commentSort");

    var tmp = new List();
    res.response['data'].forEach((o) {
      tmp.add(new ImgurComment(o));
    });

    return tmp;
  }

  String customLink(ImageSize imageSize) {
    if (mp4Size != null) return link;

    var collection = link.split(".");

    void _prep(String m) {
      collection[collection.length - 2] =
          "${collection[collection.length - 2]}$m";
    }

    switch (imageSize) {
      case ImageSize.smallSquare:
        _prep("s");
        break;
      case ImageSize.bigSquare:
        _prep("b");
        break;
      case ImageSize.smallThumbnail:
        _prep("t");
        break;
      case ImageSize.mediumThumbnail:
        _prep("m");
        break;
      case ImageSize.largeThumbnail:
        _prep("l");
        break;
      case ImageSize.hugeThumbnail:
        _prep("h");
        break;
    }

    return collection.join(".");
  }
}

enum ImageSize {
  smallSquare,
  bigSquare,
  smallThumbnail,
  mediumThumbnail,
  largeThumbnail,
  hugeThumbnail
}
