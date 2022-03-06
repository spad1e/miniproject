import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    ),
  );
}

class FirstScreen extends StatefulWidget {
  FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: Center(
                  child: Text(
                    'Enter your name',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        fillColor: Colors.blue[800], filled: true),
                    textAlign: TextAlign.center,
                    controller: myController,
                  ),
                ),
              ),
            ),
            //เริ่มต้นตัวอย่างการใช้งาน
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(name: myController.text)));
              },
              child: Expanded(
                child: Container(
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue[900],
                  height: 50.0,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
