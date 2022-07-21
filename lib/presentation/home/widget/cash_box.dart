import 'package:flutter/material.dart';
import 'package:moneybag/domain/app/source.dart';

class CashBox extends StatelessWidget {
  final Source source;
  const CashBox(this.source, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              source.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            const Text(
              'BDT 0',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.deepPurple[400],
            border: Border.all(color: Colors.deepPurple, width: 2),
            borderRadius: BorderRadius.circular(10)));
  }
}
