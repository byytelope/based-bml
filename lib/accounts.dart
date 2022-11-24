import 'package:flutter/material.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              ListTile(
                title: Text('Bruh'),
              ),
              SizedBox(height: 2000),
            ],
          ),
        ),
      ),
    );
  }
}
