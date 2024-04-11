import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app2/widgets/common_listtile.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
        home: EmiCalculator(),
        title: "My Application");
  }
}

class EmiCalculator extends StatefulWidget {
  const EmiCalculator({Key? key}) : super(key: key);

  @override
  State<EmiCalculator> createState() => _EmiCalculatorState();
}

class _EmiCalculatorState extends State<EmiCalculator> {
  double loanAmountSliderValue = 16000;
  double rateOfInterestSliderValue = 12;
  double loanTenureSliderValue = 2;
  double? emi;
  String? formattedEmi,formattedTotalInterest,formattedTotalAmount;
  List<PieData> data=[];
  void calculateEmiAmount(){
    double monthlyInterestRate = (rateOfInterestSliderValue / 12) / 100;
    int totalInstallments = (loanTenureSliderValue).round();

    emi = loanAmountSliderValue *
        monthlyInterestRate *
        pow(1 + monthlyInterestRate, totalInstallments) /
        (pow(1 + monthlyInterestRate, totalInstallments) - 1);
    // print("Emi : $emi");
     formattedEmi = emi!.toStringAsFixed(2);

    double totalRepayment = emi! * totalInstallments;
    double totalInterest = totalRepayment - loanAmountSliderValue;
     formattedTotalInterest = totalInterest.round().toStringAsFixed(2);
    double totalAmount = loanAmountSliderValue + totalInterest;
     formattedTotalAmount = totalAmount.round().toStringAsFixed(2);
     data = [
      PieData('Total Principal Amount', loanAmountSliderValue,
          const Color(0xFFBB868E)),
      PieData('Emi', totalInterest, const Color(0xFFFEFEFF)),
    ];
  }
  @override
  Widget build(BuildContext context) {
    calculateEmiAmount();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "EMI Calculator",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              // height: MediaQuery.of(context).size.height,
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                color: const Color(0xFF252A31),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.05), spreadRadius: 5, blurRadius: 2),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Slider(
                    value: loanAmountSliderValue,
                    max: 100000,
                    min: 15000,
                    divisions: 85,
                    activeColor: const Color(0xFFBB868E),
                    inactiveColor: const Color(0xFFFEFEFF),
                    label: loanAmountSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        loanAmountSliderValue = value;
                      });
                    },
                  ),
                  listTile(false,
                      title: "Loan Amount", subTitle: "$loanAmountSliderValue"),
                  Slider(
                    value: rateOfInterestSliderValue,
                    max: 28,
                    min: 1,
                    divisions: 27,
                    activeColor: const Color(0xFFBB868E),
                    inactiveColor: const Color(0xFFFEFEFF),
                    label: rateOfInterestSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        rateOfInterestSliderValue = value;
                      });
                    },
                  ),
                  listTile(false,
                      title: "Rate Of Interest",
                      subTitle: "$rateOfInterestSliderValue"),
                  Slider(
                    value: loanTenureSliderValue,
                    max: 30,
                    min: 1,
                    divisions: 29,
                    activeColor: const Color(0xFFBB868E),
                    inactiveColor: const Color(0xFFFEFEFF),
                    label: loanTenureSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        loanTenureSliderValue = value;
                      });
                    },
                  ),
                  listTile(false,
                      title: "Loan tenure",
                      subTitle: "$loanTenureSliderValue Months"),
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: SfCircularChart(
                            legend: const Legend(isVisible: false),
                            series: <DoughnutSeries<PieData, String>>[
                              DoughnutSeries<PieData, String>(
                                explode: false,
                                explodeIndex: 0,
                                dataSource: data,
                                pointColorMapper: (PieData data, _) =>
                                    data.color,
                                xValueMapper: (PieData data, _) => data.xData,
                                yValueMapper: (PieData data, _) => data.yData,
                                // dataLabelMapper: (PieData data, _) => data.text,
                                dataLabelSettings:
                                    const DataLabelSettings(isVisible: false),
                              ),
                            ]),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "EMI",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Rs.$formattedEmi",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  listTile(
                    true,
                    title: "Principal Amount",
                    subTitle: "Rs.$loanAmountSliderValue",
                    containerColor: const Color(0xFFBB868E),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    subTitleColor: Colors.white,
                  ),
                  listTile(
                    true,
                    title: "Total Interest",
                    subTitle: "Rs.$formattedTotalInterest",
                    containerColor: const Color(0xFFFEFEFF),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    subTitleColor: Colors.white,
                  ),
                  listTile(
                    false,
                    title: "Total",
                    subTitle: "Rs.$formattedTotalAmount",
                    fontSize: 18,
                    subTitleColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF2C2D36),
    );
  }
}


class PieData {
  PieData(this.xData, this.yData, this.color);

  final String xData;
  final num yData;
  final Color color;
}
