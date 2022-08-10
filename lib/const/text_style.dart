import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Widget normalText({String? text, Color? color, double? size}) {
  return Text(
    text!,
    style: GoogleFonts.quattrocento(color: color, fontSize: size),
  );
}

Widget headingText({String? text, Color? color, double? size}) {
  return Text(
    text!,
    style: GoogleFonts.quattrocento(
        color: color, fontSize: size, fontWeight: FontWeight.bold),
  );
}
