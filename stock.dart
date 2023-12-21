import 'package:flutter/material.dart';

void main() => runApp(StockManagementApp());

class StockManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StockManagementScreen(),
    );
  }
}

class StockManagementScreen extends StatefulWidget {
  @override
  _StockManagementScreenState createState() => _StockManagementScreenState();
}

class _StockManagementScreenState extends State<StockManagementScreen> {
  final TextEditingController _itemController = TextEditingController();
  List<String> _items = [];

  void _addItem() {
    setState(() {
      _items.add(_itemController.text);
      _itemController.clear();
    });
  }

  void _editItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Item'),
          content: TextFormField(
            controller: _itemController,
            decoration: InputDecoration(labelText: 'Item Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _items[index] = _itemController.text;
                  _itemController.clear();
                  Navigator.of(context).pop();
                });
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Do you want to remove this item from the list?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _items.removeAt(index);
                  Navigator.of(context).pop();
                });
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Management System'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_items[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editItem(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteItem(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add Item'),
                content: TextFormField(
                  controller: _itemController,
                  decoration: InputDecoration(labelText: 'Item Name'),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      _addItem();
                      Navigator.of(context).pop();
                    },
                    child: Text('Add'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
