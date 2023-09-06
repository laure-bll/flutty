import 'dart:ui';

import 'package:flutter/material.dart';

import 'model/Userr.dart';

enum Gender {
  man,
  woman,
  other
}

String defaultImage = "https://firebasestorage.googleapis.com/v0/b/flotty-bd38d.appspot.com/o/Neteyam.webp?alt=media&token=accd64a8-2929-4a64-acc6-3c3126bb7050";

Userr currentUser = Userr();
