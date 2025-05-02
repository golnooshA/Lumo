import 'package:cloud_firestore/cloud_firestore.dart'
    show FirebaseFirestore, QuerySnapshot;
import 'package:flutter/material.dart';
import 'package:lumo/screen/login_page.dart';
import '../design/design_config.dart';
import '../widget/bottom_navigation.dart';
import '../widget/user_avatar_picker.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Stream<QuerySnapshot> get bookStream =>
      FirebaseFirestore.instance.collection('books').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignConfig.appBarBackgroundColor,
        centerTitle: true,
        title: Text(
          'Account',
          style: TextStyle(
            color: DesignConfig.appBarTitleColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: DesignConfig.appBarTitleFontSize,
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 4),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: UserAvatarPicker(radius: 60)),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'UserName',
                style: TextStyle(
                  color: DesignConfig.textColor,
                  fontSize: DesignConfig.headerSize,
                ),
              ),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: (){},
              child: Text(
                'Change password',
                style: TextStyle(
                  color: DesignConfig.textColor,
                  fontSize: DesignConfig.textSize,
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
              ),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: DesignConfig.addCart,
                  fontSize: DesignConfig.textSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
