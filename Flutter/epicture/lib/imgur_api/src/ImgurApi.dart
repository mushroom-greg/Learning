import 'dart:async';
import 'util/HttpWrapper.dart';
import 'objects/ImgurAlbum.dart';
import 'objects/ImgurGallery.dart';
import 'objects/ImgurImage.dart';
import 'objects/ImgurTag.dart';

/// Main class of ImgurApi.
class ImgurApi {
  HttpWrapper _http;

  /// Creates new instance of [ImgurApi]. [clientSecret] parameters isn't required yet due library isn't using any `POST` endpoints.
  ImgurApi(String clientId, {String clientSecret: ""}) {
    _http = new HttpWrapper(clientId, clientSecret);
  }

  /// Returns album with given id.
  Future<ImgurAlbum> getAlbum(String id) async {
    var res = await _http.createRequest("GET", "/album/$id");

    return new ImgurAlbum(res.response['data'], _http);
  }

  /// Docs: https://apidocs.imgur.com/#311b0a17-29d2-48f5-b5cd-09dcc12863f5
  /// Returns List of galleries.
  Future<List<ImgurGallery>> getGalleries({
    String section: "hot",
    String sort: "viral",
    int page: 0,
    String window: "day",
    bool showViral: true,
    bool mature: true,
  }) async {
    var res = await _http
        .createRequest("GET", "/gallery/$section/$sort/$window/$page", params: {
      "showViral": showViral.toString(),
      "mature": mature.toString(),
      "album_previews": "true"
    });
    var tmp = new List<ImgurGallery>();

    res.response['data'].forEach((e) {
      tmp.add(new ImgurGallery(e, _http));
    });

    return tmp;
  }

  /// Gets gallery based on given id
  Future<ImgurGallery> getGallery(String id) async {
    var res = await _http.createRequest("GET", "/gallery/album/$id");

    return new ImgurGallery(res.response['data'], _http);
  }

  /// Gets subreddit list of images
  Future<List<ImgurImage>> getSubreddit(String id,
      {String sort: "time", int page: 0, String window: "week"}) async {
    var res = await _http.createRequest("GET", "/gallery/r/$id/$sort/$window/$page");
    var tmp = new List<ImgurImage>();

    res.response['data'].forEach((o) {
      tmp.add(new ImgurImage(o, _http, null));
    });

    return tmp;
  }

  /// Search on Imgur for gallery using [query].
  Future<List<ImgurGallery>> searchGallery(String query,
      {String sort: "time", String window: "all", int page: 0}) async {
    var res = await _http.createRequest(
        "GET", "/gallery/search/$sort/$window/$page",
        params: {"q": query});

    var tmp = new List<ImgurGallery>();

    res.response['data'].forEach((o) {
      tmp.add(new ImgurGallery(o, _http));
    });

    return tmp;
  }

  /// Gets tag list
  Future<List<ImgurTag>> getTags() async {
    var res = await _http.createRequest("GET", "/tags");
    var tmp = new List<ImgurTag>();

    res.response['data']['tags'].forEach((o) {
      tmp.add(new ImgurTag(o));
    });

    return tmp;
  }
}
