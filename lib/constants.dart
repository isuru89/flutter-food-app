import 'package:flutter/material.dart';
import 'package:delizious/model/view/bottom_panel.dart';

// theme related data
const kPrimaryColor = Colors.red;
const kOnPrimaryColor = Colors.white;
const kAccentColor = Colors.blue;
const kErrorColor = Colors.grey;


const double kPadding = 8;
const double kDoublePadding = 16;

// Restaurant header related configs
const double kRestaurantHeaderHeight = 280;
const double kRestaurantHeaderMinHeight = 80;
const double kRestaurantHeaderLogoMaxSize = 96;
const double kRestaurantHeaderLogoMinSize = 48;
const bool kRestaurantHeaderShowLogo = false;
const bool kRestaurantHeaderTransparentLogo = false;
const Color kRestaurantHeaderLogoColor = Colors.white;
const double kRestaurantHeaderFontSize = 22;


// Menu Sessions and category bar
const double kSessionBarHeight = 130;
const double kSessionAvailableStrokeWidth = 2;
const double kMenuSessionDisabledOpacity = 0.3;
const double kCategorySelectedStrokeWidth = 4;

// Featured items section
const double kFeaturedItemContainerHeight = 230;
const double kFeaturedItemImageWidth = 150;
const double kFeaturedItemImageHeight = 150;

// Menu Item related configs
const double kMenuItemHeight = 140;
const double kMenuItemCardElevation = 0;
const double kMenuItemImageSize = 124;

// item modal related configs
const double kItemModalHeroImageMaxHeight = 280;
const double kItemModalHeroImageMinHeight = 100;
const double kItemModalBottomPanelHeight = 60;

// bottom panel items
final List<BottomPanelItem> kBottomPanelItems = [
  BottomPanelItem('Home', '/home', Icons.home_outlined),
  BottomPanelItem('History', '/history', Icons.history),
  BottomPanelItem('Favourites', '/favourites', Icons.favorite_outline),
  BottomPanelItem('Account', '/account', Icons.account_circle_outlined),
];