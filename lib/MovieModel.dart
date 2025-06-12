class MovieList {
  int? id;
  String? createdAt;
  String? imagelink;
  String? title;
  String? downloadurl;
  String? detailPageImage;
  String? screenshotImage;
  String? description;
  String? downloads;
  String? fts;

  MovieList(
      {this.id,
        this.createdAt,
        this.imagelink,
        this.title,
        this.downloadurl,
        this.detailPageImage,
        this.screenshotImage,
        this.description,
        this.downloads,
        this.fts});

  MovieList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    imagelink = json['imagelink'];
    title = json['title'];
    downloadurl = json['downloadurl'];
    detailPageImage = json['detailPageImage'];
    screenshotImage = json['screenshotImage'];
    description = json['description'];
    downloads = json['downloads'];
    fts = json['fts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['imagelink'] = this.imagelink;
    data['title'] = this.title;
    data['downloadurl'] = this.downloadurl;
    data['detailPageImage'] = this.detailPageImage;
    data['screenshotImage'] = this.screenshotImage;
    data['description'] = this.description;
    data['downloads'] = this.downloads;
    data['fts'] = this.fts;
    return data;
  }
}
