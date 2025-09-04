// import 'package:flutter/material.dart';
//
// class ElevatedButtonTile extends StatelessWidget {
//   final VoidCallback onTap;
//
//   const ElevatedButtonTile({required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         color: Colors.white, // White background for the tile
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Language Preferences',
//                   style: TextStyle(
//                     color: Colors.black, // Black text color
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   'Edit your language preferences any time',
//                   style: TextStyle(
//                     color: Colors.black54, // Black text with reduced opacity
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//             Icon(
//               Icons.arrow_forward_ios,
//               color: Colors.black, // Black color for the arrow icon
//               size: 16,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ElevatedButtonTile extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String subtitle;

  const ElevatedButtonTile({
    required this.onTap,
    this.title = 'Language Preferences',
    this.subtitle = 'Edit your language preferences any time',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    // fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
