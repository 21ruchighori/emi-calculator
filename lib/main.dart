import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        title: "My Application"
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  final List _tenureTypes = [ 'Month(s)', 'Year(s)' ];
  String _tenureType = "Year(s)";
  String _emiResult = "";

  final TextEditingController _principalAmount = TextEditingController();
  final TextEditingController _interestRate = TextEditingController();
  final TextEditingController _tenure = TextEditingController();

  bool _switchValue = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("EMI Calculator"),
            elevation: 0.0
        ),

        body: Center(
            child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          controller: _principalAmount,
                          decoration: const InputDecoration(
                              labelText: "Enter Principal Amount"
                          ),
                          keyboardType: TextInputType.number,

                        )
                    ),

                    Container(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          controller: _interestRate,
                          decoration: const InputDecoration(
                              labelText: "Interest Rate"
                          ),
                          keyboardType: TextInputType.number,
                        )
                    ),

                    Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                                flex: 4,
                                fit: FlexFit.tight,
                                child: TextField(
                                  controller: _tenure,
                                  decoration: const InputDecoration(
                                      labelText: "Tenure"
                                  ),
                                  keyboardType: TextInputType.number,
                                )
                            ),

                            Flexible(
                                flex: 1,
                                child: Column(
                                    children: [
                                      Text(
                                          _tenureType,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold
                                          )
                                      ),
                                      Switch(
                                          value: _switchValue,
                                          onChanged: (bool value) {
                                            print(value);

                                            if( value ) {
                                              _tenureType = _tenureTypes[1];
                                            } else {
                                              _tenureType = _tenureTypes[0];
                                            }

                                            setState(() {
                                              _switchValue = value;
                                            });
                                          }

                                      )
                                    ]
                                )
                            )
                          ],
                        )

                    ),

                    Flexible(
                        fit: FlexFit.loose,
                        child: ElevatedButton(
                            onPressed: _handleCalculation,
                            child: const Text("Calculate"),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.redAccent,)
                            ),
                            // textColor: Colors.white,
                            // padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 24.0, right: 24.0)
                        )
                    ),

                    emiResultsWidget(_emiResult)

                  ],
                )
            )
        )
    );
  }

  void _handleCalculation() {

    //  Amortization
    //  A = Payemtn amount per period
    //  P = Initial Printical (loan amount)
    //  r = interest rate
    //  n = total number of payments or periods

    double A = 0.0;
    int P = int.parse(_principalAmount.text);
    double r = int.parse(_interestRate.text) / 12 / 100;
    int n = _tenureType == "Year(s)" ? int.parse(_tenure.text) * 12  : int.parse(_tenure.text);

    A = (P * r * pow((1+r), n) / ( pow((1+r),n) -1));

    _emiResult = A.toStringAsFixed(2);

    setState(() {

    });
  }


  Widget emiResultsWidget(emiResult) {

    bool canShow = false;
    String _emiResult = emiResult;

    if( _emiResult.length > 0 ) {
      canShow = true;
    }
    return
      Container(
          margin: const EdgeInsets.only(top: 40.0),
          child: canShow ? Column(
              children: [
                const Text("Your Monthly EMI is",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                    )
                ),
                Container(
                    child: Text(_emiResult,
                        style: const TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold
                        ))
                )
              ]
          ) : Container()
      );
  }
}