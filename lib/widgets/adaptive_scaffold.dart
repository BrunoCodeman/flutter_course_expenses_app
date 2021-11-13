import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveScaffold extends StatefulWidget {
  final Widget appBody;
  final PreferredSizeWidget appBar;
  final Function floatingActionButtonHandler;
  const AdaptiveScaffold(
      this.appBody, this.appBar, this.floatingActionButtonHandler);

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: widget.appBody,
            navigationBar: widget.appBar as ObstructingPreferredSizeWidget)
        : Scaffold(
            appBar: widget.appBar,
            body: widget.appBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () =>
                        widget.floatingActionButtonHandler(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}
