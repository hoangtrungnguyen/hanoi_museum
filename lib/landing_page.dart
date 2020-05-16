import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanoimuseum/favorite_museum_model.dart';
import 'package:hanoimuseum/mock_value.dart';
import 'package:hanoimuseum/museum_list_item.dart';
import 'package:provider/provider.dart';

import 'hero_custom_tween.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  double paddingItem = 48;
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this)
          ..forward();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.addListener(() {
//      if (_controller.status == AnimationStatus.completed) {
//        _controller.reverse();
//      } else if (_controller.status == AnimationStatus.dismissed) {
//        _controller.forward();
//      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SlideTransition(
            position: _offsetAnimation,
            child: NavigationRail(
                minWidth: 56.0,
//              groupAlignment: 1.0,
                labelType: NavigationRailLabelType.all,
                backgroundColor: Colors.orangeAccent,
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                leading: SafeArea(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                              "https://i.insider.com/5df126b679d7570ad2044f3e?width=1100&format=jpeg&auto=webp"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RotatedBox(
                        quarterTurns: -1,
                        child: IconButton(
                          icon: Icon(Icons.tune),
                          color: Colors.black,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                destinations: [
                  buildRotatedTextRailDestination("All", 8),
//                buildRotatedTextRailDestination("Outdoor", 8),
//                buildRotatedTextRailDestination("Indoor", 8),
                  buildRotatedTextRailDestination("History", 8),
                  buildRotatedTextRailDestination("Intellectual", 8),
                  buildRotatedTextRailDestination("Culture", 8),
                  buildRotatedTextRailDestination("Architecture", 8),
                  buildRotatedTextRailDestination("Art", 8),
                ],
                selectedIndex: _selectedIndex),
          ),
          VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                    CounterFavorite(),
                    SizedBox(
                      width: 10,
                    )
                  ],
//                  title: Text("Hiện vật",style: TextStyle(color: Colors.black),),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.symmetric(horizontal: paddingItem),
                    collapseMode: CollapseMode.parallax,
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sight",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Hanoi",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  expandedHeight: 100,
                  centerTitle: false,
                  titleSpacing: 0,
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                      padding: EdgeInsets.only(
                          left: paddingItem, right: 48, top: 24, bottom: 24),
                      child: Item(items[index]));
                }, childCount: items.length)),
              ],
            ),
          )
        ],
      ),
    );
  }

  NavigationRailDestination buildRotatedTextRailDestination(
      String text, double padding,
      {Widget icon, Widget label}) {
    return NavigationRailDestination(
      icon: SizedBox.shrink(),
      label: Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            text,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}

class ItemMuseum {
  String title;
  String type;
  String imageUrl;
  bool isFavourite = false;
  int distance = Random().nextInt(100);

  ItemMuseum(this.title, this.type, this.imageUrl);
}

class Item extends StatefulWidget {
  final ItemMuseum item;

  Item(this.item);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteModelMuseum>(
      builder:
          (BuildContext context, FavouriteModelMuseum value, Widget child) =>

//      direction: DismissDirection.endToStart,
              Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              Hero(
                flightShuttleBuilder: (
                  BuildContext flightContext,
                  Animation<double> animation,
                  HeroFlightDirection flightDirection,
                  BuildContext fromHeroContext,
                  BuildContext toHeroContext,
                ) {
                  if (flightDirection == HeroFlightDirection.push)
                    return ScaleTransition(
                      scale: animation,
                      child: toHeroContext.widget,
                    );
                  else {
                    return toHeroContext.widget;
                  }
                },
                tag: "headTitle${widget.item.title}",
                child: Text("${splitTitle(widget.item.title)[0]} ",
                    style: GoogleFonts.comfortaaTextTheme()
                        .headline1
                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              Hero(
                  flightShuttleBuilder: (
                    BuildContext flightContext,
                    Animation<double> animation,
                    HeroFlightDirection flightDirection,
                    BuildContext fromHeroContext,
                    BuildContext toHeroContext,
                  ) {
                    animation.addListener(() {
                      print(animation.value);
                    });
                    if (flightDirection == HeroFlightDirection.push)
                      return ScaleTransition(
                        scale: animation,
                        child: toHeroContext.widget,
                      );
                    else {
                      return toHeroContext.widget;
                    }
                  },
                  tag: "tailTitle${widget.item.title}",
                  child: Text("${splitTitle(widget.item.title)[1]}",
                      style: GoogleFonts.comfortaaTextTheme()
                          .headline1
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold)))
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(height: 250, child: SwipeableItem(widget.item)),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              Text("${widget.item.type}"),
              Icon(
                Icons.bookmark,
                color: Colors.black12,
              )
            ],
          )
        ],
      ),
    );
  }

  List<String> splitTitle(String title) {
    List<String> ss = title.split(" ");
    List<String> arr = [];
    arr.add(ss.getRange(0, 2).join(" "));
    arr.add(ss[2]);
    print(arr);
    return arr;
  }
}

