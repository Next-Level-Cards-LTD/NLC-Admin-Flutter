import 'package:flutter/material.dart';
import 'package:next_level_admin/Authentication/ErrorMessageHandlers/ErrorMessages_Authentication.dart';
import 'package:next_level_admin/Constants/Values/Constants_Colours.dart';
import 'package:next_level_admin/Constants/Values/Constants_Decorations.dart';
import 'package:next_level_admin/Shared/Libraries/Database_Library.dart';
import 'package:next_level_admin/Shared/Widgets/Widget_ValueListeners.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email = 'rickyjb816@gmail.com';
  String password = 'PrincessJaffa96!';
  String userName = '';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    Authentication().signInEmailAndPassword(email, password);

    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Sign In"),

            Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (val) => setState(() => email = val),
                      onSaved: (input) => email = input!,
                      validator: (input) => input!.isEmpty ? "Enter Valid Email Address" :  null,
                      decoration: textInputDecoration.copyWith(hintText: 'Email', prefixIcon: Icon(Icons.email, color: mainColor), labelText: 'Email'),
                    ),
                    TextFormField(
                      onChanged: (val) =>setState(() => password = val),
                      onSaved: (input) => password = input!,
                      validator: (input) => input!.isEmpty ? "Enter Valid Password" :  null,
                      decoration: textInputDecoration.copyWith(hintText: 'Password', prefixIcon: Icon(Icons.lock, color: mainColor), labelText: 'Password', labelStyle: TextStyle(color: mainColor)),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),

            ElevatedButton(onPressed: () => login(), child: Text("Login")),

            ErrorMessageText(notifier: SignInErrors.errorMessage),
          ],
        ),
      ),
    );
  }

  void login()
  {
    final formState = formKey.currentState;
    if(formState!.validate())
    {
      //formState.save();
      email = 'rickyjb816@gmail.com';
      password = 'PrincessJaffa96!';
      Authentication().signInEmailAndPassword(email, password);
    }
  }
}
