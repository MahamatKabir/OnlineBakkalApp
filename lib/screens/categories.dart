import 'package:flutter/material.dart';
import 'package:gracery/services/utils.dart';
import 'package:gracery/widget/categories_widget.dart';
import 'package:gracery/widget/text_widget.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];

  List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/images/png-clipart-truck-truck.png',
      'catText': 'Mercedes',
    },
    {
      'imgPath': 'assets/images/png-clipart-truck-truck.png',
      'catText': 'BMW',
    },
    {
      'imgPath': 'assets/images/png-clipart-truck-truck.png',
      'catText': 'renault',
    },
    {
      'imgPath': 'assets/images/png-clipart-truck-truck.png',
      'catText': 'toyota',
    },
    {
      'imgPath': 'assets/images/png-clipart-truck-truck.png',
      'catText': 'ferari',
    },
    {
      'imgPath': 'assets/images/png-clipart-truck-truck.png',
      'catText': 'rosvegan',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            text: 'Categories',
            color: color,
            textSize: 24,
            isTitle: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 250,
            crossAxisSpacing: 10, // Vertical spacing
            mainAxisSpacing: 10, // Horizontal spacing
            children: List.generate(6, (index) {
              return CategoriesWidget(
                catText: catInfo[index]['catText'],
                imgPath: catInfo[index]['imgPath'],
                passedColor: gridColors[index],
              );
            }),
          ),
        ));
  }
}
