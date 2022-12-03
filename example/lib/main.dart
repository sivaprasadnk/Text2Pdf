import 'package:flutter/material.dart';
import "package:text2pdf/text2pdf.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text2Pdf example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  String content = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Text2pdf example"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.blue,
                  ),
                ),
                child: TextFormField(
                  onSaved: (val) {
                    content = val!;
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  createPdf();
                },
                child: const Text("Generate Pdf"),
              )
            ],
          ),
        ),
      ),
    );
  }

  createPdf() async {
    _formKey.currentState!.save();
    if (content.isNotEmpty) {
      await Text2Pdf.generatePdf(content);
    }
  }
}
