import 'package:flutter/material.dart';
import 'package:moneybag/domain/app/user_profile.dart';

import 'add_source.dart';
import 'cash_box.dart';

class TopPart extends StatelessWidget {
  final UserProfile profile;
  const TopPart(this.profile, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  text: 'Hello ',
                  style:
                      const TextStyle(fontSize: 20, color: Colors.deepPurple),
                  children: [
                TextSpan(
                    text: profile.name,
                    style: const TextStyle(fontWeight: FontWeight.bold))
              ])),
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              'Your sources',
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2,
                  childAspectRatio: 2,
                  mainAxisSpacing: 2,
                  crossAxisCount: 3),
              itemCount: profile.sources.length + 1,
              itemBuilder: (context, index) {
                if (index == profile.sources.length) {
                  return const AddSource();
                } else {
                  return CashBox(profile.sources[index]);
                }
              }),
        ],
      ),
    );
  }
}
