// import 'package:card_master/core/components/customtext.dart';
// import 'package:card_master/core/constants/color_constants.dart';
// import 'package:card_master/core/constants/size_constants.dart';
// import 'package:card_master/features/home_page/data/model/credit_card_model.dart';
// import 'package:card_master/features/home_page/presentation/pages/credit_card_master.dart';
// import 'package:card_master/features/home_page/widgets/BankCardItem.dart';
// import 'package:card_master/features/home_page/widgets/add_bank_card.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class BankMasterPage extends StatefulWidget {
//   const BankMasterPage({super.key});

//   @override
//   State<BankMasterPage> createState() => _BankMasterPageState();
// }

// class _BankMasterPageState extends State<BankMasterPage> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstants.backgroundColor,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: ColorConstants.primaryBlack),
//           onPressed: () {
//             context.go("/bottomnavigation/2");
//           },
//         ),
//         title: CustomText(
//           data: "Bank Master",
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//       ),
//       body: Column(
//         children: [
//           StreamBuilder<QuerySnapshot>(
//             stream: _firestore.collection('creditCards').snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                 return const Center(child: Text('No banks added yet'));
//               }

//               return ListView.separated(
//                 padding: EdgeInsets.all(0),
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   final bank = snapshot.data!.docs[index];
//                   return InkWell(
//                     onTap: () {},
//                     child: BankCardItem(
//                       bankId: bank.id,
//                       bankName: bank['bankName'],
//                       onEdit:
//                           () => _editBank(context, bank.id, bank['bankName']),
//                       onDelete: () => _deleteBank(bank.id),
//                     ),
//                   );
//                 },
//                 separatorBuilder:
//                     (context, index) =>
//                         SizedBox(height: SizeConstants.height(context) * .02),
//                 itemCount: snapshot.data!.docs.length,
//               );
//             },
//           ),
//           SizedBox(height: SizeConstants.height(context) * .02),
//           AddBankCard(),
//         ],
//       ),
//     );
//   }

//   Future<void> _editBank(
//     BuildContext context,
//     String bankId,
//     String currentName,
//   ) async {
//     final doc = await _firestore.collection('creditCards').doc(bankId).get();
//     if (doc.exists) {
//       final data = doc.data() as Map<String, dynamic>;

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder:
//               (context) => CreditCardMaster(
//                 isEdit: true,
//                 creditCardModel: CreditCardModel.fromMap(data, bankId),
//               ),
//         ),
//       );
//     }
//   }

//   Future<void> _deleteBank(String bankId) async {
//     await _firestore.collection('creditCards').doc(bankId).delete();
//   }
// }

import 'package:card_master/core/components/customtext.dart';
import 'package:card_master/core/constants/color_constants.dart';
import 'package:card_master/core/constants/log_constanst.dart';
import 'package:card_master/core/constants/size_constants.dart';
import 'package:card_master/features/home_page/data/model/credit_card_model.dart';
import 'package:card_master/features/home_page/presentation/pages/credit_card_master.dart';
import 'package:card_master/features/home_page/widgets/BankCardItem.dart';
import 'package:card_master/features/home_page/widgets/add_bank_card.dart';
import 'package:card_master/features/home_page/widgets/atm_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BankMasterPage extends StatefulWidget {
  const BankMasterPage({super.key});

  @override
  State<BankMasterPage> createState() => _BankMasterPageState();
}

class _BankMasterPageState extends State<BankMasterPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _selectedCardId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorConstants.primaryBlack),
          onPressed: () {
            context.go("/bottomnavigation/2");
          },
        ),
        title: CustomText(
          data: "Bank Master",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('creditCards').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No banks added yet'));
              }

              return ListView.separated(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final bank = snapshot.data!.docs[index];
                  final data = bank.data() as Map<String, dynamic>;
                  final isSelected = _selectedCardId == bank.id;
                  logDebug(" card image: ${data['cardImage']}");
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            _selectedCardId =
                                _selectedCardId == bank.id ? null : bank.id;
                          });
                        },
                        child: BankCardItem(
                          bankId: bank.id,
                          bankName: bank['bankName'],
                          onEdit:
                              () =>
                                  _editBank(context, bank.id, bank['bankName']),
                          onDelete: () => _deleteBank(bank.id),
                        ),
                      ),
                      if (isSelected)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConstants.height(context) * 0.02,
                            horizontal: SizeConstants.width(context) * 0.05,
                          ),
                          child: AtmCard(
                            atmTheme: data['atmTheme'] ?? "1",
                            bankName: data['bankName'] ?? 'BANK NAME',
                            cardNumber: _formatCardNumber(
                              data['cardNumber'] ?? 'XXXX XXXX XXXX XXXX',
                            ),
                            cardHolderName: data['cardHolderName'] ?? 'Name',
                            expiryDate: data['expiryDate'] ?? 'XX/XX',
                            cvv: data['cvv'] ?? 'XXX',
                            remarks: data['remarks'] ?? 'Remarks',
                            cardImage: data['cardImage'],
                          ),
                        ),
                    ],
                  );
                },
                separatorBuilder:
                    (context, index) =>
                        SizedBox(height: SizeConstants.height(context) * .02),
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
          SizedBox(height: SizeConstants.height(context) * .02),
          AddBankCard(),
        ],
      ),
    );
  }

  Future<void> _editBank(
    BuildContext context,
    String bankId,
    String currentName,
  ) async {
    final doc = await _firestore.collection('creditCards').doc(bankId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => CreditCardMaster(
                isEdit: true,
                creditCardModel: CreditCardModel.fromMap(data, bankId),
              ),
        ),
      );
    }
  }

  Future<void> _deleteBank(String bankId) async {
    await _firestore.collection('creditCards').doc(bankId).delete();

    if (_selectedCardId == bankId) {
      setState(() {
        _selectedCardId = null;
      });
    }
  }

  String _formatCardNumber(String cardNumber) {
    String cleaned = cardNumber.replaceAll(' ', '');

    if (cleaned.length >= 16) {
      return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 8)} '
          '${cleaned.substring(8, 12)} ${cleaned.substring(12, 16)}';
    }

    return cardNumber;
  }
}
