import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Loading...",
              style: themeData.textTheme.headline1!.copyWith(
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
