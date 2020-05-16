import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanoimuseum/landing_page.dart';
import 'package:hanoimuseum/mock_value.dart';

import 'hero_custom_tween.dart';

class MuseumDetails extends StatefulWidget {
  static String nameRoute = "/MuseumDetails";

  static Route<dynamic> route(ItemMuseum item) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
//      var begin = Offset(1.0, 0.0);
//      var end = Offset.zero;
      var begin = 0.0;
      var end = 1.0;
      var curve = Curves.linear;

      var tween = Tween<double>(begin: begin, end: end);
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return FadeTransition(
        opacity: tween.animate(curvedAnimation),
        child: child,
      );
    }, pageBuilder: (BuildContext context, animation, secondaryAnimation) {
      return MuseumDetails(
        item: item,
      );
    });
  }

  final ItemMuseum item;

  const MuseumDetails({Key key, this.item}) : super(key: key);

  @override
  _MuseumDetailsState createState() => _MuseumDetailsState();
}

class _MuseumDetailsState extends State<MuseumDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 24),
          child: BackButton(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sort,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: "headTitle${widget.item.title}",
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
                      child: Text("${splitTitle(widget.item.title).first}",
                          style: GoogleFonts.comfortaaTextTheme()
                              .headline1
                              .copyWith(
                                  fontSize: 28, fontWeight: FontWeight.bold)),
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
                              .copyWith(
                                  fontSize: 28, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Hero(
                tag: "sightImage${widget.item.title}",
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36),
                  child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
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
                              width: double.infinity,
                              height: 300,
                              color: Colors.white,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Icon(Icons.error), Text("Error")]),
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
              SizedBox(
                height: 20,
              ),
              DefaultTextStyle(
                style: GoogleFonts.comfortaa()
                    .copyWith(fontSize: 12, color: Colors.black),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("${widget.item.type}"),
                      Text("${widget.item.distance} km")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36),
                  child: Text(
                    dummyText,
                    style: GoogleFonts.comfortaa().copyWith(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Container(
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              color: Colors.red,
                              shadows: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    spreadRadius: 3)
                              ]),
                          height: 150,
                          width: 100,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Container(
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              color: Colors.red,
                              shadows: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    spreadRadius: 3)
                              ]),
                          height: 150,
                          width: 100,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Container(
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              color: Colors.red,
                              shadows: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    spreadRadius: 3)
                              ]),
                          height: 150,
                          width: 100,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
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
