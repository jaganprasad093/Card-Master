import 'package:card_master/core/components/customtext.dart';
import 'package:card_master/core/constants/icon_constants.dart';
import 'package:card_master/core/constants/size_constants.dart';
import 'package:card_master/features/home_page/presentation/pages/credit_card_master.dart';
import 'package:flutter/material.dart';

class AddBankCard extends StatelessWidget {
  const AddBankCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConstants.width(context) * .05,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreditCardMaster()),
          );
        },

        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstants.width(context) * .05,
            vertical: SizeConstants.height(context) * .02,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: SizeConstants.height(context) * .027,
                    child: Image.asset(IconConstants.bank),
                  ),
                  SizedBox(width: SizeConstants.width(context) * .04),
                  CustomText(data: "Add Bank", style: TextStyle(fontSize: 16)),
                ],
              ),
              Icon(Icons.add, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}
