import '../util/HttpWrapper.dart';
import 'ImgurImage.dart';

import 'dart:async';

/// Represents user album
class ImgurAlbum {
  /// The ID for the album
  String id;

  /// The title of the album in the gallery
  String title;

  /// The description of the album in the gallery
  String description;

  /// Time inserted into the gallery, epoch time
  int datetime;

  /// The ID of the album cover image
  String cover;

  /// The width, in pixels, of the album cover image
  int coverWidth;

  /// The height, in pixels, of the album cover image
  int coverHeight;

  /// The account username or null if it's anonymous.
  String accountUrl;

  /// The account ID or null if it's anonymous.
  int accountId;

  /// The privacy level of the album, you can only view public if not logged in as album owner
  String privacy;

  /// The view layout of the album.
  String layout;

  /// The number of album views
  int views;

  /// The URL link to the album
  String link;

  /// Indicates if the current user favorited the image. Defaults to false if not signed in.
  bool favorite;

  /// Indicates if the image has been marked as nsfw or not. Defaults to null if information is not available.
  bool nsfw;

  /// If the image has been categorized by our backend then this will contain the section the image belongs in. (funny, cats, adviceanimals, wtf, etc)
  String section;

  /// Order number of the album on the user's album page (defaults to 0 if their albums haven't been reordered)
  int order;

  /// OPTIONAL, the deletehash, if you're logged in as the album owner
  String deleteHash;

  /// The total number of images in the album
  int imagesCount;

  /// Array of Images	An array of all the images in the album (only available when requesting the direct album)
  Map<String, ImgurImage> images;

  /// True if the image has been submitted to the gallery, false if otherwise.
  bool inGallery;

  /// Raw response returned by API
  Map<String, dynamic> raw;

  HttpWrapper _http;

  ImgurAlbum(this.raw, this._http) {
    id = raw['id'];
    title = raw['title'];
    description = raw['description'];
    datetime = raw['datetime'];
    cover = raw['cover'];
    coverWidth = raw['cover_width'];
    coverHeight = raw['cover_height'];
    accountUrl = raw['account_url'];
    accountId = raw['account_id'];
    privacy = raw['privacy'];
    layout = raw['layout'];
    views = raw['views'];
    link = raw['link'];
    favorite = raw['favorite'];
    nsfw = raw['nsfw'];
    section = raw['section'];
    order = raw['order'];
    deleteHash = raw['deletehash'];
    imagesCount = raw['images_count'];
    inGallery = raw['in_gallery'];

    if (raw['images'] != null) {
      images = new Map();
      raw['images'].forEach((o) {
        new ImgurImage(o, this._http, this);
      });
    }
  }

  /// Gets image located in this album
  Future<ImgurImage> getImage(String id) async {
    var res = await _http.createRequest("GET", "/album/${this.id}/image/$id");
    return new ImgurImage(res.response['data'], _http, this);
  }
}
