

class Results{
  Columns columns;
  Rows rows;

  Results({this.columns, this.rows});

  factory Results.fromJson(Map<String, dynamic> parsedJson){
    return Results(
      columns: Columns.fromJson(parsedJson),
      rows: Rows.fromJson(parsedJson)
    );
  }

}


class Columns{
  List<String> columns;

  Columns({this.columns});

  factory Columns.fromJson(Map<String, dynamic> parsedJson){

    var columnsFromJson = parsedJson['columns'];
    List<String> _columns = columnsFromJson.cast<String>();

    return Columns(
      columns: _columns
    );
  }
}

class ResultRow{
  List<String> rowData;

  ResultRow({this.rowData});

  factory ResultRow.fromJson(Map<String, dynamic> parsedJson){

    var rowFromJson = parsedJson['row'];
    List<String> _rowData = rowFromJson.cast<String>();
    return ResultRow(
      rowData: _rowData
    );
  }
}

class Rows{
  List<ResultRow> rows;

  Rows({this.rows});

  factory Rows.fromJson(Map<String, dynamic> parsedJson){
    var _list = parsedJson['rows'] as List;
    List<ResultRow> _rows = _list.map((i) => ResultRow.fromJson(i)).toList();
    return Rows(
      rows: _rows,
    );
  }

}