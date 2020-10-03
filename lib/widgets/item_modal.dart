import 'package:flutter/material.dart';
import 'package:food_app/model/routes/item_modal_args.dart';

class ItemModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemModalArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 340,
            child: Hero(
                tag: "menux-item-" + args.menuItem.id,
                child: Image.network(args.menuItem.images['lg'], fit: BoxFit.cover,)
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              transform: Matrix4.translationValues(0, -40, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: FlatButton(
                child: Text("Go Back"),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          )
        ],
      ),
    );
  }

}