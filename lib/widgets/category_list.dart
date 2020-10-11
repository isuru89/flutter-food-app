import 'package:flutter/material.dart';
import 'package:food_app/model/menu.dart';

import 'package:food_app/constants.dart';

const List<MenuCategory> EMPTY_CATS = [];

class CategoryList extends StatefulWidget {

  final List<MenuCategory> categoryList;

  const CategoryList({Key key, this.categoryList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoryListState(categoryList: categoryList, selectedCategoryId: categoryList[0].id);
  }

}

class _CategoryListState extends State<CategoryList> {

  List<MenuCategory> categoryList;
  String selectedCategoryId;
  final Function(String) onCategoryClicked;

  _CategoryListState({ this.categoryList, this.selectedCategoryId, this.onCategoryClicked });


  @override
  void initState() {
    super.initState();
    if (this.selectedCategoryId != null) {
      this.selectedCategoryId = categoryList[0].id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categoryList.map((e) => _CategoryItem(
          category: e,
          isSelected: e.id == selectedCategoryId,
          onCategoryClicked: _whenCategorySelected,
        ),
        ).toList(),
      ),
    );
  }

  void _whenCategorySelected(String id) {
    print(id);
    this.setState(() {
      selectedCategoryId = id;
    });
  }

}

class _CategoryItem extends StatelessWidget {

  final MenuCategory category;
  final bool isSelected;
  final Function(String) onCategoryClicked;

  const _CategoryItem({Key key,
    this.category,
    this.onCategoryClicked,
    this.isSelected: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    final pkColor = themeData.primaryColor;
    var fontStyle = isSelected
        ? themeData.textTheme.headline5.copyWith(fontWeight: FontWeight.w500)
        : themeData.textTheme.headline5.copyWith(fontWeight: FontWeight.w300);
    return InkWell(
      onTap: () => onCategoryClicked(this.category.id),
      child: Container(
        decoration: BoxDecoration(
            border: isSelected
                ? Border(bottom: BorderSide(color: pkColor, width: kCategorySelectedStrokeWidth))
                : Border(bottom: BorderSide(color: Colors.transparent, width: kCategorySelectedStrokeWidth))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kPadding / 2,
              horizontal: kPadding
          ),
          child: Center(child: Text(category.name, style: fontStyle)),
        ),
      ),
    );
  }

}