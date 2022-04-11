// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';

class PostBody extends StatelessWidget {
  final String postSummary;
  const PostBody({required this.postSummary});
  @override
  Widget build(BuildContext context) {

    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
          child: Text(
            postSummary,
          ),
        ));

  }
}