class CounterFavorite extends StatefulWidget {
  @override
  _CounterFavoriteState createState() => _CounterFavoriteState();
}

class _CounterFavoriteState extends State<CounterFavorite> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteModelMuseum>(
      builder: (BuildContext context, value, Widget child) => Badge(
        position: BadgePosition.topLeft(top: 5, left: 10),
        animationType: BadgeAnimationType.fade,
        child: Icon(
          Icons.bookmark,
          color: Colors.black,
        ),
        elevation: value.favourite.length == 0 ? 0 : 4,
        badgeContent: SizedBox(
          width: 10,
          height: 10,
          child: Center(
            child: Text(
              "${value.favourite.length}",
              style: TextStyle(color: Colors.white, fontSize: 6),
            ),
          ),
        ),
      ),
    );
  }
}

class SwipeableItem extends StatefulWidget {
  final ItemMuseum item;

  SwipeableItem(this.item);

  @override
  _SwipeableItemState createState() => _SwipeableItemState();
}

class _SwipeableItemState extends State<SwipeableItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int count = 0;

  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.dismissed) {
        count += 1;
      }
    });

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.7, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
//      print(_controller.value);
//      if (_controller.status == AnimationStatus.dismissed && count == 1) {
//        Provider.of<FavouriteModelMuseum>(context, listen: false)
//            .add(widget.item);
//      }
      if (_controller.value >= 0.7) {
        Provider.of<FavouriteModelMuseum>(context, listen: false)
            .add(widget.item);
      }
    });
    return Consumer<FavouriteModelMuseum>(
      builder: (BuildContext context, FavouriteModelMuseum value,
              Widget child) =>
          GestureDetector(
              onHorizontalDragStart: (DragStartDetails details) {
                _controller.value = 1 -
                    (details.globalPosition.dx /
                        MediaQuery.of(context).size.width);
              },
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                _controller.value = 1 -
                    (details.globalPosition.dx /
                        MediaQuery.of(context).size.width);
              },
              onHorizontalDragEnd: (DragEndDetails details) {
                _controller.reverse();
              },
              onTap: () async {
                Navigator.of(context).push(MuseumDetails.route(widget.item));
              },
              child: Stack(children: [
                Align(
                    alignment: Alignment(0.8, 0),
                    child: value.favourite.contains(widget.item)
                        ? Icon(
                            Icons.favorite,
                            color: Colors.pink,
                          )
                        : Icon(Icons.favorite_border)),
                Positioned.fill(
                  child: SlideTransition(
                    position: _animation,
                    child: Hero(
                      tag: "sightImage${widget.item.title}",
                      child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
//                  decoration: BoxDecoration(boxShadow: [
//                    BoxShadow(
//                      color: Colors.grey.withOpacity(0.5),
//                      spreadRadius: 3,
//                      blurRadius: 10,
//                      offset: Offset(0, 3), // changes position of shadow
//                    ),
//                  ], borderRadius: BorderRadius.circular(16)),
//                  height: double.infinity,
//                  width: double.infinity,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: FadeInImage.assetNetwork(
                              imageErrorBuilder: (
                                BuildContext context,
                                Object error,
                                StackTrace stackTrace,
                              ) {
                                return Container(
                                  color: Colors.white,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.error),
                                        Text("Error")
                                      ]),
                                );
                              },
                              image: widget.item.imageUrl,
                              placeholder: "assets/images/loading.gif",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          )),
                    ),
                  ),
                ),
              ])),
    );
  }
}
