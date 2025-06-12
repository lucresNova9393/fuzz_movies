import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fuzz_movies/splash.dart';
import 'package:fuzz_movies/widgets/carousel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:fuzz_movies/movie_detail_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

//https://kgnfvhboadobgjrsajiw.supabase.co/rest/v1/fuzz_holly?apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtnbmZ2aGJvYWRvYmdqcnNhaml3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE2NDQwMDMsImV4cCI6MjA1NzIyMDAwM30.GwHrs7TiaU-RLw0we8GVzQBYdOMdVd0sfwji3r-MZIM

void main() async{
  usePathUrlStrategy();
  runApp( MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://kgnfvhboadobgjrsajiw.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtnbmZ2aGJvYWRvYmdqcnNhaml3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE2NDQwMDMsImV4cCI6MjA1NzIyMDAwM30.GwHrs7TiaU-RLw0we8GVzQBYdOMdVd0sfwji3r-MZIM",
  );

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

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          /*Add this*/
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      title: 'Fuzz Movies, Music & Entertainment Arena.',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home:  Splash(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _movieStream = Supabase.instance.client.from('movie').stream( ['id']).order('id', ascending: false).execute();
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
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(

            child: Column(
              children: [
                AnimatedDefaultTextStyle(style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    duration: Duration(milliseconds: 300),
                    curve:Curves.bounceIn,
                    child: const Text('Fuzz Movies')),
                Text('Pure Entertainment and More',style: TextStyle(fontSize: 12,color: Colors.deepPurple),)
              ],
            )),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Movies',
            onPressed: () {},
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


class AppScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices {
    final devices = Set<PointerDeviceKind>.from(super.dragDevices);
    devices.add(PointerDeviceKind.mouse);
    return devices;

  }
}
final List<String> imgList = [
  'https://cdn.shopify.com/s/files/1/0057/3728/3618/files/MX5380-Tate-Mcrae-So-Close-to-What-24x36_500x749.jpg?v=1743699921',
  'https://creativereview.imgix.net/content/uploads/2024/12/AlienRomulus-scaled.jpg?auto=compress,format&q=60&w=1382&h=2048',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];
final List<Widget> imageSliders = imgList
    .map((items) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
           // Image.network(item, fit: BoxFit.fill, width: 1000.0),
            CachedNetworkImage(fit: BoxFit.fill, width: 1000.0,
              imageUrl: items, placeholder: (context, url) => new LinearProgressIndicator(),
              errorWidget: (context, url, error) => new LinearProgressIndicator(),
              //new Icon(Icons.error),
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
                child: Text(
                  'No. ${imgList.indexOf(items)} image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )),
  ),
))
    .toList();
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(

            child: Column(
              children: [
                AnimatedDefaultTextStyle(style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                duration: Duration(milliseconds: 300),
                curve:Curves.bounceIn,
                child: const Text('Fuzz Movies')),
                Text('Pure Entertainment and More',style: TextStyle(fontSize: 12,color: Colors.deepPurple),)
              ],
            )),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.comment),
            tooltip: 'Comments',
            onPressed: () {},
          ), //IconButton
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Movies',
            onPressed: () {},
          ), //IconButton
        ], //<Widget>[]
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
                toolbarHeight: h*.35,
                actions: [
                // Expanded(
                // child:Container(
                //     child: CarouselSlider(
                //       options: CarouselOptions(
                //         aspectRatio: 2.0,
                //         enlargeCenterPage: true,
                //         enableInfiniteScroll: false,
                //         initialPage: 2,
                //         autoPlay: true,
                //       ),
                //       items: imageSliders,
                //     )),
                // ),
                  Carousel(),
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
                  HomePage(),
                  HomePage(),
                  HomePage(),
                  HomePage(),
                  HomePage(),
                  HomePage(),
                  HomePage(),
                  HomePage(),
                ],
              ),
            )),
      ),
    );
  }
}
