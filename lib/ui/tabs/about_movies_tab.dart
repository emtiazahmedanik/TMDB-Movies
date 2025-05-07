import 'package:flutter/material.dart';

class AboutMoviesTab extends StatelessWidget {
  const AboutMoviesTab({super.key,required this.overview});
  final String overview;

  @override
  Widget build(BuildContext context) {
    return Text(overview,style: TextStyle(color: Colors.white),);
  }
}
