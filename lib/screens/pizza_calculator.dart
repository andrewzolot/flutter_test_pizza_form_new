import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../custom_slider.dart';


final List<String> souceNames = ["Острый", "Кисло-сладкий", "Сырный"];
final pizzaSizesMinAndMax = [30.0, 50.0];


class PizzaCalculator extends StatefulWidget {
  PizzaCalculator({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _PizzaCalculatorState createState() => _PizzaCalculatorState();
}

class _PizzaCalculatorState extends State<PizzaCalculator> {

  int testoType = 0;
  double pizzaSize = pizzaSizesMinAndMax[0];
  int souceVal = 1;
  bool needMoreCheese = false;
  double resultCost = 0;
  double testoCostPerSq_1 = 1;
  double testoCostPerSq_2 = 0.7;
  TextEditingController txtController  = new TextEditingController();

  void calcCost() {
    if (testoType == 0) resultCost = pi * pow(pizzaSize/2, 2) * testoCostPerSq_1;
    else resultCost = pi * pow(pizzaSize/2, 2) * testoCostPerSq_2;
    if (needMoreCheese) resultCost = resultCost + 30;
    if (souceVal == 1) resultCost = resultCost + 10;
    else if (souceVal == 2) resultCost = resultCost + 15;
    else resultCost = resultCost + 40;
    txtController.text = resultCost.toString() + " руб";
  }

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return Scaffold(
      appBar: null,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  width: 232,
                  height: 123,
                  child:Image(
                    image: AssetImage('assets/images/pizza.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(top: 33,bottom:9.0),
                        child: Text(
                            'Калькулятор пиццы',
                            style: Theme.of(context).textTheme.headline5
                        ),
                    ),
                    Text(
                        'Выберите параметры:',
                        style: Theme.of(context).textTheme.headline6
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 33,bottom:19.0),
                      child: FlutterToggleTab(
                        // width in percent, to set full width just set to 100
                        width: 90,
                        borderRadius: 30,
                        height: 50,
                        selectedIndex:testoType,
                        selectedTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                        unSelectedTextStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        labels: ["Обычное тесто", "Тонкое тесто"],
                        selectedLabelIndex: (index) {
                          setState(() {
                            testoType = index;
                          });
                          calcCost();
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Размер:',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16.0,
                          height: 1.21,
                          color: Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                    ),
                    CustomSliderWithTextField(
                        sizes: pizzaSizesMinAndMax,
                        callback: (value) {
                          pizzaSize = value;
                          calcCost();
                        },
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Соус:',
                        style: Theme.of(context).textTheme.headline6
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 18.0, right: 11.0, bottom: 10.0),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:<Widget>[
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 0),
                              title: Text('Острый'),
                              trailing: SizedBox(
                                height: 20, width: 20,
                                child: Radio(
                                  value: 1,
                                  groupValue: souceVal,
                                  onChanged: (value) {
                                    setState(() {
                                      souceVal = value as int;
                                      calcCost();
                                    });
                                  },
                                  activeColor: Colors.green,
                                ),
                              ),
                            ),
                            Divider(
                              color: Color.fromRGBO(232, 232, 232, 1),
                              height: 1,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 0),
                              title: Text('Кисло-сладкий'),
                              trailing: SizedBox(
                                height: 20, width: 20,
                                child: Radio(
                                  value: 2,
                                  groupValue: souceVal,
                                  onChanged: (value) {
                                    setState(() {
                                      souceVal = value as int;
                                      calcCost();
                                    });
                                  },
                                  activeColor: Colors.green,
                                ),
                              ),
                            ),
                            Divider(
                              color: Color.fromRGBO(232, 232, 232, 1),
                              height: 1,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 0),
                              title: Text('Сырный'),
                              trailing: SizedBox(
                                height: 20, width: 20,
                                child: Radio(
                                  value: 3,
                                  groupValue: souceVal,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      souceVal = value as int;
                                      calcCost();
                                    });
                                  },
                                  activeColor: Colors.green,
                                ),
                              ),
                            ),
                            Divider(
                              color: Color.fromRGBO(232, 232, 232, 1),
                              height: 1,
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 18.0),
                                width: MediaQuery.of(context).size.width,
                                height: 56.0,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(240, 240, 240, 1),//remove color to make it transpatent
                                    border: Border.all(
                                        style: BorderStyle.solid,
                                        color: Colors.white),
                                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                          width:36,
                                          height: 34,
                                          child:SvgPicture.asset(
                                                "assets/icons/cheese.svg",
                                                )
                                          ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: Text(
                                          "Дополнительный сыр",
                                          style: Theme.of(context).textTheme.headline6
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: Switch(
                                        activeColor: Color.fromRGBO(14, 77, 164, 1),
                                        value: needMoreCheese,
                                        onChanged: (value) {
                                          setState(() {
                                            needMoreCheese = value;
                                          });
                                          calcCost();
                                        },
                                      ),
                                      flex: 1,
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Стоимость:',
                        style: Theme.of(context).textTheme.bodyText2
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom:33.0),
                      child:  TextField(
                        controller: txtController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(236, 239, 241, 1),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(36.0)),
                            borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
                          ),
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {

                      },
                      child: Container(
                        margin: const EdgeInsets.only(left:42.0, top:11.0, right:42.0, bottom:12.0),
                        child:Text(
                          "Заказать",
                          style: Theme.of(context).textTheme.bodyText1
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(0, 121, 208, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                      ),
                    )
                  ]
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


