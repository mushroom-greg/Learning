import 'package:flutter/material.dart';
import 'package:epicture/search_list.dart';
import 'package:epicture/imgur_api/imgur_api.dart';

class Search extends StatefulWidget {
  static String tag = 'search';

  @override
  State<StatefulWidget> createState() {
    return new SearchState();
  }
}

class SearchState extends State<Search> {
  var api = new ImgurApi("b120b578012f7c2");
  var tagList = List<ImgurTag>();
  ScrollController _scrollController = new ScrollController();

  /*
   * Request and Update methods
   */
  Future<List<ImgurTag>> update() async {
    var tags = await api.getTags();

    return tags;
  }

  @override
  void initState() {
    super.initState();

    var arrTags = update();

    arrTags.then((tags) {
      setState(() {
        tagList = tags;
      });
    });
  }

  /*
   * Display tag method
   */
  Widget displayTag(ImgurTag tag) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          /*
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => new ImageDetail(
              image: image
            )
          ));
          */
        },
        child: ListTile(
          leading: Icon(Icons.label),
          title: Text(tag.displayName),
          subtitle: Text(
            'Followers: ' + tag.followers.toString() + ' - '
            'Items : ' + tag.totalItems.toString()
          ),
        ),
      ),
    );
  }

  /*
   * Template methods
   */
  List<Widget> makeAppBarActions() {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.arrow_upward),
        onPressed: () {
          _scrollController.jumpTo(1);
        },
      ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchList(),
            )
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        actions: makeAppBarActions(),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return ListView.builder(
            itemCount: tagList?.length,
            controller: _scrollController,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: displayTag(tagList[index]),
              );
            },
          );
        }
      )
    );
  }
}
