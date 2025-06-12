import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../movie_detail_page.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int activeIndex = 0;
  final _Stream = Supabase.instance.client.from('movie').stream( ['id']).order('id', ascending: false).execute();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<List<Map<String,dynamic>>>(
        stream: _Stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LinearProgressIndicator(),);
          }
          else if (!snapshot.hasData) {
            return Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/animation/fuzz3.png",
                        width: 250,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      Text("Oops", style: TextStyle(fontSize: 30),),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                  child: Text(
                                    'Unable to connect,Please review your network settings.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10, fontWeight: FontWeight.w300,
                                    ),),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CarouselSlider.builder(
              options:  CarouselOptions(
                aspectRatio: 3.0,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                enableInfiniteScroll: false,
                initialPage: 2,
                autoPlay: true,
                pauseAutoPlayOnTouch: true
              ),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index, int realIndex)
              {
                final h= MediaQuery.of(context).size.height;
                final w= MediaQuery.of(context).size.width;
                final movies = snapshot.data!;
                // get individual movie
                Map<String,dynamic> movie = movies[index];
                // get the column you want
                final movieLink = movie['imagelink'];
                final title = movie['title'];
                final time = movie['created_at'];
                final id = movie['id'];
                return
                  GestureDetector(
                    onTap:  (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context)=>MovieDetailPage( item: movie,)));
                    },
                    child: Container(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            child: Stack(
                              children: <Widget>[
                                // Image.network(item, fit: BoxFit.fill, width: 1000.0),
                                Expanded(
                                  child: CachedNetworkImage(fit: BoxFit.fill, width: w,
                                    imageUrl: movieLink, placeholder: (context, url) => new LinearProgressIndicator(),
                                    errorWidget: (context, url, error) => new LinearProgressIndicator(),
                                    //new Icon(Icons.error),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(200, 0, 0, 0),
                                          Color.fromARGB(0, 0, 0, 0)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    child: Expanded(
                                      child: Text(
                                        movie['title'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  );
              },),
          );
        }),
    );
  }
}

