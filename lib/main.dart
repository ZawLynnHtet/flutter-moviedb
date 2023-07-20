import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/data/api.dart';
import 'package:movie_app/compoment/carousel.dart';
import 'package:movie_app/pages/collection_page.dart';
import 'package:movie_app/pages/download_page.dart';
import 'package:movie_app/pages/getstarted.dart';
import 'package:movie_app/compoment/movie_lists.dart';
import 'package:movie_app/pages/home_page.dart';
import 'package:movie_app/pages/mylist_page.dart';
import 'package:movie_app/pages/profile_page.dart';
import 'package:movie_app/pages/search_page.dart';
import 'package:movie_app/provider/favorite.dart';
import 'firebase_options.dart';
import 'data/movie_class.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FirebaseAuth.instance.currentUser == null
            ? const GetStartedPage()
            : const MoviesPage(),
      ),
    );
  }
}

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  int currentIndex = 0;
  List pages = [
    const HomePage(),
    const SearchPage(),
    const Collection(),
    const DownloadPage(),
    const ProfilePage()
  ];
  

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
    // page.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        unselectedLabelStyle: const TextStyle(
          fontSize: 12.0,
        ),
        iconSize: 25.0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.magnifyingGlass), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.rectangle_stack_fill),
              label: "Collection"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cloud_download_fill),
              label: "Download"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_fill), label: "Account"),
        ],
        currentIndex: currentIndex,
        onTap: onTap,
      ),
      body: pages[currentIndex]
    );
  }
}
