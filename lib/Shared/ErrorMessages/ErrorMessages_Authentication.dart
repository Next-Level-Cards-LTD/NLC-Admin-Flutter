import 'package:flutter/cupertino.dart';


//TODO Make enum for both classes to make more standardised
class RegisterErrors
{
  static ValueNotifier<String> errorMessage = ValueNotifier<String>('');

  static String show(String errorCode)
  {
    switch(errorCode)
    {
      case 'weak-password':
        errorMessage.value = 'The password provided is too weak.';
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        errorMessage.value = 'The account already exists for that email.';
        return 'The account already exists for that email.';
      default:
        return 'Unknown Error';
    }
  }
}

class SignInErrors
{
  static ValueNotifier<String> errorMessage = ValueNotifier<String>('');

  static String show(String errorCode)
  {
    switch(errorCode)
    {
      case 'user-not-found':
        errorMessage.value = 'No user found for that email.';
        return 'No user found for that email.';
      case 'wrong-password':
        errorMessage.value = 'Wrong password provided for that user.';
        return 'Wrong password provided for that user.';
      default:
        return 'Unknown Error';
    }
  }
}