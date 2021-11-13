import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../transaction.dart';
import 'chart.dart';

class AppBody extends StatefulWidget {
  final double appBarHeight;
  final Widget transactionsListWidget;
  final List<Transaction> recentTransactions;
  const AppBody(
      this.appBarHeight, this.transactionsListWidget, this.recentTransactions);

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  bool _showChart = false;
  @override
  Widget build(BuildContext context) {
    final mediaQueryContext = MediaQuery.of(context);
    final _isLandscapeMode =
        mediaQueryContext.orientation == Orientation.landscape;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLandscapeMode)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Show Chart",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _showChart,
                    onChanged: (v) => setState(() => _showChart = v),
                  ),
                ],
              ),
            if (!_isLandscapeMode)
              Container(
                  height: (mediaQueryContext.size.height -
                          mediaQueryContext.padding.top -
                          this.widget.appBarHeight) *
                      0.3,
                  child: Chart(this.widget.recentTransactions)),
            if (!_isLandscapeMode) this.widget.transactionsListWidget,
            if (_isLandscapeMode)
              _showChart
                  ? Container(
                      height: (mediaQueryContext.size.height -
                              mediaQueryContext.padding.top -
                              this.widget.appBarHeight) *
                          0.7,
                      child: Chart(this.widget.recentTransactions))
                  : this.widget.transactionsListWidget
          ],
        ),
      ),
    );
  }
}
