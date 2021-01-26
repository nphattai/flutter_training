import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final celsiusInputController = TextEditingController();
  final fahrenheitInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    celsiusInputController.dispose();
    fahrenheitInputController.dispose();
    super.dispose();
  }

  void _convertCelsiusToFahrenheit(String value) {
    fahrenheitInputController.text = double.tryParse(value) == null
        ? '0'
        : (double.parse(celsiusInputController.text) * 1.8 + 32)
            .toStringAsFixed(2);
  }

  void _convertFahrenheitToCelsius(String value) {
    celsiusInputController.text = double.tryParse(value) == null
        ? '0'
        : ((double.parse(fahrenheitInputController.text) - 32) / 1.8)
            .toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter test 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: celsiusInputController,
              decoration:
                  InputDecoration(hintText: 'Enter Celsius Temperature'),
              keyboardType: TextInputType.number,
              onChanged: _convertCelsiusToFahrenheit,
            ),
            TextField(
              controller: fahrenheitInputController,
              decoration:
                  InputDecoration(hintText: 'Enter Fahrenheit Temperature'),
              keyboardType: TextInputType.number,
              onChanged: _convertFahrenheitToCelsius,
            ),
          ],
        ),
      ),
    );
  }
}
