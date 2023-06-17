import 'package:flutter/material.dart';

class ItemMenu extends StatelessWidget {
  final String menu;

  const ItemMenu({super.key, required this.menu});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 10),
      constraints: const BoxConstraints(minWidth: 200),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('images/beverages.jpg'),
          fit: BoxFit.cover
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      // width: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [               
          Text(
            menu,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
            ),
          ),
          const Text(
            'IDR 15.000',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              color: Colors.white
            ),
          ),
        ],
      )
    );
  }
}