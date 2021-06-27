import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gastos/widgets/CategorySelectorWidget.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late String category;
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          'Categoria',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: <Widget>[
        _categorySelector(),
        _currentValue(),
        _numpad(),
        _submit(),
      ],
    );
  }

  Widget _categorySelector() {
    return Container(
      height: 80,
      child: CategorySelectorWidget(
        categories: {
          "Compras": Icons.shopping_cart,
          "Alcohol": Icons.local_drink,
          "Comida": Icons.fastfood,
        },
        valueChanged: (newCategory) => category = newCategory,
      ),
    );
  }

  Widget _currentValue() {
    var realValue = value / 100;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Text(
        "${realValue.toStringAsFixed(2)}€",
        style: TextStyle(
          fontSize: 50.0,
          color: Colors.blueAccent,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _num(String text, double phoneHeight) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          if (text == ',') {
            value = value * 100;
          } else
            value = value * 10 + int.parse(text);
        });
      },
      child: Container(
        height: phoneHeight,
        child: Center(
          child: Text(text,
              style: TextStyle(
                fontSize: 40,
                color: Colors.grey,
              )),
        ),
      ),
    );
  }

  Widget _numpad() {
    return Expanded(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var phoneHeight = constraints.biggest.height / 4;
          return Table(
            border: TableBorder.all(
              color: Colors.grey,
              width: 1.0,
            ),
            children: [
              TableRow(
                children: [
                  _num("1", phoneHeight),
                  _num("2", phoneHeight),
                  _num("3", phoneHeight),
                ],
              ),
              TableRow(
                children: [
                  _num("4", phoneHeight),
                  _num("5", phoneHeight),
                  _num("6", phoneHeight),
                ],
              ),
              TableRow(
                children: [
                  _num("7", phoneHeight),
                  _num("8", phoneHeight),
                  _num("9", phoneHeight),
                ],
              ),
              TableRow(
                children: [
                  _num(",", phoneHeight),
                  _num("0", phoneHeight),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        value = value ~/ 10;
                      });
                    },
                    child: Container(
                      height: phoneHeight,
                      child: Center(
                        child: Icon(
                          Icons.backspace,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _submit() {
    return Builder(
      builder: (BuildContext context) {
        return Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue.shade900, Colors.blue.shade600],
                    stops: [0.28, 0.75],
                    begin: FractionalOffset.bottomLeft,
                    end: FractionalOffset.topRight)),
            child: MaterialButton(
              child: Text(
                "Añadir gasto",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                ),
              ),
              onPressed: () {
                if (value > 0 && category != '') {
                  FirebaseFirestore.instance.collection('expenses').add({
                    'category': category,
                    'value': value,
                    'month': DateTime.now().month,
                    'day': DateTime.now().day
                  });
                  Navigator.of(context).pop();
                } else {
                  // ignore: deprecated_member_use
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selecciona la cantidad y la categoría.'),
                    ),
                  );
                }
              },
            ));
      },
    );
  }
}
