import 'package:card_master/core/constants/image_constants.dart';

class CreditCardModel {
  final String id;
  final String bankName;
  final String address;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final String remarks;
  final String statementGenerationDay;
  final String repaymentFinalDay;
  final String cardBackground;
  final String customCardImage;
  final String atmTheme;

  CreditCardModel({
    required this.id,
    required this.bankName,
    required this.address,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    required this.remarks,
    required this.statementGenerationDay,
    required this.repaymentFinalDay,
    required this.cardBackground,
    required this.customCardImage,
    required this.atmTheme,
  });

  // Create from Firestore document
  factory CreditCardModel.fromMap(Map<String, dynamic> map, String id) {
    return CreditCardModel(
      id: id,
      bankName: map['bankName'] ?? '',
      address: map['address'] ?? '',
      cardNumber: map['cardNumber'] ?? '',
      cardHolderName: map['cardHolderName'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
      cvv: map['cvv'] ?? '',
      remarks: map['remarks'] ?? '',
      statementGenerationDay: map['statementGenerationDay'] ?? '',
      repaymentFinalDay: map['repaymentFinalDay'] ?? '',
      cardBackground: map['cardBackground'] ?? ImageConstants.card1,
      customCardImage: map['customCardImage'] ?? '',
      atmTheme: map['atmTheme']?.toString() ?? '1',
    );
  }

  // Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'bankName': bankName,
      'address': address,
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'remarks': remarks,
      'statementGenerationDay': statementGenerationDay,
      'repaymentFinalDay': repaymentFinalDay,
      'cardBackground': cardBackground,
      'customCardImage': customCardImage,
      'atmTheme': atmTheme,
    };
  }

  // Create empty model
  factory CreditCardModel.empty() {
    return CreditCardModel(
      id: '',
      bankName: '',
      address: '',
      cardNumber: '',
      cardHolderName: '',
      expiryDate: '',
      cvv: '',
      remarks: '',
      statementGenerationDay: '',
      repaymentFinalDay: '',
      cardBackground: ImageConstants.card1,
      customCardImage: '',
      atmTheme: '1',
    );
  }

  // Create copy with updated values
  CreditCardModel copyWith({
    String? id,
    String? bankName,
    String? address,
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    String? cvv,
    String? remarks,
    String? statementGenerationDay,
    String? repaymentFinalDay,
    String? cardBackground,
    String? customCardImage,
    String? atmTheme,
  }) {
    return CreditCardModel(
      id: id ?? this.id,
      bankName: bankName ?? this.bankName,
      address: address ?? this.address,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      remarks: remarks ?? this.remarks,
      statementGenerationDay:
          statementGenerationDay ?? this.statementGenerationDay,
      repaymentFinalDay: repaymentFinalDay ?? this.repaymentFinalDay,
      cardBackground: cardBackground ?? this.cardBackground,
      customCardImage: customCardImage ?? this.customCardImage,
      atmTheme: atmTheme ?? this.atmTheme,
    );
  }
}
