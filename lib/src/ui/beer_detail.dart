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
            children: <Widget>[
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
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          beer.firstBrewed,
                          style: Theme.of(context).primaryTextTheme.subhead,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
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
                buildDetailList(beer),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailList(Beer beer) {
    final foodWidgets = List<Widget>();
    beer.foodPairing.forEach((food) => foodWidgets.add(buildSimpleText(food)));
    final foodColumn = Column(children: foodWidgets);

    return Column(
      children: <Widget>[
        // Description
        buildHeader("THIS BEER IS"),
        buildSimpleText(beer.description),

        // Basics
        buildHeader("BASICS"),
        buildValue("VOLUME", beer.volume),
        buildValue("BOIL VOLUME", beer.boilVolume),
        buildValue("ABV", beer.abv),
        buildValue("Target FG", beer.targetFg),
        buildValue("Target OG", beer.targetOg),
        buildValue("EBC", beer.ebc),
        buildValue("SRM", beer.srm),
        buildValue("PH", beer.ph),
        buildValue("ATTENUATION LEVEL", beer.attenuationLevel),

        // Food pairing
        buildHeader("FOOD PAIRING"),
        foodColumn,

        // Brewer's tips
        buildHeader("BREWER\'S TIPS"),
        buildSimpleText(beer.brewersTips),
      ],
    );
  }

  Widget buildHeader(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).primaryTextTheme.headline,
      ),
    );
  }

  Widget buildSimpleText(String message) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        message,
        style: Theme.of(context).primaryTextTheme.body1,
      ),
    );
  }

  Widget buildValue(String title, String message) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: Theme.of(context).primaryTextTheme.subhead,
            ),
          ),
          Flexible(
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                message,
                style: Theme.of(context).primaryTextTheme.body1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
