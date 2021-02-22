import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<User> futureUser;

  bool isLightMode = true;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(), // Provide light theme.
      darkTheme: ThemeData.dark(), // Provide dark theme.
      themeMode: isLightMode
          ? ThemeMode.light
          : ThemeMode.dark, // Decides which theme to show.
      home: Scaffold(
        body: FutureBuilder<User>(
          future: futureUser,
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.hasData) {
              final Results results = snapshot.data.results[0];
              final String avatar = results.picture.medium;
              final String fullName = results.name.fullName;
              final String email = results.email;
              final String phoneNumber = results.phone;
              final Location location = results.location;
              final String address = location.address;

              final String background =
                  isLightMode ? AppImages.morning : AppImages.night;

              final IconData iconData = isLightMode
                  ? Icons.nightlight_round
                  : Icons.lightbulb_outlined;

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
                                fit: BoxFit.cover,
                                image: AssetImage(background)),
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
                              setState(() {
                                isLightMode = !isLightMode;
                              });
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
              return Center(
                child: Text(
                  '$snapshot.error',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
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
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(leading),
          ),
          Expanded(
            child: Text(
              content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
