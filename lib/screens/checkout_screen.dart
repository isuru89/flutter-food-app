import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/widgets/checkout/payment_section.dart';
import 'package:food_app/widgets/checkout/user_info.dart';

const ButtonNames = {
  1: { 'next': 'Next', 'back': 'Cart' },
  2: { 'next': 'Pay', 'back': 'Back' },
  3: { 'next': 'Next', 'back': 'Back' },
};

class CheckoutPage extends StatefulWidget {
  CheckoutPage({Key key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  PageController _pageController;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: [],
                automaticallyImplyLeading: false,
                expandedHeight: 32,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: SafeArea(bottom: false, child: Text('General Info')),
                ),
              ),
              SliverToBoxAdapter(
                child: CheckoutUserInfo(),
              )
            ],
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: [],
                automaticallyImplyLeading: false,
                expandedHeight: 32,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: SafeArea(bottom: false, child: Text('Payment')),
                ),
              ),
              SliverToBoxAdapter(
                child: CheckoutPaymentSection(),
              )
            ],
          ),
          Container(child: Text('ccc'))
        ],
      ),
      bottomNavigationBar: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: kDoublePadding),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Flexible(
              child: FlatButton(
                  onPressed: () {
                    _pageController.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                    this.setState(() {
                      currentPage--;
                    });
                  },
                  child: Text(ButtonNames[currentPage]['back']))),
          Flexible(
              child: RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
              this.setState(() {
                currentPage++;
              });
            },
            child: Text(ButtonNames[currentPage]['next']),
            shape: StadiumBorder(),
          ))
        ]),
      ),
    );
  }
}
