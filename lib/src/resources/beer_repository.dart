import 'dart:async';

import '../models/beer_model.dart';
import 'beer_api_provider.dart';

class BeerRepository {
  static final BeerRepository _singleton = BeerRepository._internal();

  factory BeerRepository() {
    return _singleton;
  }

  BeerRepository._internal();

  final beerApiProvider = BeerApiProvider();

  final _beerCache = Map<int, Beer>();

  Future<List<Beer>> fetchBeers({int page = 1}) {
    try {
      return beerApiProvider.fetchBeers(page).asStream().expand((responseList) => responseList).map((response) {
        final beer = Beer.fromBeerResponse(response);
        _cacheBeer(beer);
        return beer;
      }).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Beer> getBeer(int beerId) {
    Beer beer = _beerCache[beerId];
    if (beer != null) {
      return Future.value(beer);
    } else {
      return Future.error(Exception("Beer $beerId not cached"));
    }
  }

  _cacheBeer(Beer beer) {
    _beerCache[beer.id] = beer;
  }
}
