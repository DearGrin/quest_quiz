import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class Superheros extends StatefulWidget {
  @override
  _SuperherosState createState() => _SuperherosState();
}

class _SuperherosState extends State<Superheros> {
  List<Avengers> avengers;
  List<Cols> cols;
  List<Avengers> selectedAvengers;
  bool sort;



  @override
  void initState() {
    sort = false;
    avengers = Avengers.getAvengers();
    cols = Cols.getCols();
    super.initState();
  }

 // onSortColum(int columnIndex, bool ascending) {
 //   if (columnIndex == 0) {
  //    if (ascending) {
  //      avengers.sort((a, b) => a.name.compareTo(b.name));
  //    } else {
  //      avengers.sort((a, b) => b.name.compareTo(a.name));
 //     }
  //  }
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avengers DataTable"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: DataTable(
              sortAscending: sort,
              sortColumnIndex: 0,
              columns: cols.map((e) => DataColumn(label: Text(e.name)),).toList(),
              rows:avengers
                  .map((avenger) => DataRow(
                    cells:
                    [
                      for(int i= 0; i < avenger.params.length; i++)
                        DataCell(Text(avenger.params[i])),
                    ]),
              )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}


class Cols {
  String name;
  Cols({this.name});

  static List<Cols> getCols() {
    return <Cols>[
      Cols(name: "Name"),
      Cols(name: "Weapon"),
    ];
  }
}

class Avengers {
  List<String> params = [];
  Avengers({this.params});
  static List<Avengers> getAvengers() {
    return <Avengers>[
      Avengers(params: ['Thor','Молот']),
      Avengers(params: ['Кэп','Щит']),
    ];
  }
}





