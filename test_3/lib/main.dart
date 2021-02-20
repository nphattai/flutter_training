import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:test_3/AppImages.dart';
import 'package:test_3/models/location.dart';
import 'package:test_3/models/results.dart';
import 'package:test_3/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (_, ThemeModel model, __) {
          return MaterialApp(
            theme: ThemeData.light(), // Provide light theme.
            darkTheme: ThemeData.dark(), // Provide dark theme.
            themeMode: model.mode, // Decides which theme to show.
            home: MyHomePage(model: model),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.model}) : super(key: key);

  final ThemeModel model;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: futureUser,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          final Results results = snapshot.data.results[0];
          final String avatar = results.picture.medium;
          final String fullName = results.name.first + ' ' + results.name.last;
          final String email = results.email;
          final String phoneNumber = results.phone;
          final Location location = results.location;
          final String address = location.street.number.toStringAsFixed(0) +
              ' ' +
              location.street.name +
              ' ' +
              location.city +
              ' ' +
              location.country;

          final bool isLightMode = widget.model._mode == ThemeMode.light;

          final String background =
              isLightMode ? AppImages.morning : AppImages.night;

          final IconData iconData =
              isLightMode ? Icons.nightlight_round : Icons.lightbulb_outlined;

          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Flexible(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 30),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover, image: AssetImage(background)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage(
                                avatar,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                fullName,
                                style: const TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        child: FlatButton(
                          onPressed: () {
                            widget.model.toggleMode();
                          },
                          child: Icon(
                            iconData,
                          ),
                        ),
                        right: 0,
                        top: 50,
                      )
                    ],
                  ),
                  flex: 3,
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          leading: Icons.email,
                          content: email,
                        ),
                        Card(
                          leading: Icons.phone,
                          content: phoneNumber,
                        ),
                        Card(
                          leading: Icons.map,
                          content: address,
                        ),
                      ],
                    ),
                  ),
                  flex: 7,
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text('$snapshot.error');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Future<User> fetchUser() async {
    final http.Response response = await http.get('https://randomuser.me/api/');

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load Data');
    }
  }
}

class Card extends StatelessWidget {
  const Card({
    Key key,
    this.content = '',
    this.leading,
  }) : super(key: key);

  final IconData leading;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 0.5,
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(leading),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(content),
          )
        ],
      ),
    );
  }
}

class ThemeModel with ChangeNotifier {
  ThemeModel({ThemeMode mode = ThemeMode.light}) : _mode = mode;

  ThemeMode _mode;
  ThemeMode get mode => _mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
