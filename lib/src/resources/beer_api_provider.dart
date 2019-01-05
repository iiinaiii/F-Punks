import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/beer_model.dart';

class BeerApiProvider {
  static const AUTHORITY = "api.punkapi.com";
  static const PATH = "/v2/beers";
  static const PAGE_KEY = "page";

  Client client = Client();

  Future<List<Beer>> fetchBeers(int page) async {
    print("fetchBeers : entered");
    String url =
        Uri.https(AUTHORITY, PATH, {PAGE_KEY: page.toString()}).toString();
    final response = await client.get(url);
    try {
      print(response.body.toString());
      if (response.statusCode == 200) {
        print("fetchBeers : success");
        List<dynamic> iterable = json.decode(response.body);
        final beerList = iterable.map((dynamic model)=> Beer.fromJson(model)).toList();
        return beerList;
      } else {
        print("fetchBeers : failure");
        throw Exception('Failed to load beers');
      }
    } catch (e) {
      print("fetchBeers : exception");
      print(e);
      throw Exception('Failed to load beers');
    }
  }
}
