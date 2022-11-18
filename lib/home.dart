import 'package:based_bml/accounts.dart';
import 'package:based_bml/wallet.dart';
import 'package:based_bml/settings.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int navIdx = 0;
  List<Widget> navItems = const [
    WalletScreen(),
    AccountsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navItems[navIdx],
      bottomNavigationBar: NavigationBar(
        // surfaceTintColor: Theme.of(context).backgroundColor,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: navIdx,
        onDestinationSelected: (value) {
          setState(() {
            navIdx = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.wallet_outlined),
            selectedIcon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.credit_card_outlined),
            selectedIcon: Icon(Icons.credit_card),
            label: 'Accounts',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
