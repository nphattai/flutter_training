import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      home: ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<ToDoList> {
  final _titleInputControler = TextEditingController();
  final _descriptionInputControler = TextEditingController();

  final _todoList = <TodoItem>[];
  final _doneList = <TodoItem>[];
  final _noneList = <TodoItem>[];

  final uuid = Uuid();

  List<TodoItem> _data;

  @override
  void initState() {
    super.initState();
    _data = _todoList;
  }

  @override
  void dispose() {
    super.dispose();
    _titleInputControler.dispose();
    _descriptionInputControler.dispose();
  }

  void _saveTodo() {
    if (_titleInputControler.text.trim() != '' &&
        _descriptionInputControler.text.trim() != '') {
      setState(() {
        final todo = TodoItem(
          id: uuid.v4(),
          title: _titleInputControler.text.trim(),
          description: _descriptionInputControler.text.trim(),
        );
        _todoList.add(todo);
        _noneList.add(todo);
      });
    }
    _titleInputControler.text = '';
    _descriptionInputControler.text = '';
  }

  Widget _buildTodoItem(TodoItem item) {
    final done = _doneList.contains(item);

    return SizedBox(
      child: Card(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                setState(() {
                  if (done == true) {
                    _doneList.remove(item);
                    _noneList.add(item);
                  } else {
                    _doneList.add(item);
                    _noneList.remove(item);
                  }
                });
              },
              trailing: Icon(
                done == true ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
              tileColor: Colors.blue,
              title: Text(item.title,
                  style: TextStyle(fontWeight: FontWeight.w500)),
            ),
            ListTile(
              title: Text(item.description),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO APP'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            TextField(
              controller: _titleInputControler,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: _descriptionInputControler,
              decoration: InputDecoration(hintText: 'Description'),
            ),
            TextButton(onPressed: _saveTodo, child: Text('Submit')),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        _data = _todoList;
                      });
                    },
                    child: Text(
                      'All',
                      style: TextStyle(
                          color: _data == _todoList ? Colors.red : Colors.blue),
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _data = _doneList;
                      });
                    },
                    child: Text('Done',
                        style: TextStyle(
                            color: _data == _doneList
                                ? Colors.red
                                : Colors.blue))),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _data = _noneList;
                      });
                    },
                    child: Text('None',
                        style: TextStyle(
                            color: _data == _noneList
                                ? Colors.red
                                : Colors.blue))),
              ],
            ),
            Expanded(
                flex: 1,
                child: ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      return _buildTodoItem(_data[index]);
                    }))
          ])),
    );
  }
}

class TodoItem {
  final String id;
  final String title;
  final String description;

  const TodoItem(
      {@required this.id, @required this.title, @required this.description});
}
