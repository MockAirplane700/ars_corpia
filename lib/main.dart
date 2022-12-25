import 'package:ars_corpia/constants/variables.dart';
import 'package:ars_corpia/logic/cart_items_bloc.dart';
import 'package:ars_corpia/pages/about_reviewers.dart';
import 'package:ars_corpia/pages/checkout_page.dart';
import 'package:ars_corpia/pages/home.dart';
import 'package:ars_corpia/pages/markers_reviews.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    Home(),
    MarkerReviews(),
    AboutReviewers(),
    CheckoutPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            const BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.youtube) , label: 'Markers'),
            const BottomNavigationBarItem(icon: Icon(Icons.people), label: 'About'),
            BottomNavigationBarItem(icon: Badge(
              badgeContent: StreamBuilder(
                  builder: (context , snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data['cart items'] != null ? Text(snapshot.data['cart items'].length.toString()) : const Text('0');
                    }else{
                      return const Text('0');
                    }//end if-else
                  },
                stream: bloc.getStream,
              ),
              child: const Icon(Icons.shopping_cart),
            ), label: 'Cart')
          ],
        selectedItemColor: iconColor,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
