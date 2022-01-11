import 'package:flutter/material.dart';
import 'package:task_2/screens/data_fetching.dart';
import 'package:task_2/screens/group_list.dart';
import 'package:task_2/my_theme.dart';
import 'package:task_2/screens/pizza_calculator.dart';
import 'package:task_2/screens/weight_calc.dart';

import 'calculator_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: getMyTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: "Золотуев"),
        '/pizza_calculator': (context) => PizzaCalculator(),
        '/weight_calculator': (context) => WeightCalculator(),
        '/group_list': (context) => GroupList()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.wb_sunny_outlined)),
          TextButton(onPressed: null, child: Text("посмотреть"))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
                child: Container(
                  alignment: Alignment.center,
                  height: 200,
                  child: Text("Навигация"),
                )
            ),
             ListTile(
              leading: Text("Калькулятор пиццы"),
              trailing: Icon(Icons.fastfood_sharp),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PizzaCalculator()),
                );
              },
            ),
            const Divider(),
             ListTile(
              leading: Text("AppBar"),
              trailing: Icon(Icons.sentiment_very_dissatisfied),
               onTap: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => WeightCalculator()),
                 );
               },
            ),
            const Divider(),
            ListTile(
              leading: Text("Storage"),
              trailing: Icon(Icons.medical_services),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorStorage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: Text("ListView"),
              trailing: Icon(Icons.group),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GroupList()),
                );
              },
            ),
            ListTile(
              leading: Text("Networking"),
              trailing: Icon(Icons.network_wifi),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataFetching()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "Толстяки",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Исправившиеся",
          ),
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
