
import 'package:flutter/material.dart';

Widget listTile(
    bool hasLeading, {
      String? title,
      String? subTitle,
      Color? containerColor,
      double? fontSize,
      FontWeight? fontWeight,
      Color? subTitleColor,
    }) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 5),
    child: ListTile(
      leading: hasLeading
          ? Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: containerColor,
        ),
      )
          : null,
      title: Text(
        "$title",
        style: TextStyle(
          fontSize: fontSize ?? 15,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: const Color(0xFF9D9FA2),
        ),
      ),
      trailing: Text(
        "$subTitle",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: subTitleColor ?? const Color(0xFFBB868E),
        ),
      ),
    ),
  );
}