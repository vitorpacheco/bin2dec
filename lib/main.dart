import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bin 2 Dec',
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Bin 2 Dec'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  String _binaryValue;
  String _decimalValue;
  final _decimalController = TextEditingController();

  void _submitData() {
    print('_submitData');

    print(_binaryValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
//                        controller: _binaryController,
                        decoration: InputDecoration(labelText: 'Binary'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some number';
                          }

                          if (!RegExp('^[0-1]+\$').hasMatch(value)) {
                            return 'Please enter a valid binary number';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            _binaryValue = value;

                            var reversedBinaryText = _binaryValue
                                .split('')
                                .map((e) => int.tryParse(e))
                                .toList()
                                .reversed;

                            var binaryMap = {};
                            for (var i = 0; i < reversedBinaryText.length; i++) {
                              binaryMap[i] = reversedBinaryText.elementAt(i);
                            }

                            var result = 0;
                            binaryMap.forEach((index, element) {
                              result += element * pow(2, index);
                            });

                            _decimalController.text = result.toString();
                          });
                        },
                      ),
                      TextFormField(
                        controller: _decimalController,
                        decoration: InputDecoration(labelText: 'Decimal'),
                        keyboardType: TextInputType.number,
                        readOnly: true,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: RaisedButton(
                          child: Text('Convert'),
                          color: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).textTheme.button.color,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
