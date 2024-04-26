import 'package:flutter/material.dart';

class UserTileWidget extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  const UserTileWidget({
    super.key,
    required this.text,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
        child: ListTile(
          tileColor: Colors.grey[200],
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.person),
          ),
          title: Text(text),
          // subtitle: Text(email),
          trailing: Text('9:04 AM'),
        ),
      ),
    );
  }
}
