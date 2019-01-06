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
        body: SafeArea(
      top: false,
      bottom: false,
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
    ));
  }

  Widget buildBeerDetailLayout(Beer beer) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Flexible(child: Image.network(beer.imageUrl, width: 200)),
          Column(
            children: [
              Text(beer.firstBrewed),
              Row(
                children: [
                  Text("ABV"),
                  Text("IBU"),
                  Text("OG"),
                ],
              ),
              Row(
                children: [
                  Text(beer.abv),
                  Text(beer.ibu),
                  Text(beer.targetOg),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
