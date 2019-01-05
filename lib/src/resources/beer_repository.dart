import 'dart:async';

import '../models/beer_model.dart';
import 'beer_api_provider.dart';

class BeerRepository {
  final beerApiProvider = BeerApiProvider();

  Future<List<Beer>> fetchBeers({int page = 1}) =>
      beerApiProvider.fetchBeers(page);
}
