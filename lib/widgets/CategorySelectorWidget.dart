import 'package:flutter/material.dart';

class CategorySelectorWidget extends StatefulWidget {
  final Map<String, IconData> categories;
  final Function(String) valueChanged;

  const CategorySelectorWidget(
      {Key? key, required this.categories, required this.valueChanged})
      : super(key: key);

  @override
  _CategorySelectorWidgetState createState() => _CategorySelectorWidgetState();
}

class CategoryWidget extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isSelected;

  const CategoryWidget(
      {Key? key,
      required this.name,
      required this.icon,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey,
                width: isSelected ? 3.0 : 1.0,
              ),
            ),
            child: Icon(icon),
          ),
          Text(name)
        ],
      ),
    );
  }
}

class _CategorySelectorWidgetState extends State<CategorySelectorWidget> {
  String itemSelected = "";
  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];

    widget.categories.forEach((name, icon) {
      widgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              itemSelected = name;
            });
            widget.valueChanged(name);
          },
          child: CategoryWidget(
            name: name,
            icon: icon,
            isSelected: name == itemSelected,
          ),
        ),
      );
    });

    return ListView(
      children: widgets,
      scrollDirection: Axis.horizontal,
    );
  }
}
