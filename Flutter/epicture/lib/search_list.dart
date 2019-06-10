import 'dart:async';
import 'package:flutter/material.dart';
import 'package:epicture/image_gallery_detail.dart';
import 'package:epicture/imgur_api/imgur_api.dart';

class SearchList extends StatefulWidget {
  static String tag = 'search-list';

  SearchList({Key key});

  @override
  SearchListState createState() => new SearchListState();
}

class SearchListState extends State<SearchList> {
  var api = new ImgurApi("b120b578012f7c2");
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  bool _isSearching = false;
  String _error;
  List<ImgurGallery> _results = new List<ImgurGallery>();

  Timer debounceTimer;

  SearchListState() {
    _searchQuery.addListener(() {
      if (debounceTimer != null) {
        debounceTimer.cancel();
      }

      debounceTimer = Timer(Duration(milliseconds: 500), () {
        if (this.mounted) {
          performSearch(_searchQuery.text);
        }
      });
    });
  }

  void performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _error = null;
        _results = List();
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
      _results = List();
    });

    final resultsGalleries = await api.searchGallery(query);

    if (this._searchQuery.text == query && this.mounted) {
      _results.clear();

      if (resultsGalleries != null) {
        resultsGalleries.forEach((gallery) {
          if (gallery.images != null) {
            if (gallery.images.values != null) {
              var image = gallery.images.values.first;

              if (image.link.contains(".png") || image.link.contains(".jpg") || image.link.contains(".gif")) {
                setState(() {
                  _results.add(gallery);
                });
              }
            }
          }
        });
      } else {
        setState(() {
          _error = 'Error when searching galleries';
        });
      }

      setState(() {
        _isSearching = false;
      });
    }
  }

  Widget displayGalleryImage(ImgurGallery gallery) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => new ImageGalleryDetail(
              gallery: gallery,
            )
          ));
        },
        child: ListTile(
          leading: Icon(Icons.photo_library),
          title: Text(gallery.title),
          subtitle: Text(
            'Author : ' + gallery.accountUrl + ' - '
            'Views : ' + gallery.views.toString()
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          controller: _searchQuery,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search galleries ...",
            hintStyle: TextStyle(color: Colors.white)
          ),
        ),
        leading: buildLeading(context),
        actions: buildActions(context),
      ),
      body: buildBody(context)
    );
  }

  Widget buildBody(BuildContext context) {
    if (_isSearching) {
      return CenterTitle('Searching ...');
    } else if (_error != null) {
      return CenterTitle(_error);
    } else if (_searchQuery.text.isEmpty) {
      return CenterTitle('Begin search by typing on search bar :)');
    } else {
      return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        itemCount: _results?.length,
        itemBuilder: (BuildContext context, int index) {
          return displayGalleryImage(_results[index]);
        },
      );
    }
  }

  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          _searchQuery.clear();
        },
      )
    ];
  }
}

class CenterTitle extends StatelessWidget {
  final String title;

  CenterTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      )
    );
  }
}
