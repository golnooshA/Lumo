import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore, QuerySnapshot;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/user_avatar_picker.dart';
import 'login_page.dart';

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
                FirebaseAuth.instance.currentUser?.email ?? 'User',
                style: TextStyle(
                  color: DesignConfig.textColor,
                  fontSize: DesignConfig.headerSize,
                ),
              ),
            ),
            const SizedBox(height: 50),
            InkWell(
              onTap: () => _showChangePasswordSheet(context),
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
              onTap: () => _confirmDeleteAccount(context),
              child: Text(
                'Delete Account',
                style: TextStyle(
                  color: DesignConfig.deleteCart,
                  fontSize: DesignConfig.textSize,
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                );
              },
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

  void _showChangePasswordSheet(BuildContext context) {
    final newPasswordController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Change Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final newPassword = newPasswordController.text.trim();
                  if (newPassword.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                          Text('Password must be at least 6 characters')),
                    );
                    return;
                  }
                  try {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await user.updatePassword(newPassword);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Password updated successfully')),
                      );
                    }
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message ?? 'Error')),
                    );
                  }
                },
                child: const Text('Save'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _confirmDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content:
          const Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                try {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) await user.delete();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const LoginPage()),
                        (route) => false,
                  );
                } on FirebaseAuthException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? 'Error')),
                  );
                }
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
