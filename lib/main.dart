import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Randomizer project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: const Center(child: Text("Randomizer")),
          ),
          body: const FormNumbers()),
    );
  }
}

class FormNumbers extends StatefulWidget {
  const FormNumbers({Key? key}) : super(key: key);

  @override
  State<FormNumbers> createState() => _FormNumbersState();
}

class _FormNumbersState extends State<FormNumbers> {
  final TextEditingController _minimumController = TextEditingController();
  final TextEditingController _maximumController = TextEditingController();

  bool _isVisible = false;

  var randomNumber = "";

  _showDialog(String message) {
    showDialog(context: context, builder: (ctx) =>  AlertDialog(
      title: const Text("Error", style: TextStyle(fontSize: 21),),
      content: Text(message, style: const TextStyle(fontSize: 21),),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(17),
              child: const Text("OK", style: TextStyle(fontSize: 21),),
            ))
      ],
    ));
  }

  Future<void> _showRandomized() async {
    setState(()  {
       randomNumber =  (int.parse(_minimumController.text) +  Random().nextInt((int.parse(_maximumController.text)) -
          int.parse(_minimumController.text))).toString();
       _isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(60),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.lightBlueAccent
                ),
                height: 100,
                width: 180,
                padding: const EdgeInsets.fromLTRB(21, 21, 21, 21),
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      labelText: "Minimum", labelStyle: TextStyle(fontSize: 21, color: Colors.white),
                    ),
                    controller: _minimumController
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.redAccent
                ),
                height: 100,
                width: 180,
                padding: const EdgeInsets.fromLTRB(21, 21, 21, 21),
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      labelText: "Maximum", labelStyle: TextStyle(fontSize: 21, color: Colors.white),
                    ),
                    controller: _maximumController
                ),
              ),
            ],
          ),
        ),
        const Gap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Center(
            child: FloatingActionButton.extended(
              label: const Text("Generate"),
              backgroundColor: Colors.lightGreen,
              onPressed: () async {
                if(_minimumController.text.isEmpty || _maximumController.text.isEmpty ) {
                  _showDialog("Enter a minimum and maximum number");
                } else if (int.parse(_minimumController.text) > int.parse(_maximumController.text)){
                  _showDialog("The minimum number cannot be greater than the maximum");
                } else if(int.parse(_minimumController.text) == int.parse(_maximumController.text)){
                  _showDialog("The minimum number cannot be equal than the maximum");
                } else {
                  await _showRandomized();
                }
              },
              tooltip: "Randomizer",
            ),
          ),
        ),
        const Gap(80),
        Visibility(
            visible: _isVisible,
            child: Column(
              children: [
                const Center(
                  child: Text("Randomized number is: ", style: TextStyle(fontSize: 20),),
                ),
                const Gap(20),
                Center(
                  child: Text(
                    randomNumber,
                    style: const TextStyle(fontSize: 40),
                  ),
                )
              ],
            )
        )
      ],
    );
  }
}







