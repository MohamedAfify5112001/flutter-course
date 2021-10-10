import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double result;
  final int Age;
  final bool IsMale;

  ResultScreen({
    required this.result,
    required this.Age,
    required this.IsMale
    }
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
          onPressed: (){
              Navigator.pop(context);
          },
        ) ,
        title: Text("BMI Result"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Text(
              "Gender : ${IsMale ? 'Male' : 'Female'}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0
              ),
            ),
            Text(
              "Result : ${result.round()}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0
              ),
            ),
            Text(
              "Age : $Age",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0
              ),
            ),
          ],
        ),
      ),
    );
  }
}
