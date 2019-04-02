import 'package:flutter/material.dart';
import 'package:first_screen_master/chart/simple_pie_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  var _menuItems = ['All Stocks (5)', 'Stock 2', 'Stock 3'];
  var _currentItem = 'All Stocks (5)';

  final mockData = [
    Fund('To Purify', 3000, Colors.red[900]),
    Fund('Purified', 7000, Colors.green[700]),
  ];

  List<charts.Series<Fund, String>> mapChartData(List<Fund> data) {
    return [
      charts.Series<Fund, String>(
        id: 'Funds',
        colorFn: (Fund fund, __) =>
            charts.ColorUtil.fromDartColor(fund.colorVal),
        domainFn: (Fund fund, _) => fund.type,
        measureFn: (Fund fund, _) => fund.amount,
        labelAccessorFn: (Fund fund, _) => '${fund.type} \n ${fund.amount}',
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      appBar: new AppBar(
        backgroundColor: Colors.purple[900],
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => debugPrint('Search Pressed'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30.0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.pie_chart,
                      color: Colors.white,
                    ),
                    onPressed: () => debugPrint('Pie Chart Pressed'),
                    color: Colors.blue[800],
                  ),
                  FlatButton(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.table_chart,
                      color: Colors.grey,
                    ),
                    onPressed: () => debugPrint('Table Chart Pressed'),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Center(
              child: new Text(
                'Purification Ratio',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            Center(
              child: new Text(
                '15%',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
            ),
            Container(
              width: 300.0,
              height: 300.0,
              child: SimplePieChart(mapChartData(mockData)),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                items: _menuItems.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
                value: _currentItem,
                onChanged: (String newValue) {
                  _dropDownSelected(newValue);
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            Center(
              child: Text(
                'How to Purify?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _dropDownSelected(String newValue) {
    setState(() {
      this._currentItem = newValue;
    });
  }
}
