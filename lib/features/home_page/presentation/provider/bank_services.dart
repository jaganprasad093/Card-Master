// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class BankServices {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Get stream of all banks
//   Stream<QuerySnapshot> getBanksStream() {
//     return _firestore.collection('creditCards').snapshots();
//   }

//   // Add a new bank
//   Future<void> addBank(String bankName) async {
//     await _firestore.collection('banks').add({
//       'name': bankName,
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//   }

//   // Edit an existing bank
//   Future<void> editBank(String bankId, String newName) async {
//     await _firestore.collection('banks').doc(bankId).update({
//       'name': newName,
//       'updatedAt': FieldValue.serverTimestamp(),
//     });
//   }

//   // Delete a bank
//   Future<void> deleteBank(String bankId) async {
//     await _firestore.collection('banks').doc(bankId).delete();
//   }

//   // Show add/edit dialog
//   Future<String?> showBankDialog(
//     BuildContext context, {
//     String title = 'Add New Bank',
//     String? currentName,
//   }) async {
//     final TextEditingController controller = TextEditingController(
//       text: currentName,
//     );

//     return await showDialog<String>(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             title: Text(title),
//             content: TextField(
//               controller: controller,
//               decoration: const InputDecoration(hintText: 'Enter bank name'),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, controller.text),
//                 child: const Text('Save'),
//               ),
//             ],
//           ),
//     );
//   }

//   // Show delete confirmation dialog
//   Future<bool> showDeleteConfirmation(
//     BuildContext context,
//     String bankName,
//   ) async {
//     final result = await showDialog<bool>(
//       context: context,
//       builder:
//           (context) => AlertDialog(
//             title: const Text('Confirm Delete'),
//             content: Text('Are you sure you want to delete $bankName?'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context, false),
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, true),
//                 child: const Text(
//                   'Delete',
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//             ],
//           ),
//     );

//     return result ?? false;
//   }
// }
