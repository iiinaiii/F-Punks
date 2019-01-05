import 'package:f_punks/src/models/beer_model.dart';
import 'package:flutter/material.dart';

import '../blocs/beers_bloc.dart';

class BeerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchBeers();
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('F-Punks', style: TextStyle(color: Colors.white)),
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
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.network(beer.imageUrl, width: 40, height: 40),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  beer.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
                Row(
                  children: [
                    Text(beer.firstBrewed),
                    Padding(padding: const EdgeInsets.only(left: 16)),
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
