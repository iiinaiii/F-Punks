import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/beer_response_model.dart';

class BeerApiProvider {
  static const AUTHORITY = "api.punkapi.com";
  static const PATH = "/v2/beers";
  static const PAGE_KEY = "page";

  Client client = Client();

  Future<List<BeerResponse>> fetchBeers(int page) async {
    String url = Uri.https(AUTHORITY, PATH, {PAGE_KEY: page.toString()}).toString();
    final response = await client.get(url);
    if (response.statusCode == 200) {
      List<dynamic> iterable = json.decode(response.body);
      final beerList = iterable.map((dynamic model) => BeerResponse.fromJson(model)).toList();
      return beerList;
    } else {
      throw Exception('Failed to load beers');
    }
  }
}
