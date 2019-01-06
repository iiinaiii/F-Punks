import 'package:flutter/material.dart';

import 'beer_detail_bloc.dart';

class BeerDetailBlocProvider extends InheritedWidget {
  final BeerDetailBloc bloc;

  BeerDetailBlocProvider({Key key, Widget child})
      : bloc = BeerDetailBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static BeerDetailBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BeerDetailBlocProvider) as BeerDetailBlocProvider).bloc;
  }
}
