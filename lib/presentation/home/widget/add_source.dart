import 'package:flutter/material.dart';

class AddSource extends StatelessWidget {
  const AddSource({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Add\nSource',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Icon(
                Icons.add_box_sharp,
                color: Colors.deepPurple,
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.deepPurple[100],
              border: Border.all(color: Colors.deepPurple, width: 2),
              borderRadius: BorderRadius.circular(10))),
    );
  }
}
