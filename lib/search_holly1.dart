import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuzz_movies/API_services.dart';
import 'package:fuzz_movies/MovieModel.dart';
import 'package:fuzz_movies/search_holly.dart';

import 'movie_detail_page2.dart';


class SearchHolly1 extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(onPressed: (){
        query = "";
      }, icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: Icon(Icons.arrow_back_ios));
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
  FetchMovies _movieList = FetchMovies();
  final ScrollController _controller = ScrollController();
  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<MovieList>>(
          future: _movieList.getMovieList(query: query ),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if(!snapshot.hasData){
              return Center(child: LinearProgressIndicator());
            }
            return DynamicHeightGridView(
              controller: _controller,
              itemCount: data!.length,
              crossAxisCount: 5,
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   return Center( child: Text('Search for hollywood movies'),);
  }
  openPage(context,MovieList movieList){
    Navigator.push(context,
        MaterialPageRoute(builder: (context)=> MovieDetailPage2(movieList: movieList, ))
    );
  }
}