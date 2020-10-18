import 'package:flutter/material.dart';
import 'package:food_app/widgets/checkout/user_info.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({Key key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  PageController _pageController;

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
      body: SafeArea(
        child: PageView(
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
                    title: Text('General Info'),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CheckoutUserInfo(),
                )
              ],
            ),
            Container(child: Text('bbb')),
            Container(child: Text('ccc'))
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 64,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Flexible(
              child: FlatButton(
                  onPressed: () {
                    _pageController.previousPage(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.easeInOut);
                  },
                  child: Text('Cancel'))),
          Flexible(
              child: RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () => _pageController.nextPage(
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut),
            child: Text('Next'),
          ))
        ]),
      ),
    );
  }
}
