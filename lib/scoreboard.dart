import 'package:flutter/material.dart';
import 'main.dart';

List<DataRow> playerList = [];

class ResultPage extends StatelessWidget {
  ResultPage({required this.score, required this.name});
  final int score;
  final String name;

  @override
  Widget build(BuildContext context) {
    playerList.add(DataRow(
        cells: <DataCell>[DataCell(Text('$name')), DataCell(Text('$score'))]));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "The scoreboard",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'DancingScript',
                    fontSize: 35.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(
                      fontFamily: 'DancingScript',
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Score',
                    style: TextStyle(
                      fontFamily: 'DancingScript',
                    ),
                  ),
                )
              ],
              rows: playerList,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FirstScreen()));
            },
            child: Expanded(
              child: Container(
                child: const Text(
                  'R E P L A Y',
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
    );
  }
}
