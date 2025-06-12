import 'package:flutter/material.dart';
import 'package:fuzz_movies/fuzz_18+1.dart';
import 'package:fuzz_movies/fuzz_music1.dart';
import 'package:fuzz_movies/fuzz_music_videos1.dart';
import 'package:fuzz_movies/fuzz_nolly1.dart';
import 'package:fuzz_movies/fuzz_others1.dart';
import 'package:fuzz_movies/home1.dart';
import 'package:fuzz_movies/widgets/carousel.dart';

import 'fuzz_bolly1.dart';
import 'fuzz_holly1.dart';
import 'fuzz_series1.dart';

class Landing1 extends StatelessWidget {
  const Landing1({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: DefaultTabController(
        length: 8,
        child: Scaffold(
            //bottomNavigationBar: BottomAppBar(color:Colors.deepPurple ,),
          appBar: AppBar(
            title:  Column(
              children: [
                Image.asset(
                  "assets/animation/fuzz2.jpg",
                  width: 250,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            centerTitle: true,
          ),
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {

                return <Widget>[
                  new SliverAppBar(
                    automaticallyImplyLeading: false,
                   toolbarHeight: h*.35,
                    actions: [
                       Expanded(
                          child:
                       Carousel())
                    ],
                    pinned: true,
                    floating: true,
                    bottom: TabBar(
                      padding: EdgeInsets.fromLTRB(120, 0, 0, 0),
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
                  FuzzHolly1(),
                  FuzzNolly1(),
                  FuzzBolly1(),
                  FuzzSeries1(),
                  FuzzMusic1(),
                  FuzzMusicVideos1(),
                  FuzzOthers1(),
                  Fuzz18plus1(),
                ],
              ),
            )),
      ),
    );
  }
}
