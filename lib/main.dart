import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hanoimuseum/favorite_museum_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'landing_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(create: (BuildContext context) {
          return FavouriteModelMuseum();
        },)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.comfortaaTextTheme(),
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LandingPage()
      ),
    );
  }
}
