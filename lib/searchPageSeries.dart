import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuzz_movies/API_services1.dart';
import 'package:fuzz_movies/API_services2.dart';
import 'package:fuzz_movies/API_services3.dart';
import 'package:fuzz_movies/MovieModel.dart';
import 'package:fuzz_movies/movie_detail_page2.dart';
import 'package:fuzz_movies/search_bolly.dart';
import 'package:fuzz_movies/search_holly.dart';
import 'package:fuzz_movies/search_holly1.dart';
import 'package:fuzz_movies/search_nolly.dart';

import 'movie_detail_page.dart';
import 'search_series.dart';

class SearchPageSeries extends StatefulWidget {
  const SearchPageSeries({super.key});

  @override
  State<SearchPageSeries> createState() => _SearchPageSeriesState();
}

final colors = [
  Colors.red,
  Colors.redAccent,
  Colors.deepOrange,
  Colors.orange,
  Colors.amberAccent,
  Colors.yellow,
  Colors.lightGreenAccent,
  Colors.lightGreen,
  Colors.green,
  Colors.greenAccent,
  Colors.lightBlueAccent,
  Colors.blue,
  Colors.black
];

final backgroundColor = [
  Colors.white,
  Colors.red,
  Colors.redAccent,
  Colors.deepOrange,
  Colors.orange,
  Colors.amberAccent,
  Colors.yellow,
  Colors.lightGreenAccent,
  Colors.lightGreen,
  Colors.green,
  Colors.greenAccent,
  Colors.lightBlueAccent,
  Colors.blue,
];

final heights = [
  250,
  250,
  250,
  250,
  250,
  250,
];

class _SearchPageSeriesState extends State<SearchPageSeries> {
  final ScrollController _controller = ScrollController();
  final FocusNode _focusNode = FocusNode();
  void _handleKeyEvent(KeyEvent event) {
    var offset = _controller.offset;
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset - 200, duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _controller.animateTo(offset - 200, duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        if (kReleaseMode) {
          _controller.animateTo(offset + 200, duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          _controller.animateTo(offset + 200, duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    }
  }
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
  FetchMoviesSeries _movieList = FetchMoviesSeries();
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Search for Series'),
            centerTitle: true,
            actions: [
              IconButton(onPressed: (){
                showSearch(context: context, delegate: SearchSeries());
              },
                  icon: Icon(Icons.search))
            ],
          ),
          body: KeyboardListener(
            autofocus: true,
            focusNode: _focusNode,
            onKeyEvent: _handleKeyEvent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<MovieList>>(
                  future: _movieList.getMovieList(),
                  builder: (context, snapshot) {
                    var data = snapshot.data;
                    if(!snapshot.hasData){
                      return Center(child: LinearProgressIndicator());
                    }
                    return DynamicHeightGridView(
                      controller: _controller,
                      itemCount: data!.length,
                      crossAxisCount: 3,
                      builder: (ctx, index) {
                        MovieList? movieList = data[index];
                        final h= MediaQuery.of(context).size.height;
                        final w= MediaQuery.of(context).size.width;
                        colors.shuffle();
                        heights.shuffle();
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: (()=>{openPage(context,movieList)}),
                              child: Container(
                                height: h*.40,
                                color: colors.first,
                                child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        child: Card(
                                          elevation: 100,
                                          child: CachedNetworkImage(
                                            width: w*.55,
                                            height: h*.25,
                                            fit: BoxFit.fill,
                                            imageUrl: '${data?[index].imagelink}',
                                            placeholder: (context, url) => new CircularProgressIndicator(),
                                            errorWidget: (context, url, error) => new Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(color: Colors.white,),
                                    Expanded(child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Text('${data?[index].title}',style: TextStyle(color: Colors.white,fontSize: h*.02,fontWeight: FontWeight.w900 ),textAlign: TextAlign.center,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
              ),
            ),
          ),
        )
    );
  }

  openPage(context,MovieList movieList){
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=> MovieDetailPage2(movieList: movieList, ))
    );
  }
}
