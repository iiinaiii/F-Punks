import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../models/beer_model.dart';
import '../data/beer_repository.dart';

class BeerDetailBloc {
  final _repository = BeerRepository();
  final _beerId = PublishSubject<int>();
  final _beer = BehaviorSubject<Future<Beer>>();

  Function(int) get fetchBeerById => _beerId.sink.add;

  Observable<Future<Beer>> get beerDetail => _beer.stream;

  BeerDetailBloc() {
    _beerId.stream.transform(_idToBeerTransformer()).pipe(_beer);
  }

  dispose() async {
    _beerId.close();
    await _beer.drain();
    _beer.close();
  }

  _idToBeerTransformer() {
    return ScanStreamTransformer((Future<Beer> beerDetail, int beerId, int index) {
      beerDetail = _repository.getBeer(beerId);
      return beerDetail;
    });
  }
}
