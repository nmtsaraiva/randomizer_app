import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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
  final TextEditingController _minimumController = TextEditingController(text: "0");
  final TextEditingController _maximumController = TextEditingController(text: "1");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Minimum",
              hintText: "Minimum",
            ),
            controller: _minimumController
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Maximum number",
              hintText: "Maximum",
            ),
            controller: _maximumController
          ),
        ),
        const Gap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Center(
            child: FloatingActionButton.extended(
              label: const Text("Generate"),
              backgroundColor: Colors.blue,
              onPressed: () {
                setState(() {
                  _showNumberRandomized();
                });
              },
              tooltip: "Randomizer",
            ),
          ),
        ),
        const Gap(80),
        const Center(
          child: Text("Randomized number is: ", style: TextStyle(fontSize: 20),),
        ),
        const Gap(20),
        _showNumberRandomized()
      ],
    );
  }
   Widget _showNumberRandomized(){
    if(_maximumController.text.isEmpty || _minimumController.text.isEmpty){
      return const AlertDialog(
        title: Text("Numbers will be entered"),
      );
    }else {
      return
        Center(
          child: Center(child: Text(
            (Random().nextInt(int.parse(_maximumController.text)) +
                int.parse(_minimumController.text)).toString(),
            style: const TextStyle(
                fontSize: 40
            ),)),
        );
    }
  }
}



