import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuzz_movies/searchPageBolly.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'movie_detail_page.dart';

class FuzzBolly extends StatefulWidget {
  const FuzzBolly({super.key});

  @override
  State<FuzzBolly> createState() => _FuzzHollyState();
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


class _FuzzHollyState extends State<FuzzBolly> {
  final _movieStream = Supabase.instance.client.from('fuzz_bolly').stream( ['id']).order('id', ascending: false).execute();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(

            child: Column(
              children: [
                AnimatedDefaultTextStyle(style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                    duration: Duration(milliseconds: 300),
                    curve:Curves.bounceIn,
                    child: const Text('Bollywood Movies')),
                Text('Get the best and latest movies',style: TextStyle(fontSize: 12,color: Colors.deepPurple),)
              ],
            )),
        actions: <Widget>[

          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Movies',
            onPressed: () {
    Navigator.push(context,
    MaterialPageRoute(
    builder: (context)=>SearchPageBolly()));
            },
          ), //IconButton
        ], //<Widget>[]
        backgroundColor: Colors.transparent,
        elevation: 50.0,

        // systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: KeyboardListener(
          autofocus: true,
          focusNode: _focusNode,
          onKeyEvent: _handleKeyEvent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<List<Map<String,dynamic>>>(
                stream: _movieStream,
                builder: (context, snapshot) {
                  //loading...
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  //loaded
                  final movies = snapshot.data!;
                  return DynamicHeightGridView(
                    controller: _controller,
                    itemCount: movies.length,
                    crossAxisCount: 3,
                    builder: (ctx, index) {
                      final h= MediaQuery.of(context).size.height;
                      final w= MediaQuery.of(context).size.width;
                      // get individual movie
                      Map<String,dynamic> movie = movies[index];
                      // get the column you want
                      final movieLink = movie['imagelink'];
                      final title = movie['title'];
                      final time = movie['created_at'];
                      final id = movie['id'];
                      colors.shuffle();
                      heights.shuffle();
                      return Column(
                        children: [

                          GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context)=>MovieDetailPage( item: movie,)));
                            },
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
                                          imageUrl: movieLink,
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
                                            child: Text(title,style: TextStyle(color: Colors.white,fontSize: h*.02,fontWeight: FontWeight.w900 ),textAlign: TextAlign.center,),
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
      ),
    );
  }
}
