import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/adaptive_scaffold.dart';
import 'package:flutter_complete_guide/widgets/app_body.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';
import './transaction.dart';

void main() {
  //to define orientation:
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.light(),
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: "QuickSand",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: ThemeData.light().backgroundColor,
          //toolbarTextStyle: ,
          // textTheme: ThemeData.light().textTheme.copyWith(
          //       headline6: TextStyle(
          //         fontFamily: "OpenSans",
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold,
          //       ),
          //       button: TextStyle(color: Colors.white),
          //     ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  List<Transaction> _recentTransactions() => _transactions
      .where(
        (tx) => tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        ),
      )
      .toList();

  void _deleteTransaction(String id) =>
      setState(() => _transactions.removeWhere((t) => t.id == id));

  void _addNewTransaction(String title, double amount, DateTime date) {
    final t = Transaction(
        id: date.toString(), title: title, amount: amount, date: date);
    setState(() {
      _transactions.add(t);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => GestureDetector(
            //behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: NewTransaction(newTransaction: _addNewTransaction)));
  }

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
              IconButton(
                  onPressed: () => handler(context), icon: Icon(Icons.add))
            ],
          )) as PreferredSizeWidget;
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = Text(
      'Expenses app',
      style: TextStyle(fontFamily: "OpenSans"),
    );
    final mediaQueryContext = MediaQuery.of(context);
    final appBar = adaptiveAppBar(
      context,
      appTitle,
      _startAddNewTransaction,
    );
    final transactionsListWidget = Container(
      height: (mediaQueryContext.size.height -
              mediaQueryContext.padding.top -
              appBar.preferredSize.height) *
          0.75,
      child: TransactionList(
        transactions: _transactions,
        deleteTransaction: _deleteTransaction,
      ),
    );

    final appBody = AppBody(appBar.preferredSize.height, transactionsListWidget,
        _recentTransactions());

    return AdaptiveScaffold(appBody, appBar, _startAddNewTransaction);
  }
}
