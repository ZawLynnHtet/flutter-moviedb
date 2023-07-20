import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/provider/favorite.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {

  List<String> image = [];

  checkFisrtRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstRun = (prefs.getBool('firstRun') ?? true);

    await prefs.setBool('firstRun', firstRun);
  }

  getList()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.getStringList("fav");
    setState(() {
      
    });
  }

  setList()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("fav", image);
    setState(() {
      
    });
  }

  @override
  void initState() {
    getList();
    setList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    image = provider.favorite;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 1, 41),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 22, 1, 41),
        foregroundColor: Colors.white,
        elevation: 10,
        centerTitle: true,
        title: const Text(
          "My List",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Favorites",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(CupertinoIcons.heart_fill,
                    color: Colors.white,
                    size: 25,)
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: image.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1 / 1.3),
                  itemBuilder: (context, index) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "http://image.tmdb.org/t/p/w500/${image[index]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              provider.toggleFavorite(image[index]);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 25,
                            ))
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
