import 'package:flutter/material.dart';
import 'package:quest_quiz/Blocs/results_bloc.dart';
import 'package:quest_quiz/Models/results_model.dart';

class ResultsScreen extends StatefulWidget{ // TODO make Statefull
  final int id;
  ResultsScreen(this.id);
  final ResultsBloc resultsBloc = ResultsBloc();
  @override
  State<StatefulWidget> createState() {
    return ResultsScreenState();
  }
}

class ResultsScreenState extends State<ResultsScreen>{
  @override
  void initState(){
    resultsBloc.fetchResults(widget.id);
    super.initState();
  }
  @override
  void dispose(){
    resultsBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Results"),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: resultsBloc.results,
                builder: (context, AsyncSnapshot<Results> snapshot){
                  if(snapshot.hasData){
                    return dataTable(snapshot);
                  }
                  else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
        ),
      ),
    );
  }

  Widget dataTable(AsyncSnapshot<Results> snapshot){
    return DataTable(
        sortColumnIndex: 0,
        columns: snapshot.data.columns.columns.map((e) => DataColumn(label: Text(e))).toList(),
        rows: snapshot.data.rows.rows.map((e) => DataRow(
          cells: [
            for(int i = 0; i < snapshot.data.rows.rows.length; i++)
              DataCell(Text(snapshot.data.rows.rows[i].rowData[i])), // todo is there some error?
            ],
          ),
        ).toList(),
    );
  }
}