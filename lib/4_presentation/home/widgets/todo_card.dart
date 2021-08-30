import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String title;
  const TodoCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
      onTap: () {
        // todo implement on tap
      },
      child: Card(
        elevation: 16,
        color: themeData.colorScheme.onPrimary,
        child: ListTile(
          leading: InkResponse(
              onTap: () {},
              onLongPress: () {},
              child: Icon(
                Icons.check_box,
                size: 22,
                color: themeData.textTheme.headline1!.color,
              )),
          title: Text(
            title,
            style: themeData.textTheme.headline1!
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          //  subtitle: Text("subtitle"),
        ),
      ),
    );
  }
}
