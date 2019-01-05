import 'package:flutter/material.dart';

import '../blocs/beers_bloc.dart';
import '../models/beer_model.dart';

class BeerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchBeers();
    return Scaffold(
      appBar: AppBar(
        title: Text('Punks'),
      ),
      body: StreamBuilder(
          stream: bloc.allBeers,
          builder: (context, AsyncSnapshot<List<Beer>> snapshot) {
            if (snapshot.hasData) {
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget buildList(AsyncSnapshot<List<Beer>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          final beer = snapshot.data[index];
          return buildRow(context, beer);
        });
  }

  Widget buildRow(BuildContext context, Beer beer) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 72,
      child: Row(
        children: [
          Image.network(beer.imageUrl, width: 40, height: 40),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  beer.name,
                  maxLines: 1,
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
                Row(
                  children: [
                    Text(beer.firstBrewed),
                    Text(beer.abv.toString()),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
