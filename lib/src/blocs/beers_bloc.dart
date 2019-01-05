import 'package:rxdart/rxdart.dart';

import '../models/beer_model.dart';
import '../resources/beer_repository.dart';

class BeersBloc {
  final _repository = BeerRepository();
  final _beersFetcher = PublishSubject<List<Beer>>();

  Observable<List<Beer>> get allBeers => _beersFetcher.stream;

  fetchBeers() async {
    List<Beer> beers = await _repository.fetchBeers();
    _beersFetcher.sink.add(beers);
  }

  dispose() {
    _beersFetcher.close();
  }
}

final bloc = BeersBloc();
