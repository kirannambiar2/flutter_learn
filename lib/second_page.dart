import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learn/providers/counter_provider.dart';

class SecondPage extends StatefulWidget {
  final Map<String, dynamic> data;
  SecondPage({required this.data});
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the second page! ${context.watch<Counter>().count}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Passed Title: ${widget.data['title']}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Counter: $counter',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
                context.read<Counter>().increment();
                print('Counter: $counter');
              },
              child: Text('Increase'),
            ),
          ],
        ),
      ),
    );
  }
}