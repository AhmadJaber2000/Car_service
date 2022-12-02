// import"package:flutter/material.dart"
// class DropdownIssue extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _DropdownIssueState();
//   }
// }
//
// class _DropdownIssueState extends State<DropdownIssue> {
//   int currentValue = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//           color: Colors.grey,
//           child: Container(
//             alignment: Alignment.center,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 CustomDropDown(
//                     hint: 'hint',
//                     errorText: '',
//                     value: currentValue,
//                     items: [
//                       DropdownMenuItem(
//                         value: 0,
//                         child: Text('test 0'),
//                       ),
//                       DropdownMenuItem(
//                         value: 1,
//                         child: Text('test 1'),
//                       ),
//                       DropdownMenuItem(
//                         value: 2,
//                         child: Text('test 2'),
//                       ),
//                     ].cast<DropdownMenuItem<int>>(),
//                     onChanged: (value) {
//                       setState(() {
//                         currentValue = value;
//                       });
//                       print('changed to $value');
//                     }
//                 ),
//               ],
//             ),
//           )
//       ),
//     );
//   }
// }
