import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'second_page.dart'; // Import the SecondPage file
import 'package:flutter_learn/providers/counter_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyAppState()),
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ));
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> data = {};
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body) as Map<String, dynamic>;
          print(data);
        });
      }
    } catch(err) {
      print("err ==> $err");
    }

  }

  @override
  void initState() {
    super.initState();
    fetchData();  // Call fetchData when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: const Text('A random idea: of mine'),
          ),
          Text(pair.asLowerCase),
          Text(data['title'] ?? 'No data available'),
          ElevatedButton(
            onPressed: () {
              // Navigate to the SecondPage when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondPage(data: data)), // Push the new screen
              );
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
