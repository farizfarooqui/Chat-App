import 'package:flutter/material.dart';

class UserTileWidget extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  const UserTileWidget({super.key, required this.text,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: () {},
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.person),
        ),
        title: Text(text),
        // subtitle: Text(email),
      ),
    );
  }
}
