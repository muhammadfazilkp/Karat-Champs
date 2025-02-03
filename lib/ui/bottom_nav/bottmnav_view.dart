// import 'package:flutter/material.dart';

// class BottmnavView extends StatefulWidget {  
//   const BottmnavView ({super.key});  
  
//   @override  
//   // ignore: library_private_types_in_public_api
//   _BottmnavViewState createState() => _BottmnavViewState();  
// }  
  
// class _MyNavigationBarState extends State<BottmnavView > {  
//   int _selectedIndex = 0;  
//   static const List<Widget> _widgetOptions = <Widget>[  
//     Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
//     Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
//     Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
//   ];  
  
//   void _onItemTapped(int index) {  
//     setState(() {  
//       _selectedIndex = index;  
//     });  
//   }  
  
//   @override  
//   Widget build(BuildContext context) {  
//     return Scaffold(  
     
//       body: Center(  
//         child: _widgetOptions.elementAt(_selectedIndex),  
//       ),  
//       bottomNavigationBar: BottomNavigationBar(  
//         items: const <BottomNavigationBarItem>[  
//           BottomNavigationBarItem(  
//             icon: Icon(Icons.home),  
//             label: 'Home',  
//             backgroundColor: Colors.green  
//           ),  
//           BottomNavigationBarItem(  
//             icon: Icon(Icons.search),  
//             label: 'Search',  
//             backgroundColor: Colors.yellow  
//           ),  
//           BottomNavigationBarItem(  
//             icon: Icon(Icons.person),  
//             label: 'Profile',  
//             backgroundColor: Colors.blue,  
//           ),  
//         ],  
//         type: BottomNavigationBarType.shifting,  
//         currentIndex: _selectedIndex,  
//         selectedItemColor: Colors.black,  
//         iconSize: 40,  
//         onTap: _onItemTapped,  
//         elevation: 5  
//       ),  
//     );  
//   }  
// }  