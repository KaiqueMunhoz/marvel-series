import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_series/injection_container.dart';
import 'package:marvel_series/src/blocs/series/series_bloc.dart';
import 'package:marvel_series/src/views/base/base.page.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: BlocProvider(
        builder: (_) => sl<SeriesBloc>(),
        child: BlocBuilder<SeriesBloc, SeriesState>(
          builder: (blocContext, state) {
            if (state is SeriesInitial) {
              return _initialState(context: blocContext, state: state);
            } else if (state is SeriesLoading) {
              return _loadingState(context: blocContext, state: state);
            } else if (state is SeriesLoaded) {
              return _loadedState(context: blocContext, state: state);
            } else {
              return _initialState(context: blocContext, state: state);
            }
          },
        ),
      ),
    );
  }

  Widget _initialState({
    @required BuildContext context,
    @required SeriesInitial state,
  }) {
    return Center(
      child: FloatingActionButton(
        onPressed: () => _callBloc(context),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _loadingState({
    @required BuildContext context,
    @required SeriesLoading state,
  }) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _loadedState({
    @required BuildContext context,
    @required SeriesLoaded state,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: state.series
            .map(
              (serie) => Text(serie.title),
            )
            .toList(),
      ),
    );
  }

  void _callBloc(BuildContext context) {
    BlocProvider.of<SeriesBloc>(context).add(GetSeriesList());
  }
}
