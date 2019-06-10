import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:epicture/image_detail.dart';
import 'package:epicture/components/choice.dart';
import 'package:epicture/imgur_api/imgur_api.dart';

class Home extends StatefulWidget {
  static String tag = 'home';

  Home({Key key}) : super(key: key);

  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var api = new ImgurApi("b120b578012f7c2");
  var imageList = new List<ImgurImage>();
  var page = 0;
  var section = "hot";
  var sort = "viral";
  var window = "day";
  var viewGrid = true;
  var viewGridIcon = Icons.grid_on;
  var viewGridCount = 3;
  var portraitViewGridCount = 3;
  var paysageViewGridCount = 6;
  ScrollController _scrollController = new ScrollController();

  /*
   * Base state methods
   */
  @override
  void initState() {
    super.initState();

    var arrImages = update();

    arrImages.then((data) {
      data.forEach((img) {
        setState(() {
          imageList.add(img);
        });
      });
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print("scroll page " + page.toString());
        page++;

        var arrImages = update();

        arrImages.then((data) {
          data.forEach((img) {
            setState(() {
              imageList.add(img);
            });
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /*
   * Request and Update methods
   */
  Future<List<ImgurImage>> update() async {
    var galleries = await api.getGalleries(section: section, sort: sort, page: page, window: window);
    var images = new List<ImgurImage>();

    galleries.forEach((gallery) {
      if (gallery.images != null) {
        var image = gallery.images.values.first;

        if (image.link.contains(".png") || image.link.contains(".jpg") || image.link.contains(".gif")) {
          images.add(image);
        }
      }
    });

    return images;
  }

  Future<Null> updateWithScrollRefresh() async {
    print("scroll update");
    var arrImages = update();

    await Future.delayed(Duration(seconds: 1));

    arrImages.then((data) {
      imageList.clear();
      page = 0;
      data.forEach((img) {
        setState(() {
          imageList.add(img);
        });
      });
      refreshKey.currentState?.show(atTop: false);
    });

    return null;
  }

  void updateWithSelect() async {
    refreshKey.currentState?.show(atTop: true);
    var arrImages = update();

    await Future.delayed(Duration(seconds: 1));

    arrImages.then((data) {
      imageList.clear();
      page = 0;
      data.forEach((img) {
        setState(() {
          imageList.add(img);
        });
      });
      refreshKey.currentState?.show(atTop: false);
    });
  }

  /*
   * Display image method
   */
  Widget displayImage(ImgurImage image) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => new ImageDetail(
              image: image
            )
          ));
        },
        child: CachedNetworkImage(
          imageUrl: image.link,
          placeholder: Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              height: 32.0,
              width: 32.0
            )
          ),
          errorWidget: Center(
            child: SizedBox(
              child: Icon(Icons.error),
              height: 32.0,
              width: 32.0
            ),
          ),
          fit: BoxFit.cover,
          width: 128.0,
          height: 128.0,
        ),
      )
    );
  }

  /*
   * Filter select methods
   */
  void selectSection(Choice choice) async {
    setState(() {
      section = choice.title.toLowerCase();
    });
    updateWithSelect();
  }

  void selectSort(Choice choice) async {
    setState(() {
      sort = choice.title.toLowerCase();
    });

    updateWithSelect();
  }

  void selectWindow(Choice choice) async {
    setState(() {
      window = choice.title.toLowerCase();
    });

    updateWithSelect();
  }

  /*
   * Display mode methods
   */
  void updateGridDisplay() {
    final Orientation orientation = MediaQuery.of(context).orientation;

    if (viewGrid == true) {
      viewGridIcon = Icons.grid_on;
      viewGridCount = (orientation == Orientation.portrait) ? portraitViewGridCount : paysageViewGridCount;
    } else {
      viewGridIcon = Icons.grid_off;
      viewGridCount = 1;
    }
  }

  void changeGridViewNbr(Choice choice) async {
    List<String> nbr = choice.title.split(' - ');

    setState(() {
      portraitViewGridCount = int.parse(nbr[0]);
      paysageViewGridCount = int.parse(nbr[1]);
    });

    updateGridDisplay();
  }

  void changeDisplayMode() {
    setState(() {
      viewGrid = !viewGrid;
    });

    updateGridDisplay();
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
        icon: Icon(viewGridIcon),
        onPressed: () {
          changeDisplayMode();
        },
      ),
      PopupMenuButton<Choice>(
        icon: Icon(Icons.view_module),
        onSelected: changeGridViewNbr,
        itemBuilder: (BuildContext context) {
          return grid_view_choices.map((Choice choice) {
            return PopupMenuItem<Choice>(
              value: choice,
              child: Row(
                children: <Widget>[
                  Icon(
                    choice.icon,
                    color: Theme.of(context).accentColor
                  ),
                  Text(
                    choice.title,
                    style: TextStyle(
                      color: Theme.of(context).accentColor
                    )
                  )
                ],
              ),
            );
          }).toList();
        },
      ),
      PopupMenuButton<Choice>(
        icon: Icon(Icons.trending_up),
        onSelected: selectSection,
        itemBuilder: (BuildContext context) {
          return section_choices.map((Choice choice) {
            return PopupMenuItem<Choice>(
              value: choice,
              child: Row(
                children: <Widget>[
                  Icon(
                    choice.icon,
                    color: Theme.of(context).accentColor
                  ),
                  Text(
                    choice.title,
                    style: TextStyle(
                      color: Theme.of(context).accentColor
                    )
                  )
                ],
              ),
            );
          }).toList();
        },
      ),
      PopupMenuButton<Choice>(
        icon: Icon(Icons.sort),
        onSelected: selectSort,
        itemBuilder: (BuildContext context) {
          return sort_choices.map((Choice choice) {
            return PopupMenuItem<Choice>(
              value: choice,
              child: Row(
                children: <Widget>[
                  Icon(
                    choice.icon,
                    color: Theme.of(context).accentColor
                  ),
                  Text(
                    choice.title,
                    style: TextStyle(
                      color: Theme.of(context).accentColor
                    )
                  )
                ],
              ),
            );
          }).toList();
        },
      ),
      PopupMenuButton<Choice>(
        icon: Icon(Icons.today),
        onSelected: selectWindow,
        itemBuilder: (BuildContext context) {
          return window_choices.map((Choice choice) {
            return PopupMenuItem<Choice>(
              value: choice,
              child: Row(
                children: <Widget>[
                  Icon(
                    choice.icon,
                    color: Theme.of(context).accentColor
                  ),
                  Text(
                    choice.title,
                    style: TextStyle(
                      color: Theme.of(context).accentColor
                    )
                  )
                ],
              ),
            );
          }).toList();
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Epicture"),
        actions: makeAppBarActions()
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: updateWithScrollRefresh,
        child: OrientationBuilder(
          builder: (context, orientation) {
            updateGridDisplay();

            return GridView.builder(
              itemCount: imageList?.length,
              controller: _scrollController,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                crossAxisCount: viewGridCount
              ),
              itemBuilder: (BuildContext context, int index) {
                return GridTile(
                  child: displayImage(imageList[index]),
                );
              },
            );
          }
        )
      )
    );
  }
}

/*
 * Filter : Section, sort and window choices list
 */
const List<Choice> section_choices = const <Choice>[
  const Choice(title: 'Hot', icon: Icons.new_releases),
  const Choice(title: 'Top', icon: Icons.trending_up),
];

const List<Choice> sort_choices = const <Choice>[
  const Choice(title: 'Viral', icon: Icons.trending_up),
  const Choice(title: 'Top', icon: Icons.trending_up),
  const Choice(title: 'Time', icon: Icons.access_time),
];

const List<Choice> window_choices = const <Choice>[
  const Choice(title: 'Day', icon: Icons.today),
  const Choice(title: 'Week', icon: Icons.today),
  const Choice(title: 'Month', icon: Icons.today),
  const Choice(title: 'Year', icon: Icons.today),
  const Choice(title: 'All', icon: Icons.all_inclusive),
];

const List<Choice> grid_view_choices = const <Choice>[
  const Choice(title: '2 - 4'),
  const Choice(title: '3 - 6'),
  const Choice(title: '4 - 8'),
];
