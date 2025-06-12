import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class MovieDetailPage extends StatefulWidget {
  final Map<String,dynamic>item;

  MovieDetailPage({super.key,required this.item});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  String Title =item['title'];
  String Download =item['downloads'];

  static var item;
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Expanded(
                child: Container(
                    color: Colors.black,
                    padding: EdgeInsets.all(20),
                    child: Text(Title,style: TextStyle(fontSize: 32,color: Colors.white),))),
          ),
          Card(
            elevation: 100,
            child: CachedNetworkImage(
              width: w,
              height: h,
              fit: BoxFit.fitHeight,
              imageUrl: item['imagelink'],
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
          Container(
            width: w*.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Expanded(child: Center(child: Text(item['description']))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: (){
                launchUrl(
                    mode: LaunchMode.inAppBrowserView,Uri.parse('https://loadedfiles.org/0749329a336e6563'));
              },
              label: Text("Fast Download"),
              icon: Icon(Icons.download),
            ),
          ),
          Card(
            elevation: 100,
            child: CachedNetworkImage(
              width: w,
              height: h*.5,
              fit: BoxFit.contain,
              imageUrl: "https://image.tmdb.org/t/p/w1280/ec50pMNyIshL0blt1q8dUEbIa2G.jpg",
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
        ],
      ),
    ),);
  }
}
