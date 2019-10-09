import 'package:flutter/material.dart';


class StepperPage extends StatefulWidget {
  @override
  _StepperState createState() => _StepperState();
}

List<Step> my_steps(){
 List<Step> steps = [
   Step(
     title: Text("Morning Dosage"),
     subtitle: Text("This is our first article"),
     content: Text("In this article, I will tell you how to create a page."),
   ),
   Step(
       title: Text("AfterNoon Dosage"),
       subtitle: Text("Constructor"),
       content: Text("Let's look at its construtor."),
       state: StepState.editing,
       isActive: true),
   Step(
       title: Text("Night Dosage"),
       subtitle: Text("Constructor"),
       content: Text("Let's look at its construtor."),
       state: StepState.error),

  ];
  return steps;
}

class _StepperState extends State<StepperPage> {
 var _index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STEPPER"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              //margin: EdgeInsets.only(top: 10),
              color: Colors.lightGreenAccent,
              //color: Colors.redAccent,
              child: Stepper(

                type: StepperType.vertical,
                steps: my_steps(),
                currentStep: _index,
                onStepTapped: (index) {
                  setState(() {
                    _index = index;
                  });
                },
                onStepCancel: () {
                  print("You are clicking the cancel button.");
                },
                onStepContinue: () {
                  print("You are clicking the continue button.");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
