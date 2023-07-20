// import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movie_app/data/movie_class.dart';
import 'package:movie_app/data/overall_response.dart';
import 'cast.dart';
import 'details_overall.dart';


Future<List<Result>> movieApiCall(String movieType) async {
  String apiUrl =
      "https://api.themoviedb.org/3/movie/$movieType?api_key=b950e622119a1e8e266eefe2dfef1b77&language=en-US&page=1";
  final url = Uri.parse(apiUrl);
  var response = await http.get(url);
  // print(response.statusCode);
  // print(response.body);
  if (response.statusCode == 200) {
    var jsonRes = OverallResponse.fromRawJson(response.body);
    return jsonRes.results;
  } else {
    throw ("Something went wrong ${response.statusCode}");
  }
}

Future<List<Result>> recommendMovieApiCall(int id) async {
  String apiUrl =
      "https://api.themoviedb.org/3/movie/$id/recommendations?&api_key=b950e622119a1e8e266eefe2dfef1b77&language=en-US&page=1";
  final url = Uri.parse(apiUrl);
  var response = await http.get(url);
  // print(response.statusCode);
  // print(response.body);
  if (response.statusCode == 200) {
    var jsonRes = OverallResponse.fromRawJson(response.body);
    return jsonRes.results;
  } else {
    throw ("Something went wrong ${response.statusCode}");
  }
}

Future<Details> detailsApiCall(int id) async {
  String apiUrl =
      "https://api.themoviedb.org/3/movie/$id?api_key=b950e622119a1e8e266eefe2dfef1b77&language=en-US&page=1";
  final url = Uri.parse(apiUrl);
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonRes = detailsFromJson(response.body);
    return jsonRes;
  } else {
    throw ("Something went wrong ${response.statusCode}");
  }
}

Future<List<Cast>> castApiCall(int id) async {
  String apiUrl =
      "https://api.themoviedb.org/3/movie/$id/credits?language=en-US&api_key=b950e622119a1e8e266eefe2dfef1b77&language=en-US&page=1";
  final url = Uri.parse(apiUrl);
  var response = await http.get(url);
  // print(response.statusCode);
  // print(response.body);
  if (response.statusCode == 200) {
    var jsonRes = creditsFromJson(response.body);
    return jsonRes.cast;
  } else {
    throw ("Something went wrong ${response.statusCode}");
  }
}

Future<List<Result>> similarMovieApiCall(int id) async {
  String apiUrl =
      "https://api.themoviedb.org/3/movie/$id/similar?&api_key=b950e622119a1e8e266eefe2dfef1b77&language=en-US&page=1";
  final url = Uri.parse(apiUrl);
  var response = await http.get(url);
  // print(response.statusCode);
  // print(response.body);
  if (response.statusCode == 200) {
    var jsonRes = OverallResponse.fromRawJson(response.body);
    return jsonRes.results;
  } else {
    throw ("Something went wrong ${response.statusCode}");
  }
}


Future<List<Result>> searchApiCall(String movieName) async {
  String apiUrl =
      "https://api.themoviedb.org/3/search/movie?query=%7B$movieName%7D&api_key=b950e622119a1e8e266eefe2dfef1b77&language=en-US&page=1";
  final url = Uri.parse(apiUrl);
  var response = await http.get(url);
  // print(response.statusCode);
  // print(response.body);
  if (response.statusCode == 200) {
    var jsonRes = OverallResponse.fromRawJson(response.body);
    return jsonRes.results;
  } else {
    throw ("Something went wrong ${response.statusCode}");
  }
}