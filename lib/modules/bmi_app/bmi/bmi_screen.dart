import 'dart:math';
import 'package:course_flutter/modules/bmi_app/bmiresult/Bmiresult_screen.dart';
import 'package:course_flutter/shared/components/components.dart';
import 'package:flutter/material.dart';
class BmiScreen extends StatefulWidget {
  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  Color? mainColor = Colors.grey[400];
  Color? toggleColor = Colors.blue;
  bool isMale = true;
  var height = 120.0;
  var defaultAge = 20;
  var defaultWeight = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children:
                [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(()
                        {
                          isMale = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: (isMale == true) ? toggleColor : mainColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: AssetImage("assets/images/male.png"),
                              width: 60.0,
                              height: 60.0,
                            ),
                            SizedBox(height: 5.0,),
                            Text(
                                "Male",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: (isMale == false) ? toggleColor : mainColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("assets/images/icons8-female-100.png"),
                              width: 60.0,
                              height: 60.0,
                            ),
                            SizedBox(height: 5.0,),
                            Text(
                              "Female",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey[400]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                  Text(
                  "Height",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "${height.round()}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),),
                      Text(
                        "Cm",
                        style: TextStyle(
                          fontSize: 12.0,
                        ),),
                    ],
                  ),
                  Slider(
                        value: height,
                        min: 80.0,
                        max: 200.0,
                        onChanged: (val){
                          setState(() {
                            height = val;
                          });
                        }
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.grey[400]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text(
                            "Age",
                            style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            )
                          ),
                          Text(
                              "$defaultAge",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32.0,
                              )
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              FloatingActionButton(
                                heroTag: "Age-",
                                  onPressed: (){
                                    setState(() {
                                      defaultAge--;
                                    });
                                  },
                                  child: Icon(Icons.remove),
                                  mini: true,
                                  ),
                              FloatingActionButton(
                                heroTag: "Age+",
                                onPressed: (){
                                  setState(() {
                                    defaultAge++;
                                  });
                                },
                                child: Icon(Icons.add),
                                mini: true,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.grey[300]
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text(
                              "Weight",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              )
                          ),
                          Text(
                              "$defaultWeight",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32.0,
                              )
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              FloatingActionButton(
                                heroTag: "weight-",
                                onPressed: (){
                                  setState(() {
                                    defaultWeight--;
                                  });
                                },
                                child: Icon(Icons.remove),
                                mini: true,
                              ),
                              FloatingActionButton(
                                heroTag: "weight+",
                                onPressed: (){
                                  setState(() {
                                    defaultWeight++;
                                  });
                                },
                                child: Icon(Icons.add),
                                mini: true,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 50.0,
            color: Colors.blue,
            child: MaterialButton(
                child: Text("Calculate", style: TextStyle(color: Colors.white), ) ,
                onPressed: (){
                  double Result = defaultWeight / pow((height / 100), 2) ;
                  NavigateTo(context, ResultScreen(
                      Age: defaultAge,
                      result: Result,
                      IsMale: isMale
                  ));
                }
                ),
          )
        ],
      ),
    );
  }
}
