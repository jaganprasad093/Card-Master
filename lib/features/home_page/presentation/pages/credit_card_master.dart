import 'dart:developer';

import 'package:card_master/core/constants/image_constants.dart';
import 'package:card_master/core/constants/log_constanst.dart';
import 'package:card_master/features/home_page/data/model/credit_card_model.dart';
import 'package:card_master/features/home_page/services/card_services.dart';
import 'package:card_master/features/home_page/widgets/add_bank_card.dart';
import 'package:card_master/features/home_page/widgets/buildTextField.dart';
import 'package:card_master/features/home_page/widgets/image_pick_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:card_master/core/components/custom_dropdown_list.dart';
import 'package:card_master/core/components/CustomButton.dart';
import 'package:card_master/core/components/custom_textformfield.dart';
import 'package:card_master/core/components/customtext.dart';
import 'package:card_master/core/constants/color_constants.dart';
import 'package:card_master/core/constants/icon_constants.dart';
import 'package:card_master/core/constants/size_constants.dart';
import 'package:card_master/features/home_page/widgets/atm_card.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreditCardMaster extends StatefulWidget {
  final bool? isEdit;
  final CreditCardModel? creditCardModel;
  const CreditCardMaster({super.key, this.isEdit, this.creditCardModel});

  @override
  State<CreditCardMaster> createState() => _CreditCardMasterState();
}

class _CreditCardMasterState extends State<CreditCardMaster> {
  final TextEditingController bankController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController accountRemarksController =
      TextEditingController();
  final TextEditingController statementGenerationDayController =
      TextEditingController();
  final TextEditingController repaymentFinalDayController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final List<String> banks = [
    'State Bank of India',
    'HDFC Bank',
    'ICICI Bank',
    'Axis Bank',
    'Kotak Mahindra Bank',
    'Punjab National Bank',
  ];

  String selectedBackground = ImageConstants.card1;
  File? selectedImage;
  String? selectedBank;
  @override
  void initState() {
    super.initState();

    // Pre-fill the form if in edit mode
    if (widget.isEdit == true && widget.creditCardModel != null) {
      final model = widget.creditCardModel!;
      bankController.text = model.bankName;
      addressController.text = model.address;
      cardNumberController.text = model.cardNumber;
      cardHolderNameController.text = model.cardHolderName;
      expiryDateController.text = model.expiryDate;
      cvvController.text = model.cvv;
      accountRemarksController.text = model.remarks;
      statementGenerationDayController.text = model.statementGenerationDay;
      repaymentFinalDayController.text = model.repaymentFinalDay;
      selectedBackground = model.cardBackground;
      selectedCardNumber = int.tryParse(model.atmTheme) ?? 1;
      selectedBank = model.bankName;
      if (model.customCardImage.isNotEmpty) {
        selectedImage = File(model.customCardImage);
      }
    }

    bankController.addListener(_updateCard);
    cardNumberController.addListener(_updateCard);
    cardHolderNameController.addListener(_updateCard);
    expiryDateController.addListener(_updateCard);
    cvvController.addListener(_updateCard);
    accountRemarksController.addListener(_updateCard);
  }

  @override
  void dispose() {
    bankController.dispose();
    addressController.dispose();
    cardNumberController.dispose();
    cardHolderNameController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    accountRemarksController.dispose();
    statementGenerationDayController.dispose();
    repaymentFinalDayController.dispose();
    super.dispose();
  }

  void _updateCard() {
    setState(() {});
  }

  int selectedCardNumber = 1;

