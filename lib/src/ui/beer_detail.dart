import 'dart:async';

import 'package:flutter/material.dart';

import '../blocs/beer_detail_bloc.dart';
import '../blocs/beer_detail_bloc_provider.dart';
import '../models/beer_model.dart';

class BeerDetail extends StatefulWidget {
  final int beerId;

  BeerDetail({@required this.beerId});

  @override
  State<StatefulWidget> createState() {
    return BeerDetailState(beerId: beerId);
  }
}

class BeerDetailState extends State<BeerDetail> {
  final int beerId;

  BeerDetailBloc bloc;

  BeerDetailState({@required this.beerId});

  @override
  void didChangeDependencies() {
    bloc = BeerDetailBlocProvider.of(context);
    bloc.fetchBeerById(beerId);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('F-Punks', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: bloc.beerDetail,
              builder: (context, AsyncSnapshot<Future<Beer>> futureSnapshot) {
                if (futureSnapshot.hasData) {
                  return FutureBuilder(
                    future: futureSnapshot.data,
                    builder: (context, AsyncSnapshot<Beer> snapshot) {
                      if (snapshot.hasData) {
                        return buildBeerDetailLayout(snapshot.data);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }

  Widget buildBeerDetailLayout(Beer beer) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Image.network(
                beer.imageUrl,
                width: 200,
                height: 280,
              ),
              Flexible(
                child: Container(
                  height: 280,
                  padding: EdgeInsets.only(right: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          beer.firstBrewed,
                          style: Theme.of(context).primaryTextTheme.subhead,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "ABV",
                                  style: Theme.of(context).primaryTextTheme.headline,
                                ),
                                Text(
                                  beer.abv,
                                  maxLines: 1,
                                  style: Theme.of(context).primaryTextTheme.title,
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "IBU",
                                  style: Theme.of(context).primaryTextTheme.headline,
                                ),
                                Text(
                                  beer.ibu,
                                  maxLines: 1,
                                  style: Theme.of(context).primaryTextTheme.title,
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "OG",
                                  style: Theme.of(context).primaryTextTheme.headline,
                                ),
                                Text(
                                  beer.targetOg,
                                  maxLines: 1,
                                  style: Theme.of(context).primaryTextTheme.title,
                                  softWrap: false,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  beer.name,
                  style: Theme.of(context).primaryTextTheme.display2.apply(
                        color: Colors.black,
                      ),
                ),
                Text(
                  beer.tagLine,
                  style: Theme.of(context).primaryTextTheme.display1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
