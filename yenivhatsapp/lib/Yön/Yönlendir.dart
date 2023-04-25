import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yenivhatsapp/Account.dart';
import 'package:yenivhatsapp/Auth.dart';
import 'package:yenivhatsapp/Entityy/hesap.dart';
import 'package:yenivhatsapp/Y%C3%B6n/sidebar.dart';
import 'package:yenivhatsapp/differentAccount.dart';
import 'package:yenivhatsapp/paracek.dart';
import 'package:yenivhatsapp/parayat%C4%B1r.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import '../hesap_hareketleri.dart';
import 'dart:math' as math show pi;

class AnaSayfa extends StatefulWidget {
  String name="";

  AnaSayfa(String name){this.name=name;}
  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  String userName="";
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  AuthService _authService = AuthService();

  late List<CollapsibleItem> _items;


  @override
  void initState() {
    super.initState();
    _items = _generateItems;
  }


  Widget getUserName(){

    return
      FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Hata");
            } else if (snapshot.hasData) {
              return LogIn();
            } else {
              return CircularProgressIndicator();
            }
          });




  }

  LogIn() {


    AuthService _authService = AuthService();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference ana = firestore.collection("onur");
    DocumentReference ref =
    firestore.collection("onur").doc((_authService.uId().toString()));
    return StreamBuilder<QuerySnapshot>(
        stream: ana.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("hata");
          } else if (snapshot.hasData) {
            List<DocumentSnapshot> list = snapshot.data!.docs;
            List<dynamic> listt = list;
            for(int i=0;i<listt.length;i++){
              if(listt[i].data()["ID"]==_authService.uId()){
                userName=listt[i].data()["userName"];
                print(userName);
              }else{}
            }
            return Scaffold(backgroundColor: Colors.black,
                appBar: AppBar(
                    title: Text(
                      "ANA SAYFA",
                      style: TextStyle(fontSize: 25),
                    )),
                body: Center(

                  child: Column(mainAxisSize: MainAxisSize.max, children: [
Padding(padding: EdgeInsets.all(100)),

                    ElevatedButton(
                        onPressed: () {
                          _authService.signOut();
                          Navigator.pop(context);
                        },
                        child: Text("çıkış"))
                  ]),
                ));
          } else {
            return CircularProgressIndicator();
          }
        });


  }
  List<CollapsibleItem> get _generateItems {
    return [
       CollapsibleItem(
        text: 'HesapBilgilerim',
        icon: Icons.assessment,
        onPressed: () => setState(() => Navigator.push(context, MaterialPageRoute(builder: (context) => Account(),) )),

      ),

      CollapsibleItem(
        text: 'Para Çek',
        icon: Icons.monetization_on_rounded,
        onPressed: () => setState(() => Navigator.push(context, MaterialPageRoute(builder: (context) => paraCek(),) )),
      ),
      CollapsibleItem(
        text: 'Para Yatır',
        icon: Icons.monetization_on_outlined,
        onPressed: () => setState(() => Navigator.push(context, MaterialPageRoute(builder: (context) => paraYatir()) )),
      ),
      CollapsibleItem(
        text: 'Farklı hesaba para aktar',
        icon: Icons.transfer_within_a_station,
        onPressed: () => setState(() => Navigator.push(context, MaterialPageRoute(builder: (context) =>different(),) )),
      ),
      CollapsibleItem(
          text: 'giriş sayfasına dön',
          icon: Icons.home,
          onPressed: () => setState(() => Navigator.push(context, MaterialPageRoute(builder: (context) => Hesap() )),
          )),
      CollapsibleItem(
        text: 'Hesap Hareketleri',

        icon: Icons.access_alarm,
        onPressed: () => setState(() =>Navigator.push(context, MaterialPageRoute(builder: (context) => HesapHareketleri(),))),
      ),

    ];
  }
   @override
  Widget build(BuildContext context) {
     var size = MediaQuery.of(context).size;

     return
      SafeArea(
        child: CollapsibleSidebar(
          isCollapsed: true,
          items: _items,
        title: userName.toString()+" " ,
          toggleTitle: "Kapat",

          onTitleTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Collapsible Sidebar')));
          },
          body: _body( size, context),
          backgroundColor: Colors.black,
          selectedTextColor: Colors.white70,
          textStyle: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
          titleStyle: const TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
          toggleTitleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          sidebarBoxShadow: const [
            BoxShadow(
              color: Colors.indigo,
              blurRadius: 20,
              spreadRadius: 0.01,
              offset:  Offset(3, 3),
            ),
            BoxShadow(
              color: Colors.green,
              blurRadius: 50,
              spreadRadius: 0.01,
              offset:  Offset(3, 3),
            ),
          ],
        ),
      );
   }

  Widget _body(Size size, BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.blueGrey[50],
      child: Center(
        child:getUserName()

    ));}























}

