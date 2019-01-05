import 'dart:async';

import '../models/beer_model.dart';
import '../models/beer_response_model.dart';
import 'beer_api_provider.dart';

class BeerRepository {
  final beerApiProvider = BeerApiProvider();

  Future<List<Beer>> fetchBeers({int page = 1}) {
    try {
      return beerApiProvider
          .fetchBeers(page)
          .asStream()
          .map((List<BeerResponse> responseList) => responseList.map((BeerResponse response) => Beer.fromBeerResponse(response)).toList())
          .single;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
