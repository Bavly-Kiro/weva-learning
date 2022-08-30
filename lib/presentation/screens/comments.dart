// ListView.builder(
//   shrinkWrap: true,
//   physics: NeverScrollableScrollPhysics(),
//   itemCount: 5,
//   itemBuilder: (context, index) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundImage: NetworkImage(
//             'https://thumbs.dreamstime.com/b/male-student-portrait-handsome-man-enjoy-study-home-schooling-concept-education-knowledge-work-as-office-assistant-178491145.jpg',
//           ),
//           // backgroundColor: Colors.blue,
//           radius: MediaQuery.of(context).size.width * 0.09,
//         ),
//         title: Text(
//           'name',
//           style: GoogleFonts.rubik(
//             fontSize: 18,
//             fontWeight: FontWeight.w500,
//             color: Colors.black,
//           ),
//         ),
//         subtitle: Text(
//           'phone',
//           style: GoogleFonts.urbanist(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Color(0XFF616161),
//           ),
//         ),
//         trailing: Container(
//           child: IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.ac_unit),
//           ),
//         ),
//         // Container(
//         //     decoration: BoxDecoration(
//         //       color: Color(0X333787ff),
//         //       borderRadius: BorderRadius.circular(20),
//         //     ),
//         //     child: Padding(
//         //       padding: EdgeInsets.all(10),
//         //       child: Row(
//         //         children: <Widget>[
//         //           Icon(
//         //             Icons.ac_unit,
//         //             color: Colors.black,
//         //           ),
//         //           SizedBox(
//         //             width: MediaQuery.of(context).size.width * 0.01,
//         //           ),
//         //           Text(
//         //             'GAME',
//         //             style: GoogleFonts.rubik(
//         //               fontSize: 12,
//         //               color: Colors.black,
//         //             ),
//         //           ),
//         //         ],
//         //       ),
//         //     ),),
//         // Row(
//         //   children: [
//         //     CircleAvatar(
//         //       backgroundImage: NetworkImage(
//         //         'https://thumbs.dreamstime.com/b/male-student-portrait-handsome-man-enjoy-study-home-schooling-concept-education-knowledge-work-as-office-assistant-178491145.jpg',
//         //       ),
//         //       // backgroundColor: Colors.blue,
//         //       radius: MediaQuery.of(context).size.width * 0.09,
//         //     ),
//         //     SizedBox(
//         //       width: MediaQuery.of(context).size.width * 0.04,
//         //     ),
//         //     Text('data'),
//         //   ],
//         // ),
//       ),
//     );
//   },
// ),
// ListView.builder(
//   shrinkWrap: true,
//   physics: NeverScrollableScrollPhysics(),
//   itemBuilder: (context, index) {
//     return Padding(
//         padding: EdgeInsets.all(12),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             CircleAvatar(
//               backgroundImage: NetworkImage(
//                 'https://thumbs.dreamstime.com/b/male-student-portrait-handsome-man-enjoy-study-home-schooling-concept-education-knowledge-work-as-office-assistant-178491145.jpg',
//               ),
//               // backgroundColor: Colors.blue,
//               radius: MediaQuery.of(context).size.width * 0.09,
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.04,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text(
//                   'name',
//                   style: GoogleFonts.rubik(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.01,
//                 ),
//                 Text(
//                   'phone',
//                   style: GoogleFonts.urbanist(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0XFF616161),
//                   ),
//                 ),
//               ],
//             ),
//             GestureDetector(
//               onTap: () {},
//               child: Container(
//                   decoration: BoxDecoration(
//                     color: Color(0X333787ff),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Row(
//                       children: <Widget>[
//                         Icon(
//                           Icons.ac_unit,
//                           color: Colors.black,
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width *
//                               0.01,
//                         ),
//                         Text(
//                           'GAME',
//                           style: GoogleFonts.rubik(
//                             fontSize: 12,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )),
//             ),
//           ],
//         ));
//   },
// ),
