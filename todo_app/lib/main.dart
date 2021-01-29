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
  final TextEditingController _titleInputControler = TextEditingController();
  final TextEditingController _descriptionInputControler =
      TextEditingController();

  List<TodoItem> _todoList = <TodoItem>[];

  final Uuid uuid = Uuid();

  List<TodoItem> _data;

  String _option;

  @override
  void initState() {
    super.initState();
    _data = _todoList;
    _option = 'all';
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
            done: false);
        _todoList.add(todo);
      });
    }
    _titleInputControler.text = '';
    _descriptionInputControler.text = '';
  }

  Widget _buildTodoItem(TodoItem item) {
    return SizedBox(
      child: Card(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                setState(() {
                  final index = _todoList.indexOf(item);

                  _todoList = _todoList
                      .where((element) => element.id != item.id)
                      .toList();

                  _todoList.insert(
                    index,
                    TodoItem(
                      id: item.id,
                      title: item.title,
                      description: item.description,
                      done: !item.done,
                    ),
                  );

                  switch (_option) {
                    case 'all':
                      _data = _todoList;
                      break;
                    case 'done':
                      _data = _todoList.where((todo) => todo.done).toList();
                      break;
                    case 'none':
                      _data = _todoList.where((todo) => !todo.done).toList();
                      break;
                    default:
                  }
                });
              },
              trailing: Icon(
                item.done == true ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
              tileColor: Colors.blue,
              title: Text(
                item.title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              title: Text(
                item.description,
              ),
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
            decoration: InputDecoration(
              hintText: 'Description',
            ),
          ),
          TextButton(
            onPressed: _saveTodo,
            child: Text(
              'Submit',
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _option = 'all';
                    _data = _todoList;
                  });
                },
                child: Text(
                  'All',
                  style: TextStyle(
                    color: _option == 'all' ? Colors.red : Colors.blue,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _option = 'done';
                    _data = _todoList.where((todo) => todo.done).toList();
                  });
                },
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: _option == 'done' ? Colors.red : Colors.blue,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _option = 'none';
                    _data = _todoList.where((todo) => !todo.done).toList();
                  });
                },
                child: Text(
                  'None',
                  style: TextStyle(
                    color: _option == 'none' ? Colors.red : Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return _buildTodoItem(_data[index]);
                }),
          )
        ]),
      ),
    );
  }
}

class TodoItem {
  final String id;
  final String title;
  final String description;
  final bool done;

  const TodoItem(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.done});
}
