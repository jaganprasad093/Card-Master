import 'package:card_master/core/components/customtext.dart';
import 'package:card_master/core/constants/color_constants.dart';
import 'package:card_master/core/constants/log_constanst.dart';
import 'package:card_master/core/constants/size_constants.dart';
import 'package:card_master/features/home_page/presentation/pages/bank_master_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomText(
          data: "Masters",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          SizedBox(height: SizeConstants.height(context) * .05),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConstants.width(context) * .11,
            ),
            child: InkWell(
              onTap: () {
                // logDebug("Bank Master");

                // context.push("/bankmaster");

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BankMasterPage()),
                );
              },
              child: Container(
                height: SizeConstants.height(context) * .12,

                // width: SizeConstants.width(context) * 7,
                decoration: BoxDecoration(
                  color: ColorConstants.primaryWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: CustomText(
                    data: "Bank Accounts",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
