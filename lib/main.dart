import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dogzin_app/Models/Dog.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Dogzin App'),
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
  // int _counter = 0;
  Future<Dog> futureDog;
  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //     print("Estou clicando rsrs");
  //   });
  // }

  void dogButton() {
    setState(() {
      this.futureDog = fetchDogzin();
    });
  }

  Future<Dog> fetchDogzin() async {
    final response =
        await http.get(Uri.https('dog.ceo', 'api/breeds/image/random'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Dog.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureDog = fetchDogzin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Text(
        //       'Click and see the dogzin:',
        //     ),
        //     Text(
        //       '$_counter',
        //       style: Theme.of(context).textTheme.headline4,
        //     ),
        //   ],
        // ),
        child: FutureBuilder<Dog>(
          future: futureDog,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.network(snapshot.data.message);
              // return Text(snapshot.data.message);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: dogButton,
        tooltip: 'Increment',
        child: Icon(Icons.pets),
      ),
    );
  }
}
