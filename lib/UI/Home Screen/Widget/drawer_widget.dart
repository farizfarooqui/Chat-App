// import 'package:chat_app/Auth%20Service/auth_service.dart';
// import 'package:flutter/material.dart';

// class DrawerWidget extends StatelessWidget {
//   const DrawerWidget({super.key});
//   void Logout() {
//     final _auth = AuthService();
//     _auth.signOut();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Padding(
//         padding: const EdgeInsets.only(top: 59),
//         child: ListView(padding: EdgeInsets.zero, children: <Widget>[
//           const ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.grey,
//             ),
//             title: Text('name'),
//           ),
//           const ListTile(title: Text("About")),
//           const ListTile(title: Text("Settings")),
//           ListTile(
//             title: const Text("Logout"),
//             onTap: () {
//               Logout();
//             },
//           )
//         ]),
//       ),
//     );
//   }
// }
