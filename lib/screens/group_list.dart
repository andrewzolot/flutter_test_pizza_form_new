import 'package:flutter/material.dart';
import 'package:task_2/models/user.dart';


class GroupList extends StatefulWidget {
  const GroupList({Key? key}) : super(key: key);


  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {

  List<User> usersList = <User>[User("Петр", "89390343"), User("Петр", "89390343"), User("Петр", "89390343"), User("Петр", "89390343")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Группа"),
      ),
      body: Center(
        child: UsersList(list: usersList)
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class UserItem extends StatelessWidget {
  const UserItem({Key? key, required this.name, required this.phone}) : super(key: key);
  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name),
        Text("Phone: " + phone)
      ],
    );
  }
}

class UsersList extends StatelessWidget {
  const UsersList({Key? key, required this.list}) : super(key: key);

  final List<User> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        child: UserItem(name: list[index].name, phone: list[index].phone),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("У него все хорошо"))),
      );
    }
  );
  }
}




