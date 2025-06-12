import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuzz_movies/movie_detail_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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


class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  List _allResults = [];
  List _resultList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    getClientStream();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }
  _onSearchChanged(){
  print(_searchController.text);
  searchResultList();
  }

  searchResultList(){
      var showResults = [];
      if(_searchController.text != "")
        {
          for(var clientSnapShot in _allResults)
          {
            var name = clientSnapShot['title'].toString().toLowerCase();
            if(name.contains(_searchController.text.toLowerCase()))
              {
                showResults.add(clientSnapShot);
              }
          }
        }
      else{
        showResults = List.from(_allResults);
      }
      setState(() {
        _resultList = showResults;
      });
  }

  getClientStream() async{
    var data =  await Supabase.instance.client
        .from('fuzz_holly')
        .select()
        .textSearch('title', _searchController.text)
        .limit(100).execute();
    setState(() {
      _allResults = data as List;
    });
    searchResultList();
  }
  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: CupertinoTextField(
          controller: _searchController,
        ),
      ),
      body:  DynamicHeightGridView
        ( builder: (context,index){
            final h= MediaQuery.of(context).size.height;
            final w= MediaQuery.of(context).size.width;
            Map<String,dynamic> movie = _resultList[index];
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
                                imageUrl: _resultList[index]['imagelink'],
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
                                  child: Text(_resultList[index]['title'],style: TextStyle(color: Colors.white,fontSize: h*.02,fontWeight: FontWeight.w900 ),textAlign: TextAlign.center,),
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
          itemCount: _resultList.length,
          crossAxisCount: 5,
      ),
    );
  }
}
