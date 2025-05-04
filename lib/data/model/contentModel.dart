class ContentModel {
  final int id;
  final String title;
  final String original_title;
  final String overview;
  final String poster_path;
  final String media_type;
  final bool adult;
  final String original_language;
  final String release_date;
  final bool video;
  final int vote_count;

  ContentModel({
    required this.id,
    required this.title,
    required this.original_title,
    required this.overview,
    required this.poster_path,
    required this.media_type,
    required this.adult,
    required this.original_language,
    required this.release_date,
    required this.video,
    required this.vote_count,
  });

  factory ContentModel.fromJson(Map<String, dynamic> jsonData){
    return ContentModel(
        id: jsonData["id"] ?? 0,
        title: jsonData["title"] ?? '',
        original_title: jsonData["original_title"] ?? '',
        overview: jsonData["overview"] ?? '',
        poster_path: jsonData["poster_path"] ?? '',
        media_type: jsonData["media_type"] ?? '',
        adult: jsonData["adult"] ?? false,
        original_language: jsonData["original_language"] ?? '',
        release_date: jsonData["release_date"] ?? '',
        video: jsonData["video"] ?? false,
        vote_count: jsonData["vote_count"] ?? 0
    );
  }
}

// "backdrop_path":"/b6e5Nss2QNoQM4wJv2VppChswNP.jpg",
// "id":974573,
// "title":"Another Simple Favor",
// "original_title":"Another Simple Favor",
// "overview":"Stephanie and Emily reunite on the beautiful island of Capri, Italy for Emily's extravagant wedding to a rich Italian businessman. Along with the glamorous guests, expect murder and betrayal to RSVP for a wedding with more twists and turns than the road from the Marina Grande to the Capri town square.",
// "poster_path":"/zboCGZ4aIqPMd7VFI4HWnmc7KYJ.jpg",
// "media_type":"movie",
// "adult":false,
// "original_language":"en",
// "genre_ids":[
// 53,
// 35,
// 80
// ],
// "popularity":136.6511,
// "release_date":"2025-03-07",
// "video":false,
// "vote_average":6.727,
// "vote_count":77
