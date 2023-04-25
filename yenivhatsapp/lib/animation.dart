import 'package:flutter/material.dart';
import 'package:yenivhatsapp/Entityy/hesap.dart';

class Animationpage extends StatefulWidget {
  const Animationpage({Key? key}) : super(key: key);

  @override
  State<Animationpage> createState() => _AnimationpageState();
}

class _AnimationpageState extends State<Animationpage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
late Animation<double>_animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration( seconds: 1));
  _animation=CurvedAnimation(parent: _controller, curve:Curves.bounceInOut)..addListener(() {this.setState(() {

  }); })..addStatusListener((status) { });
  _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(backgroundColor: Colors.blueGrey,
        appBar: AppBar(backgroundColor: Colors.cyanAccent,centerTitle: true,title: Text("HOŞGELDİNİZ",style: TextStyle(color: Colors.blueGrey,fontSize: 10+10*_animation.value),)),
     body:Column(
       children: [
     Container(margin: EdgeInsets.all(160),child: ElevatedButton(style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide.none),backgroundColor: MaterialStatePropertyAll(Colors.cyanAccent)),onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Hesap(),)), child: Text("İlerle",style: TextStyle(fontSize: 17,color: Colors.blueGrey),))),

       ],
       
       
     )); 
      Container(
      color: Colors.black,

    );
  }
}
