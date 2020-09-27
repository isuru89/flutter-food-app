import 'package:flutter/material.dart';
import 'package:food_app/model/menu_category.dart';

const List<MenuCategory> EMPTY_CATS = [];

class CategoryList extends StatefulWidget {

  final List<MenuCategory> categoryList;

  const CategoryList({Key key, this.categoryList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoryListA(categoryList: categoryList);
  }

}

class _CategoryListA extends State<CategoryList> {

  List<MenuCategory> categoryList;
  String selectedCategoryId;
  final Function(String) onCategoryClicked;

  _CategoryListA({ this.categoryList = EMPTY_CATS, this.selectedCategoryId, this.onCategoryClicked });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categoryList.map((e) => _CategoryItem(
          category: e,
          isSelected: e.id == selectedCategoryId,
          onCategoryClicked: whenCategorySelected,
        ),
        ).toList(),
      ),
    );
  }

  void whenCategorySelected(String id) {
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

  const _CategoryItem({Key key, this.category, this.onCategoryClicked, this.isSelected: false, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    final pkColor = themeData.primaryColor;
    return GestureDetector(
      onTap: () => onCategoryClicked(this.category.id),
      child: Container(
        decoration: BoxDecoration(
            border: isSelected
                ? Border(bottom: BorderSide(color: pkColor, width: 4))
                : Border(bottom: BorderSide(color: Colors.transparent, width: 4))
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                child: Column(
                  children: [
                    Text(category.name, style: themeData.textTheme.headline5),
                  ],
                ),
              ),
            ]
        ),
      ),
    );
  }

}