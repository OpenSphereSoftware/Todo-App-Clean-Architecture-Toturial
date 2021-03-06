
import 'package:flutter/material.dart';
import 'package:todoappv0/2_domain/auth/entities/todo_color.dart';


class ColorField extends StatelessWidget {
  final TodoColor color;
  final Function callback;

  const ColorField({Key? key, required this.color , required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            const itemColor = Colors.blueAccent;
            return GestureDetector(
              onTap: () {
                callback();
              },
              child: const Material(
                color: itemColor,
                elevation: 4,
                shape:  CircleBorder(side:  BorderSide(width: 1.5)),
                child: SizedBox(
                  width: 50,
                  height: 50,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 12,
            );
          },
          itemCount: 6,
        ));
  }
}
