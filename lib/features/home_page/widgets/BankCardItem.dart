import 'package:card_master/core/components/customtext.dart';
import 'package:card_master/core/constants/icon_constants.dart';
import 'package:card_master/core/constants/size_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;

class BankCardItem extends StatelessWidget {
  final String bankId;
  final String bankName;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BankCardItem({
    super.key,
    required this.bankId,
    required this.bankName,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConstants.width(context) * .05,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConstants.width(context) * .05,
          vertical: SizeConstants.height(context) * .01,
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
                CustomText(data: bankName, style: TextStyle(fontSize: 16)),
              ],
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'edit') {
                  onEdit();
                } else if (value == 'delete') {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text('Confirm Delete'),
                          content: Text(
                            'Are you sure you want to delete $bankName?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                onDelete();
                              },
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                  );
                }
              },
              itemBuilder:
                  (BuildContext context) => [
                    PopupMenuItem<String>(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
            ),
          ],
        ),
      ),
    );
  }
}
