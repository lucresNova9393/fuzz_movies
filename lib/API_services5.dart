import 'dart:convert';

import 'package:fuzz_movies/MovieModel.dart';
import 'package:http/http.dart' as http;

class FetchMoviesMusicVideos{
  var data = [];
  List <MovieList> results = [];
  String fetchurl = "https://kgnfvhboadobgjrsajiw.supabase.co/rest/v1/fuzz_music_videos?apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtnbmZ2aGJvYWRvYmdqcnNhaml3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE2NDQwMDMsImV4cCI6MjA1NzIyMDAwM30.GwHrs7TiaU-RLw0we8GVzQBYdOMdVd0sfwji3r-MZIM";
  Future<List<MovieList>>  getMovieList({String? query})async{
    var url = Uri.parse(fetchurl);
    var response = await http.get(url);
    try{
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        results = data.map((e) => MovieList.fromJson(e)).toList();
        if(query != null){
          results = results.where((element)=> element.title!.toLowerCase().contains(query.toLowerCase())).toList();
        }
      } else {
        print('api error');
      }
    }
    on Exception catch(e){
      print('error $e');
    }
    return results;
  }
}