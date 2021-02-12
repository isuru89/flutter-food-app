// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:delizious/model/cart.dart';
import 'package:delizious/screens/cart_panel.dart';
import 'package:delizious/screens/checkout_screen.dart';
import 'package:delizious/screens/item_modal.dart';
import 'package:provider/provider.dart';
import 'widgets/restaurant_header.dart';
import 'constants.dart';

import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MyApp()
    )
  );
}


class Pair {
  final String name;
  final double height;

  const Pair({ this.name, this.height: 300 });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      routes: {
        '/item': (_) => ItemModal(),
        '/checkout': (_) => CheckoutPage()
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/cart") {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) => CartPanel(),
            transitionsBuilder: (_, anim, __, child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: anim.drive(tween),
                child: child,
              );
            }
          );
        }
        return MaterialPageRoute(builder: null);
      },
      title: 'Delicious Food App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        primaryColor: kPrimaryColor,
        dividerColor: kPrimaryColor,
        accentColor: kPrimaryColor.shade800,
        errorColor: kErrorColor,
        textTheme: GoogleFonts.montserratTextTheme(textTheme).copyWith(
          headline3: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: kPrimaryColor),
          headline4: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          headline5: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          headline6: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          subtitle1: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          subtitle2: TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
        )
      ),
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DeliciousFoodApp(),
    );
  }

  // Widget _slidingScaffold(ThemeData themeData) {
  //   return Scaffold(
  //       body: SlidingUpPanel(
  //         minHeight: 60,
  //         backdropEnabled: true,
  //         margin: EdgeInsets.only(left: 5, right: 5),
  //         boxShadow: [BoxShadow(
  //             color: Colors.black54,
  //             blurRadius: 20,
  //             offset: Offset(0, 0)
  //         )],
  //         borderRadius: BorderRadius.only(topRight: Radius.circular(60), topLeft: Radius.circular(60)),
  //         collapsed: Container(
  //           height: 100,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.only(topRight: Radius.circular(60), topLeft: Radius.circular(60)),
  //             color: themeData.primaryColor,
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               Center(child: IconButton(icon: Icon(Icons.shopping_cart, size: 32,))),
  //               Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //                 decoration: BoxDecoration(
  //                     color: themeData.accentColor,
  //                     borderRadius: BorderRadius.circular(10),
  //                     boxShadow: [
  //                       BoxShadow(
  //                           blurRadius: 3,
  //                           color: themeData.primaryColor,
  //                           offset: Offset(0, 0),
  //                           spreadRadius: 1
  //                       )
  //                     ]
  //                 ),
  //                 child: Text(
  //                     "\$123.27",
  //                     style: themeData.textTheme.headline3.copyWith(color: Colors.white)
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         panelBuilder: (ScrollController sc) => createCartPanel(sc),
  //         body: Sample3(),
  //       )
  //   );
  // }
}
