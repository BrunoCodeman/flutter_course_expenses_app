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

  List<Widget> _buildLandscape() {
    ThemeData theme = Theme.of(context);
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Show Chart",
            style: theme.textTheme.headline6,
          ),
          Switch.adaptive(
            activeColor: theme.colorScheme.secondary,
            value: _showChart,
            onChanged: (v) => setState(() => _showChart = v),
          ),
        ],
      ),
      this.widget.transactionsListWidget
    ];
  }

  List<Widget> _buildPortrait(
      MediaQueryData mediaQueryContext, double appBarHeight) {
    return [
      Container(
        height: (mediaQueryContext.size.height -
                mediaQueryContext.padding.top -
                appBarHeight) *
            0.3,
        child: Chart(
          this.widget.recentTransactions,
        ),
      ),
      _showChart
          ? Container(
              height: (mediaQueryContext.size.height -
                      mediaQueryContext.padding.top -
                      this.widget.appBarHeight) *
                  0.7,
              child: Chart(this.widget.recentTransactions))
          : this.widget.transactionsListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryContext = MediaQuery.of(context);
    final _isLandscapeMode =
        mediaQueryContext.orientation == Orientation.landscape;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: _isLandscapeMode
              ? _buildLandscape()
              : _buildPortrait(mediaQueryContext, widget.appBarHeight),
        ),
      ),
    );
  }
}
