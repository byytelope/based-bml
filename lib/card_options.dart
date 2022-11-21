import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CardOptionsScreen extends StatefulWidget {
  const CardOptionsScreen({super.key, this.currentCardIdx = 0});
  final int currentCardIdx;

  @override
  State<CardOptionsScreen> createState() => _CardOptionsScreenState();
}

class _CardOptionsScreenState extends State<CardOptionsScreen> {
  bool freezeCard = false;
  bool defaultCard = true;
  double balance = 2100.00;
  String cardNumber = '4213123412341297';
  final formatCurrency = NumberFormat.simpleCurrency(name: 'MVR');

  Widget _bankCard() {
    return Hero(
      tag: 'BankCard${widget.currentCardIdx}',
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 230,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        formatCurrency.currencySymbol,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 0,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        formatCurrency
                            .format(balance)
                            .replaceAll(formatCurrency.currencySymbol, ''),
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'DEBIT',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        '**** ${cardNumber.substring(cardNumber.length - 4)} | 9/23',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Fira Code',
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/visa_logo.svg',
                    // 'assets/mastercard_logo.svg',
                    width: 60,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Tooltip(
              message: 'Pay',
              child: OutlinedButton(
                onPressed: () {},
                child: const Icon(Icons.send_outlined),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Tooltip(
              message: 'Change pin',
              child: OutlinedButton(
                onPressed: () {},
                child: const Icon(Icons.password_outlined),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Tooltip(
              message: 'Block',
              child: OutlinedButton(
                onPressed: () {},
                child: const Icon(Icons.block_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list() {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          onTap: () {},
          iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.ac_unit_outlined),
            ],
          ),
          title: const Text('Freeze'),
          subtitle: const Text('Tap to freeze or unfreeze your card'),
          trailing: Switch.adaptive(
            activeColor: Theme.of(context).primaryColor,
            value: freezeCard,
            onChanged: (value) {
              setState(() {
                freezeCard = value;
              });
            },
          ),
        ),
        ListTile(
          isThreeLine: true,
          onTap: () {},
          iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.credit_card_outlined),
            ],
          ),
          title: const Text('Default Card'),
          subtitle: const Text('Use this card to make payments by default'),
          trailing: Switch.adaptive(
            activeColor: Theme.of(context).primaryColor,
            value: defaultCard,
            onChanged: (value) {
              setState(() {
                defaultCard = value;
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Options'),
        leading: IconButton(
          icon: Icon(Icons.adaptive.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _bankCard(),
              _buttons(),
              const SizedBox(height: 16),
              _list(),
              const SizedBox(height: 2000),
            ],
          ),
        ),
      ),
    );
  }
}
