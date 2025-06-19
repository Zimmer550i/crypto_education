import 'package:flutter/material.dart';

class ClickableButtonModel {
  final String? id;
  final String? icon;
  final String? title;
  final String? subTitle;
  final String? details;
  final Widget? route;
  final String? routeString;
  final String? link;
  final String? type;

  const ClickableButtonModel({
    this.id,
    this.icon,
    this.title,
    this.subTitle,
    this.route,
    this.routeString,
    this.details,
    this.link,
    this.type,
  });
}
