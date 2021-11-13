import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget adaptiveAppBar(
    BuildContext context, Widget appTitle, Function handler) {
  return (Platform.isIOS
      ? CupertinoNavigationBar(
          middle: appTitle,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => handler(context),
                child: Icon(
                  CupertinoIcons.add,
                ),
              )
            ],
          ),
        )
      : AppBar(
          title: appTitle,
          actions: [
            IconButton(onPressed: () => handler(context), icon: Icon(Icons.add))
          ],
        )) as PreferredSizeWidget;
}
