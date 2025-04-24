import 'dart:io';
import 'package:card_master/features/home_page/data/model/credit_card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreditCardRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> addCreditCard({
    required CreditCardModel card,
    File? imageFile,
  }) async {
    try {
      // Upload image if exists
      String? imageUrl;
      if (imageFile != null) {
        final ref = _storage.ref().child('card_images/${card.id}');
        await ref.putFile(imageFile);
        imageUrl = await ref.getDownloadURL();
      }

      // Add card data to Firestore
      final cardData = card.toMap();
      if (imageUrl != null) {
        cardData['imagePath'] = imageUrl;
      }

      await _firestore.collection('creditCards').doc(card.id).set(cardData);

      return 'Card added successfully';
    } catch (e) {
      throw Exception('Failed to add card: $e');
    }
  }

  // Add other CRUD operations as needed
}
