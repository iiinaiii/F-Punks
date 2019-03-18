import 'package:f_punks/src/models/beer_model.dart';
import 'package:f_punks/src/ui/beer_detail.dart';
import 'package:flutter/material.dart';

import '../domain/beer_detail_bloc_provider.dart';
import '../domain/beers_bloc.dart';
import 'information.dart';

class BeerList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BeerListState();
  }
}

class BeerListState extends State<BeerList> {
  List<Beer> _beerList = [];
  int _pageNum = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchBeers();
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
        title: Text('F-Punks'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => _openProfilePage(),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: bloc.allBeers,
          builder: (context, AsyncSnapshot<List<Beer>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                if (_beerList.contains(snapshot.data[0])) {
                  return buildList();
                }
                _beerList.addAll(snapshot.data);
                _pageNum++;
                _isLoading = false;
                return buildList();
              } else {
                _isLoading = false;
                return buildList();
              }
            } else if (snapshot.hasError) {
              _isLoading = false;
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget buildList() {
    return Stack(
      children: <Widget>[
        NotificationListener(
          onNotification: onNotification,
          child: ListView.builder(
              itemCount: _beerList.length,
              itemBuilder: (BuildContext context, int index) {
                final beer = _beerList[index];
                return buildRow(context, beer);
              }),
        ),
        Visibility(
          visible: _isLoading,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  Widget buildRow(BuildContext context, Beer beer) {
    return InkWell(
      onTap: () => _openDetailPage(beer.id, beer.name),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 72,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Image.network(
                beer.imageUrl,
                width: 40,
                height: 40,
              ),
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
      ),
    );
  }

  _fetchBeers() {
    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
    bloc.fetchBeers(_pageNum);
  }

  bool onNotification(ScrollNotification notification) {
    if (notification.metrics.extentAfter == 0.0) {
      _fetchBeers();
    }
    return true;
  }

  _openDetailPage(int beerId, String beerName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BeerDetailBlocProvider(
            child: BeerDetail(
              beerId: beerId,
              beerName: beerName,
            ),
          );
        },
      ),
    );
  }

  _openProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Profile()),
    );
  }
}
