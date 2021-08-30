import 'package:flutter/material.dart';
import 'package:todoappv0/4_presentation/home/widgets/todo_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Todo App",
          style: themeData.textTheme.headline1!
              .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Icon(Icons.check_box),
          ),
        ],
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 20,
          itemBuilder: (BuildContext context, index) {
            return TodoCard(title: "todo $index");
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeData.colorScheme.secondary,
        onPressed: () {
          //todo implement on pressed
        },
        child: const Icon(
          Icons.add,
          size: 26,
        ),
      ),
    );
  }
}
