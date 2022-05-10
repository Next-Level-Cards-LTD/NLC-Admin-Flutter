import 'package:flutter/foundation.dart';

class OrderListener
{
  static ValueNotifier<String> activeOrderUID = ValueNotifier<String>('');

  static void setActiveOrderUID(String uid)
  {
    activeOrderUID.value = uid;
  }

  static void clearActiveOrderUID()
  {
    activeOrderUID.value = '';
  }
}