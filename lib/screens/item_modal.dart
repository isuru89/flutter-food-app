import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/model/routes/item_modal_args.dart';
import 'package:food_app/widgets/icons.dart';
import 'package:smart_select/smart_select.dart';

class ItemModal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ItemModalArguments args = ModalRoute.of(context).settings.arguments;
    var themeData = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 340,
                  child: Hero(
                      tag: args.heroTag ?? "menu-item-" + args.menuItem.id,
                      child: Image.network(args.menuItem.images['lg'], fit: BoxFit.cover,)
                  ),
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: IconUtils.createShadowIcon(
                          Icon(Icons.arrow_back_ios, color: Colors.white),
                          24
                        )
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              transform: Matrix4.translationValues(0, -40, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                    child: Text('${args.menuItem.name}', style: themeData.textTheme.headline3),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Card(
                        elevation: 4,
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(child: Text("\$123.32", style: themeData.textTheme.headline4)),
                            ),
                            VerticalDivider(indent: 8, endIndent: 8),
                            Expanded(
                              child: Center(child: Text("345 cal", style: themeData.textTheme.subtitle1,)),
                            ),
                            VerticalDivider(indent: 8, endIndent: 8),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.timer, size: 16, color: Colors.black54),
                                  SizedBox(width: 8),
                                  Text("20 mins", style: themeData.textTheme.subtitle1),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('In descriptive writing, the author does not just tell the reader what was seen, felt, tested, smelled, or heard. Rather, the author describes something from their own experience and, through careful choice of words and phrasing, makes it seem real. Descriptive writing is vivid, colorful, and detailed.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(height: 1.5),),
                  ),
                  Divider(height: 32,),
                  Column(
                    children: [
                      Text("Add-ons", style: themeData.textTheme.headline4.copyWith(fontSize: 18)),
                      SmartSelect<String>.single(
                        modalType: S2ModalType.bottomSheet,
                        modalHeaderStyle: S2ModalHeaderStyle(
                          textStyle: themeData.textTheme.headline4
                        ),
                        title: "Proteins",
                        value: '',
                        onChange: (state) => print(state),
                        choiceItems: [
                          S2Choice<String>(value: 'ion', title: 'Ionic', subtitle: 'Ionic framework'),
                          S2Choice<String>(value: 'flu', title: 'Flutter'),
                          S2Choice<String>(value: 'rea', title: 'React Native'),
                        ],
                      )
                      ,
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        bottom: true,
        child: Container(
          height: 60,
          color: themeData.primaryColor,
          child: RaisedButton(
            onPressed: () => {

            },
            color: themeData.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.check),
                    SizedBox(width: 8,),
                    Text("Add to Cart", style: themeData.textTheme.headline4)
                  ],
                ),
                Text("\$824.21", style: themeData.textTheme.headline4.copyWith(letterSpacing: 1),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
