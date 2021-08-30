import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: themeData.textTheme.headline1!.copyWith(
                  fontSize: 50, fontWeight: FontWeight.w500, letterSpacing: 4),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Please enter you information below",
              style: themeData.textTheme.headline1!.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 4),
            ),
            const SizedBox(
              height: 80,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "E-Mail",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
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
                child: Text("Sign In",
                    style: themeData.textTheme.headline1!.copyWith(
                        fontSize: 14,
                        color: Colors.blueGrey[800],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4)),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: themeData.colorScheme.secondary),
              child: Center(
                child: Text("Register",
                    style: themeData.textTheme.headline1!.copyWith(
                        fontSize: 14,
                        color: Colors.blueGrey[800],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
