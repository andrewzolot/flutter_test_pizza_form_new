import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CalculatorStorage extends StatefulWidget {
  const CalculatorStorage({Key? key}) : super(key: key);

  @override
  State<CalculatorStorage> createState() => _CalculatorStorageState();
}

class _CalculatorStorageState extends State<CalculatorStorage> {
  int _calcSP = 0;
  int _calcFile = 0;

  _incrementCounterSP() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _calcSP = (prefs.getInt('calcSP') ?? 0) + 1;
      prefs.setInt('calcSP', _calcSP);
    });
  }

  _loadSP() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _calcSP = prefs.getInt('calcSP') ?? 0;
    });
  }

  _incrementCounterFile() async {
    try{
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final file = File('$path/counter.txt');
      final contents = await file.readAsString();
      setState(() {
        _calcFile = int.parse(contents) + 1;
        // Write the file
        file.writeAsString('$_calcFile');
      });
    } catch (e) {
      // If encountering an error, return 0
      print(e);
    }
  }

  _loadFile() async {
    try{
      print("try to load data from file");
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final file = File('$path/counter.txt');
      final contents = await file.readAsString();
      setState(() {
        _calcFile = int.parse(contents);
      });
    } catch (e) {
      // If encountering an error, return 0
      print(e);
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final file = File('$path/counter.txt');
      file.writeAsString('$_calcFile');
      print("Finished to write file in loading");
    }
  }


  @override
  void initState() {
    super.initState();
    _loadSP();
    _loadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Хранение данных"),
      ),
      body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        _incrementCounterSP();
                      },
                      child: Text("Shared prefs")),
                  Text('$_calcSP')
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: (){
                        _incrementCounterFile();
                      },
                      child: Text("File")),
                  Text('$_calcFile')
                ],
              )
            ],
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




