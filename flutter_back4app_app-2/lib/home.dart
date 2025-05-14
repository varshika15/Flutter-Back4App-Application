
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _name = TextEditingController();
  final _age = TextEditingController();
  List<ParseObject> _records = [];
  String _error = '';

  void _fetch() async {
    var query = QueryBuilder<ParseObject>(ParseObject('Record'));
    var result = await query.query();
    if (result.success && result.results != null) {
      setState(() => _records = result.results!.cast<ParseObject>());
    } else {
      setState(() => _error = 'Failed to load data');
    }
  }

  void _add() async {
    int? age = int.tryParse(_age.text.trim());
    if (age == null) {
      setState(() => _error = 'Age must be numeric');
      return;
    }

    var obj = ParseObject('Record')
      ..set('name', _name.text.trim())
      ..set('age', age);

    await obj.save();
    _fetch();
  }

  void _update(ParseObject obj) async {
    int? age = int.tryParse(_age.text.trim());
    if (age == null) {
      setState(() => _error = 'Age must be numeric');
      return;
    }

    obj.set('name', _name.text.trim());
    obj.set('age', age);
    await obj.save();
    _fetch();
  }

  void _delete(ParseObject obj) async {
    await obj.delete();
    _fetch();
  }

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Records')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _name, decoration: InputDecoration(labelText: 'Name')),
            TextField(
              controller: _age,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(onPressed: _add, child: Text('Add Record')),
            if (_error.isNotEmpty) Text(_error, style: TextStyle(color: Colors.red)),
            Expanded(
              child: ListView.builder(
                itemCount: _records.length,
                itemBuilder: (_, i) {
                  final record = _records[i];
                  return ListTile(
                    title: Text(record.get<String>('name') ?? ''),
                    subtitle: Text('Age: ${record.get<int>('age')}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: Icon(Icons.edit), onPressed: () => _update(record)),
                        IconButton(icon: Icon(Icons.delete), onPressed: () => _delete(record)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
