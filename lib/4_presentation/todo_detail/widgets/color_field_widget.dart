
import 'package:flutter/material.dart';


class ColorField extends StatelessWidget {
  const ColorField({Key? key}) : super(key: key);

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
              onTap: () {},
              child: Material(
                color: itemColor,
                elevation: 4,
                shape:const  CircleBorder(side:  BorderSide(width: 1.5)),
                child: Container(
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
