import 'package:flutter/material.dart';

import 'ctm_txt.dart';

class CustomAppBar extends AppBar {
  final String txtTitle;
  final BuildContext context;
  final bool? isHomeScreen;
  final Color? bgColor;

  CustomAppBar(
      {super.key,
      required this.txtTitle,
      required this.context,
      this.isHomeScreen,
      this.bgColor})
      : super(
          title: CustomTxt(
            txtTitle,
            color: Colors.black,
          ),
          centerTitle: false,
          backgroundColor: bgColor ?? const Color.fromARGB(255, 200, 173, 247),
          iconTheme: const IconThemeData(color: Colors.black),
        );
}
