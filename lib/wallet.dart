import 'package:based_bml/card_options.dart';
import 'package:based_bml/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with TickerProviderStateMixin {
  bool isExtended = true;
  double balance = 2100.00;
  int currentCardIdx = 0;
  String cardNumber = '4213123412341297';
  final cardCount = 3;
  final formatCurrency = NumberFormat.simpleCurrency(name: 'MVR');
  late PageController _cardPageController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _cardPageController = PageController(
      initialPage: currentCardIdx,
      viewportFraction: 1,
    );
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      const delta = 10;
      if (maxScroll - currentScroll <= delta || currentScroll <= delta) {
        setState(() {
          isExtended = true;
        });
      } else {
        setState(() {
          isExtended = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cardPageController.dispose();
    _scrollController.dispose();
  }

  Widget _header(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 4),
              Text(
                'Welcome Back',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              const Text(
                'Shadhaan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bankCard(int index) {
    bool selected = index == currentCardIdx;

    return Hero(
      tag: 'BankCard$index',
      transitionOnUserGestures: true,
      child: Card(
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: selected
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.surfaceVariant,
          ),
          duration: const Duration(milliseconds: 200),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              splashColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
              onTap: selected
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              CardOptionsScreen(currentCardIdx: currentCardIdx),
                        ),
                      );
                    }
                  : () => _cardPageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOutCirc,
                      ),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              formatCurrency.currencySymbol,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Fira Code',
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                height: 0,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              formatCurrency.format(balance).replaceAll(
                                    formatCurrency.currencySymbol,
                                    '',
                                  ),
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Fira Code',
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
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
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
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
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontFamily: 'Fira Code',
                              ),
                            ),
                          ],
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 40),
                          child: SvgPicture.asset(
                            'assets/visa_logo.svg',
                            // 'assets/mastercard_logo.svg',
                            alignment: Alignment.bottomRight,
                            width: 60,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 262,
          child: PageView.builder(
            controller: _cardPageController,
            padEnds: false,
            onPageChanged: ((value) {
              setState(() {
                currentCardIdx = value;
              });
            }),
            itemCount: cardCount,
            itemBuilder: (context, index) => _bankCard(index),
          ),
        ),
        const SizedBox(height: 8),
        _pageIndicators(),
      ],
    );
  }

  Widget _pageIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutQuad,
      height: 8,
      width: 8,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isActive
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.surfaceVariant,
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
                  Icon(Icons.qr_code_scanner_outlined),
                  SizedBox(width: 8),
                  Text('Scan QR'),
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
                  Icon(Icons.send_outlined),
                  SizedBox(width: 8),
                  Text('Send'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context),
                _cardCarousel(),
                const SizedBox(height: 16),
                _buttons(),
                const SizedBox(height: 2000),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
