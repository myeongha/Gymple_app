import 'package:flutter/material.dart';

BoxDecoration changeForegroundBoxDeco() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.green.withOpacity(0.2)
  );
}

BoxDecoration recoverForegroundBoxDeco() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
  );
}

BoxDecoration lockForegroundBoxDeco() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey.withOpacity(0.4)
  );
}