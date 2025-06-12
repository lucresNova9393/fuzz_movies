import 'package:flutter/material.dart';
import 'package:fuzz_movies/fuzz_bolly.dart';
import 'package:fuzz_movies/fuzz_holly.dart';
import 'package:fuzz_movies/fuzz_music.dart';
import 'package:fuzz_movies/fuzz_nolly.dart';
import 'package:fuzz_movies/fuzz_others.dart';
import 'package:fuzz_movies/widgets/carousel1.dart';

import 'fuzz_18+.dart';
import 'fuzz_music_videos.dart';
import 'fuzz_series.dart';
import 'main.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context)=>Landing( )));
            },
            child: Column(
              children: [
                Image.asset(
                  "assets/animation/fuzz2.jpg",
                  width: 250,
                  height: 100,
                  fit: BoxFit.contain,
                ),],
            )),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.comment),
        //     tooltip: 'Comments',
        //     onPressed: () {},
        //   ), //IconButton
        //   IconButton(
        //     icon: const Icon(Icons.search),
        //     tooltip: 'Search Movies',
        //     onPressed: () {},
        //   ), //IconButton
        // ], //<Widget>[]
        backgroundColor: Colors.transparent,
        elevation: 50.0,

        // systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: DefaultTabController(
        length: 8,
        child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {

                return <Widget>[
                  new SliverAppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: h*.25,
                    actions: [
                     Expanded(child: Carousel1())
                    ],
                    pinned: true,
                    floating: true,
                    bottom: TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(child: Text('Fuzz Holly')),
                        Tab(child: Text('Fuzz Nolly')),
                        Tab(child: Text('Fuzz Bolly')),
                        Tab(child: Text('Fuzz Series')),
                        Tab(child: Text('Fuzz Music')),
                        Tab(child: Text('Fuzz Music Videos')),
                        Tab(child: Text('Fuzz Others')),
                        Tab(child: Text('Fuzz 18+')),
                      ],
                    ),
                  )
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  FuzzHolly(),
                  FuzzNolly(),
                  FuzzBolly(),
                  FuzzSeries(),
                  FuzzMusic(),
                  FuzzMusicVideos(),
                  FuzzOthers(),
                  Fuzz18plus(),
                ],
              ),
            )),
      ),
    );
  }
}
