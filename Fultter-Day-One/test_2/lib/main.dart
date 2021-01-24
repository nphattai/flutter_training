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

    celsiusInputController.addListener(_convertCelsiusToFahrenheit);
    fahrenheitInputController.addListener(_convertFahrenheitToCelsius);
  }

  @override
  void dispose() {
    celsiusInputController.dispose();
    fahrenheitInputController.dispose();
    super.dispose();
  }

  void _convertCelsiusToFahrenheit() {
    String fahrenheit = '';
    fahrenheit = celsiusInputController.text == ''
        ? ''
        : '${int.parse(celsiusInputController.text) * 1.8 + 32}';
    fahrenheitInputController.text = fahrenheit;
  }

  void _convertFahrenheitToCelsius() {
    String celsius = '';
    celsius = fahrenheitInputController.text == ''
        ? ''
        : '${(int.parse(fahrenheitInputController.text) - 32) / 1.8}';
    celsiusInputController.text = celsius;
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
            ),
            TextField(
              controller: fahrenheitInputController,
              decoration:
                  InputDecoration(hintText: 'Enter Fahrenheit Temperature'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
