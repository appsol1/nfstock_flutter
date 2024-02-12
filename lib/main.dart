import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nfstock_test/common/constants.dart';
import 'package:nfstock_test/common/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Constants.primaryColor),
        appBarTheme: const AppBarTheme(color: Constants.primaryColor, foregroundColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MarketsScreen(),
    );
  }
}

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {
  String selectedButton = "all";

  Color getButtonColor(String type) => selectedButton == type ? Constants.primaryColor : Colors.white54;

  @override
  Widget build(BuildContext context) {
    final allBtnColor = getButtonColor('all');
    final favBtnColor = getButtonColor('fav');

    return Scaffold(
      backgroundColor: Constants.primaryColor,
      appBar: AppBar(centerTitle: true, title: const Text(Strings.markets)),
      body: Column(children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: const CupertinoSearchTextField(
              placeholder: Strings.searchBarHintText,
              placeholderStyle: TextStyle(fontSize: 14, color: CupertinoColors.inactiveGray),
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            )),
        SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CupertinoSegmentedControl(
                children: {
                  "all": Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      child: Row(children: [
                        Icon(Icons.trending_up, color: allBtnColor),
                        const SizedBox(width: 8),
                        Text(Strings.all, style: TextStyle(color: allBtnColor))
                      ])),
                  "fav": Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      child: Row(children: [
                        Icon(Icons.star_border_outlined, color: favBtnColor),
                        const SizedBox(width: 8),
                        Text(Strings.favorites, style: TextStyle(color: favBtnColor))
                      ]))
                },
                groupValue: selectedButton,
                onValueChanged: (String key) {
                  setState(() {
                    selectedButton = key;
                  });
                },
                unselectedColor: Colors.transparent,
                selectedColor: Colors.white,
                borderColor: Colors.white,
              ),
            )
          ],
        ))
      ]),
    );
  }
}
