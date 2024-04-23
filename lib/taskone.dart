import 'package:flutter/material.dart';

void main() {
  runApp(const TaskOne());
}

class TaskOne extends StatelessWidget {
  const TaskOne({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Task 1',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 1')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(items[index]),
           trailing: IconButton(
             icon: const Icon(Icons.edit),
             onPressed: () => _editItem(index),
           ),
            onLongPress: () => _deleteItem(index),
          );
        },
      ),
    );
  }

  void _editItem(int index) {
    String editedItem = items[index];
    TextEditingController controller = TextEditingController(text: items[index]);
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Edit Item'),
            content: TextField(
              onChanged: (value){
                editedItem = value;
              },
              controller: controller,
              decoration: const InputDecoration(hintText: 'Edit item name'),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel')
              ),
              TextButton(
                  onPressed: (){
                    setState(() {
                      items[index] = editedItem;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'))
            ],
          );
        });
  }

  void _deleteItem(int index) {
    setState((){
      items.removeAt(index);
    });
  }

  void _addItem(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          String newItem = '';
          return AlertDialog(
            title: const Text('Add Item'),
            content: TextField(
              onChanged: (value) => newItem = value,
              decoration: const InputDecoration(hintText: 'Enter item name'),
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop()
              ),
              TextButton(
                child: const Text('Add'),
                onPressed: () {
                  setState(() {
                    items.add(newItem);
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }
}

