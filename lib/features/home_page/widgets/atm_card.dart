import 'package:card_master/core/components/customtext.dart';
import 'package:card_master/core/constants/color_constants.dart';
import 'package:card_master/core/constants/image_constants.dart';
import 'package:card_master/core/constants/size_constants.dart';
import 'package:flutter/material.dart';

class AtmCard extends StatelessWidget {
  final String bankName;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final String remarks;
  final String? cardImage;

  const AtmCard({
    super.key,
    this.cardImage,
    this.bankName = "BANK NAME",
    this.cardNumber = "XXXX XXXX XXXX XXXX",
    this.cardHolderName = "Name",
    this.expiryDate = "XX/XX",
    this.cvv = "XXX",
    this.remarks = "Remarks",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConstants.height(context) * 0.18,
      width: SizeConstants.width(context) * .7,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConstants.width(context) * 0.05,
        vertical: SizeConstants.height(context) * 0.021,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(cardImage ?? ImageConstants.card1),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                data: bankName,
                style: TextStyle(
                  color: ColorConstants.primaryWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              CustomText(
                data: remarks,
                style: TextStyle(
                  color: ColorConstants.primaryWhite,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          Text(
            cardNumber,
            style: TextStyle(
              color: ColorConstants.primaryWhite,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    data: "Card Holder",
                    style: TextStyle(
                      color: ColorConstants.primaryWhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  CustomText(
                    data: cardHolderName,
                    style: TextStyle(
                      color: ColorConstants.primaryWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: "Expiry",
                        style: TextStyle(
                          color: ColorConstants.primaryWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        expiryDate,
                        style: TextStyle(
                          color: ColorConstants.primaryWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: SizeConstants.width(context) * .05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: "CVV",
                        style: TextStyle(
                          color: ColorConstants.primaryWhite,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        cvv,
                        style: TextStyle(
                          color: ColorConstants.primaryWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
