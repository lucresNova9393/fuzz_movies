import 'dart:convert';

class MovieModel {
  final String id;
  final String imagelink;
  final String title;
  final String downloadurl;
  final String detailPageImage;
  final String description;
  final String fts;


  MovieModel({
    required this.id,
    required this.imagelink,
    required this.title,
    required this.downloadurl,
    required this.detailPageImage,
    required this.description,
    required this.fts,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        id: json['id'],
        imagelink: json['imagelink'],
        title: json['title'],
        downloadurl: json['downloadurl'],
        detailPageImage: json['detailPageImage'],
        description: json['description'],
        fts: json['fts']
    );
  }
  Map <String,dynamic> toJson()=>{
    "id": id,
    "imagelink": imagelink,
    "title": title,
    "downloadurl": downloadurl,
    "detailPageImage": detailPageImage,
    "description": description,
    "fts": fts
  };
}
