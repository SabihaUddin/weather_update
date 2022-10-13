import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  static String routeName = '/detail';
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(height: MediaQuery.of(context).size.height * .5,
       margin: const EdgeInsets.all(2),
       padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
       decoration: const BoxDecoration(
           color: Color(0xff00A1FF),
           borderRadius: BorderRadius.only(
               bottomLeft: Radius.circular(40),
               bottomRight: Radius.circular(40)),
           boxShadow: [
             BoxShadow(
               color: Colors.blue,
               blurRadius: 15.5,
               spreadRadius: 5,
             )
           ]),),
    );
  }
}
