import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fuzz_movies/responsive.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';



class MovieDetailPage extends StatelessWidget {
  final Map<String,dynamic>item;
  const MovieDetailPage({super.key,required this.item});


  @override
  Widget build(BuildContext context) {

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    String Title =item['title'];
    String Download =item['downloads'];
    String download =item['downloads'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: GestureDetector(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context)=>Responsive()));
          },
          child: Column(
            children: [
              Image.asset(
                "assets/animation/fuzz2.jpg",
                width: 250,
                height: 100,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Expanded(
                  child: Container(
                      color: Colors.black,
                      padding: EdgeInsets.all(20),
                      child: Text(Title,textAlign: TextAlign.center,style: TextStyle(fontSize: 32,color: Colors.white),))),
            ),
            Card(
              elevation: 5,
              child: CachedNetworkImage(
                width: w,
                //height: h,
                fit: BoxFit.contain,
                imageUrl: item['detailPageImage'],
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
                      mode: LaunchMode.inAppBrowserView,Uri.parse('https://www.profitableratecpm.com/bjft6dq2?key=ec223313c42a170ecace161d5d44c8e6'));
                },
                label: Text("Fast Download"),
                icon: Icon(Icons.download),
              ),
            ),
            Text('Follow the link below'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: (){
                  launchUrl(
                      mode: LaunchMode.inAppBrowserView,Uri.parse(Download));
                },
                label: Text(" Download"),
                icon: Icon(Icons.download),
              ),
            ),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  width: w,
                  height: h*.5,
                  fit: BoxFit.contain,
                  imageUrl: item['imagelink'],
                  placeholder: (context, url) => new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}