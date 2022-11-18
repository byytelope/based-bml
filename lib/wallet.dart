import 'package:based_bml/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double balance = 2100.00;
  int currentCardIdx = 0;
  String cardNumber = '4213123412341297';
  final cardCount = 3;
  final formatCurrency = NumberFormat.simpleCurrency(name: 'MVR');
  late PageController cardPageController;

  @override
  void initState() {
    super.initState();
    cardPageController = PageController(
      initialPage: currentCardIdx,
      viewportFraction: 0.85,
    );
  }

  @override
  void dispose() {
    super.dispose();
    cardPageController.dispose();
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: ColorConstants.bmlRed,
              borderRadius: BorderRadius.circular(4),
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/bml_logo.png'),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  height: 0,
                ),
              ),
              const Text(
                'Shadhaan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bankCard() {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatCurrency.currencySymbol,
                      style: const TextStyle(
                        fontSize: 18,
                        height: 0,
                      ),
                    ),
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
                const Text(
                  'DEBIT',
                  style: TextStyle(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  'assets/mastercard_logo.svg',
                  width: 60,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardCarousel() {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.8,
          child: PageView.builder(
            controller: cardPageController,
            onPageChanged: ((value) {
              setState(() {
                currentCardIdx = value;
              });
            }),
            itemCount: cardCount,
            itemBuilder: ((context, index) {
              return _bankCard();
            }),
          ),
        ),
        const SizedBox(height: 8),
        _pageIndicators(),
      ],
    );
  }

  Widget _pageIndicator(bool isActive) {
    return Container(
      height: 8,
      width: 8,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).brightness == Brightness.light
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onPrimary,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _pageIndicators() {
    List<Widget> indicators = [];
    for (var i = 0; i < cardCount; i++) {
      indicators.add(_pageIndicator(i == currentCardIdx));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              const SizedBox(height: 56),
              _cardCarousel(),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Transfer'),
        icon: const Icon(Icons.send_outlined),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
