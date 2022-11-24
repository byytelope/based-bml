import 'package:based_bml/util/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class CardOptionsScreen extends StatefulWidget {
  const CardOptionsScreen({super.key, this.currentCardIdx = 0});
  final int currentCardIdx;

  @override
  State<CardOptionsScreen> createState() => _CardOptionsScreenState();
}

class _CardOptionsScreenState extends State<CardOptionsScreen>
    with TickerProviderStateMixin {
  bool freezeCard = false;
  bool defaultCard = true;
  double balance = 2100.00;
  String cardNumber = '4213123412341297';
  final formatCurrency = NumberFormat.simpleCurrency(name: 'MVR');
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward();
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutQuad,
    );
    super.initState();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Widget _bankCard() {
    return Hero(
      transitionOnUserGestures: true,
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
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Fira Code',
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          height: 0,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        formatCurrency
                            .format(balance)
                            .replaceAll(formatCurrency.currencySymbol, ''),
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Fira Code',
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'DEBIT',
                    style: TextStyle(
                      fontFamily: 'Fira Code',
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      Helpers.parseCardNum(cardNumber),
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontFamily: 'Fira Code',
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          '9/23',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontFamily: 'Fira Code',
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 40),
                        child: SvgPicture.asset(
                          alignment: Alignment.bottomRight,
                          'assets/visa_logo.svg',
                          // 'assets/mastercard_logo.svg',
                          width: 60,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.password_outlined),
                  SizedBox(width: 8),
                  Text('Change pin'),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.block_outlined),
                  SizedBox(width: 8),
                  Text('Block card'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        ListTile(
          isThreeLine: true,
          onTap: () {
            setState(() {
              defaultCard = !defaultCard;
            });
          },
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
            activeColor: Theme.of(context).colorScheme.primary,
            value: defaultCard,
            onChanged: (value) {
              setState(() {
                defaultCard = value;
              });
            },
          ),
        ),
        ListTile(
          onTap: () {
            setState(() {
              freezeCard = !freezeCard;
            });
          },
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
            activeColor: Theme.of(context).colorScheme.primary,
            value: freezeCard,
            onChanged: (value) {
              setState(() {
                freezeCard = value;
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
          icon: Icon(Icons.adaptive.arrow_back_outlined),
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
            ],
          ),
        ),
      ),
    );
  }
}
