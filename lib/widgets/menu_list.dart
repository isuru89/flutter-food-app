import 'package:flutter/material.dart';
import 'package:food_app/model/menu.dart';

class SessionList extends StatefulWidget {

  final List<Menu> menuList;

  const SessionList({Key key, this.menuList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SessionListA(sessionList: menuList);
  }

}

class SessionListA extends State<SessionList> {

  List<Menu> sessionList;
  String selectedMenu;
  Function(String) onMenuSelected;

  SessionListA({ this.sessionList, this.selectedMenu, this.onMenuSelected });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: sessionList.map((e) => _SessionItem(
            session: e,
            isAvailable: e.isAvailable(),
            isSelected: e.name == selectedMenu,
            onMenuSelected: whenMenuIsSelected,
          )).toList(),
      ),
    );
  }

  void whenMenuIsSelected(String name) {
    this.setState(() {
      selectedMenu = name;
    });
    if (onMenuSelected != null) {
      onMenuSelected(name);
    }
  }
}

class _SessionItem extends StatelessWidget {

  final Menu session;
  final bool isSelected;
  final bool isAvailable;
  final Function(String) onMenuSelected;

  const _SessionItem({Key key,
    this.session,
    this.onMenuSelected,
    this.isSelected = false,
    this.isAvailable = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    final pkColor = themeData.primaryColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: isAvailable ? 1 : 0.5,
            child: GestureDetector(
              onTap: () => onMenuSelected(session.name),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: isSelected ? (isAvailable ? pkColor : themeData.disabledColor) : null,
                  border: isAvailable ? Border.all(color: pkColor, width: 2)
                      : Border.all(color: themeData.disabledColor)
                ),
                child: Column(
                  children: [
                    Text(session.name, style: themeData.textTheme.headline4),
                    Text('${session.fromTime}-${session.endTime}', style: themeData.textTheme.subtitle1)
                  ],
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }

}