  void _changeBackground(String newBackground) {
    setState(() {
      selectedBackground = newBackground;
      final fileName = newBackground.split('/').last;
      final numberString = fileName
          .replaceAll('card', '')
          .replaceAll('.jpg', '');
      selectedCardNumber = int.tryParse(numberString) ?? 1;
      log("Selected card number: $selectedCardNumber");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        title: const CustomText(
          data: "Credit Card Master",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConstants.width(context) * 0.04,
          vertical: SizeConstants.height(context) * 0.02,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomDropdown(
                value: selectedBank,
                hintText: "Select Bank",
                items: banks,
                prefix: Padding(
                  padding: EdgeInsets.only(
                    right: SizeConstants.width(context) * 0.03,
                  ),
                  child: Icon(
                    Icons.account_balance,
                    size: 25,
                    color: ColorConstants.buttonColor,
                  ),
                ),
                onChanged: (value) {
                  selectedBank = value;
                  bankController.text = value ?? "";
                },
              ),
              SizedBox(height: SizeConstants.height(context) * 0.02),

              BuildTextField(
                controller: addressController,
                hintText: "Enter Address",
                iconAsset: IconConstants.curreney,
              ),

              BuildTextField(
                controller: cardNumberController,
                hintText: "Enter Credit Card Number",
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
                maxLength: 19,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CardNumberFormatter(),
                ],
              ),

              BuildTextField(
                controller: cardHolderNameController,
                hintText: "Enter Card Holder Name",
                icon: Icons.account_circle_outlined,
              ),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: BuildTextField(
                      controller: expiryDateController,
                      hintText: "Expiry Date (MM/YY)",
                      icon: Icons.calendar_month_outlined,
                      maxLength: 5,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        ExpiryDateFormatter(),
                      ],
                    ),
                  ),
                  SizedBox(width: SizeConstants.width(context) * 0.03),
                  Expanded(
                    child: BuildTextField(
                      controller: cvvController,
                      hintText: "CVV",
                      icon: Icons.password,
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      obscureText: true,
                    ),
                  ),
                ],
              ),

              BuildTextField(
                controller: accountRemarksController,
                hintText: "Account Remarks",
                icon: Icons.comment_outlined,
              ),

              BuildTextField(
                controller: statementGenerationDayController,
                hintText: "Statement Generation Day",
                icon: Icons.assignment_outlined,
              ),

              BuildTextField(
                controller: repaymentFinalDayController,
                hintText: "Repayment Final Day",
                icon: Icons.calendar_month_rounded,
              ),

              // SizedBox(height: SizeConstants.height(context) * 0.002),
              ImagePickCard(
                onImagePicked: (path) {
                  setState(() {
                    selectedImage = path;
                  });
                },
              ),

              SizedBox(height: SizeConstants.height(context) * 0.02),

              AtmCard(
                cardImage: selectedBackground,
                bankName:
                    bankController.text.isNotEmpty
                        ? bankController.text
                        : "BANK NAME",
                cardNumber: CardServices.formatCardNumber(
                  cardNumberController.text,
                ),
                cardHolderName:
                    cardHolderNameController.text.isNotEmpty
                        ? cardHolderNameController.text
                        : "Name",
                expiryDate:
                    expiryDateController.text.isNotEmpty
                        ? CardServices.formatExpiryDate(
                          expiryDateController.text,
                        )
                        : "XX/XX",
                cvv: cvvController.text.isNotEmpty ? cvvController.text : "XXX",
                remarks:
                    accountRemarksController.text.isNotEmpty
                        ? accountRemarksController.text
                        : "Remarks",
              ),
              // SizedBox(height: SizeConstants.height(context) * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBackgroundOption(ImageConstants.card1),
                  _buildBackgroundOption(ImageConstants.card2),
                  _buildBackgroundOption(ImageConstants.card3),
                  _buildBackgroundOption(ImageConstants.card4),
                ],
              ),

              SizedBox(height: SizeConstants.height(context) * 0.02),

              CustomButton(
                text: widget.isEdit == true ? "Update" : "Add Card",
                onTap: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    try {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder:
                            (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                      );

                      Map<String, dynamic> cardData = {
                        'bankName': bankController.text,
                        'address': addressController.text,
                        'cardNumber': cardNumberController.text.replaceAll(
                          ' ',
                          '',
                        ),
                        'cardHolderName': cardHolderNameController.text,
                        'expiryDate': expiryDateController.text,
                        'cvv': cvvController.text,
                        'remarks': accountRemarksController.text,
                        'statementGenerationDay':
                            statementGenerationDayController.text,
                        'repaymentFinalDay': repaymentFinalDayController.text,
                        'cardBackground': selectedBackground,
                        'customCardImage': selectedImage?.path ?? '',
                        'updatedAt': FieldValue.serverTimestamp(),
                        "atmTheme": selectedCardNumber.toString(),
                      };

                      // Either update or add new document
                      if (widget.isEdit == true &&
                          widget.creditCardModel != null) {
                        await FirebaseFirestore.instance
                            .collection('creditCards')
                            .doc(widget.creditCardModel!.id)
                            .update(cardData);
                      } else {
                        cardData['createdAt'] = FieldValue.serverTimestamp();
                        await FirebaseFirestore.instance
                            .collection('creditCards')
                            .add(cardData);
                      }

                      if (!mounted) return;
                      Navigator.pop(context);

                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            widget.isEdit == true
                                ? 'Card updated successfully!'
                                : 'Card added successfully!',
                          ),
                        ),
                      );

                      if (!mounted) return;
                      context.go("/bankmaster");
                    } catch (e) {
                      if (!mounted) return;
                      Navigator.pop(context);
                      logDebug("Error: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    }
                  }
                },
              ),
              SizedBox(height: SizeConstants.height(context) * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundOption(String imagePath) {
    final bool isSelected = selectedBackground == imagePath;
    return GestureDetector(
      onTap: () => _changeBackground(imagePath),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border:
                isSelected
                    ? Border.all(color: ColorConstants.buttonColor, width: 2)
                    : null,
          ),
          child: CircleAvatar(
            radius: 18,
            backgroundColor:
                isSelected
                    ? ColorConstants.buttonColor.withValues(alpha: .3)
                    : ColorConstants.buttonColor.withValues(alpha: 0.1),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(imagePath),
            ),
          ),
        ),
      ),
    );
  }
}
