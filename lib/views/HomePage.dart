// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gastos/states/LoginState.dart';
import 'package:gastos/styles/Styles.dart';
import 'package:gastos/widgets/graphic_widget.dart';
import 'package:gastos/widgets/month_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = DateTime.now().month - 1;
  Stream<QuerySnapshot> _query;
  // Controllers
  PageController _monthController;

  @override
  void initState() {
    super.initState();

    _query = FirebaseFirestore.instance
        .collection('expenses')
        .where('month', isEqualTo: currentPage + 1)
        .snapshots();

    _monthController = new PageController(
      initialPage: currentPage,
      viewportFraction: 0.40,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottomActionBar(FontAwesomeIcons.history, () {}),
            _bottomActionBar(FontAwesomeIcons.chartPie, () {}),
            SizedBox(width: 48.0),
            _bottomActionBar(FontAwesomeIcons.wallet, () {}),
            _bottomActionBar(Icons.settings, () {
              Provider.of<LoginState>(context).logout();
            }),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/add');
        },
      ),
      body: _body(),
    );
  }

  ////////////////////////////////////////////////////////////////
  ///                                                          ///
  ///                         WIDGETS                          ///
  ///                                                          ///
  ////////////////////////////////////////////////////////////////

  Widget _bottomActionBar(IconData icon, Function callback) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon),
      ),
      onTap: () {},
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _selector(),
          StreamBuilder<QuerySnapshot>(
            stream: _query,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
              if (data.hasData) {
                return MonthWidget(
                  documents: data.data.docs,
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _pageItem(String pageName, int position) {
    var _alignment;
    if (position == currentPage) {
      _alignment = Alignment.center;
    } else if (position > currentPage) {
      _alignment = Alignment.centerRight;
    } else {
      _alignment = Alignment.centerLeft;
    }

    return Align(
      alignment: _alignment,
      child: Text(pageName,
          style: position == currentPage ? selected : unselected),
    );
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: Size.fromHeight(70.0),
      child: PageView(
        onPageChanged: (newPaage) {
          setState(() {
            currentPage = newPaage;
            _query = FirebaseFirestore.instance
                .collection('expenses')
                .where('month', isEqualTo: currentPage + 1)
                .snapshots();
          });
        },
        controller: _monthController,
        children: <Widget>[
          _pageItem("Enero", 0),
          _pageItem("Febrero", 1),
          _pageItem("Marzo", 2),
          _pageItem("Abril", 3),
          _pageItem("Mayo", 4),
          _pageItem("Junio", 5),
          _pageItem("Julio", 6),
          _pageItem("Agosto", 7),
          _pageItem("Septiembre", 8),
          _pageItem("Octubre", 9),
          _pageItem("Noviembre", 10),
          _pageItem("Diciembre", 11),
        ],
      ),
    );
  }
}
