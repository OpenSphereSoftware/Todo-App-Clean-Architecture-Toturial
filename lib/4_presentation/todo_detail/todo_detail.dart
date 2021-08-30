import 'package:flutter/material.dart';
import 'package:todoappv0/4_presentation/todo_detail/widgets/color_field_widget.dart';

class TodoDetail extends StatelessWidget {
  const TodoDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Todo",
          style: themeData.textTheme.headline1!
              .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Title",
                  counterText: "",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
              maxLength: 100,
              maxLines: 2,
              minLines: 1,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Description",
                  counterText: "",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
              maxLength: 300,
              maxLines: 8,
              minLines: 5,
            ),
            const SizedBox(
              height: 20,
            ),
            const ColorField(),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: themeData.colorScheme.secondary),
              child: Center(
                child: Text("Safe",
                    style: themeData.textTheme.headline1!.copyWith(
                        fontSize: 14,
                        color: Colors.blueGrey[800],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
