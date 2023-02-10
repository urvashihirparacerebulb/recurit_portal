import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/general_controller.dart';
import '../theme/convert_theme_colors.dart';
import '../utility/color_utility.dart';
import '../utility/common_methods.dart';
import '../utility/constants.dart';
import '../utility/screen_utility.dart';
import '../utility/theme_utils.dart';


BorderRadius commonBorderRadius = BorderRadius.circular(12.0);
BorderRadius commonButtonBorderRadius = BorderRadius.circular(10.0);

BoxDecoration neurmorphicBoxDecoration = BoxDecoration(
  boxShadow: GeneralController.to.isDarkMode.value ? [
    BoxShadow(
      color: Colors.white.withOpacity(0.1),
      offset: const Offset(-5.0, -6.0),
      blurRadius: 16.0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.4),
      offset: const Offset(6.0, 6.0),
      blurRadius: 16.0,
    ),
  ] : [
    BoxShadow(
      color: Colors.white.withOpacity(0.8),
      offset: const Offset(-5.0, -6.0),
      blurRadius: 16.0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(6.0, 6.0),
      blurRadius: 16.0,
    ),
  ],
  color: ConvertTheme.convertTheme.getBackGroundColor(),
  borderRadius: BorderRadius.circular(12.0),
);

Widget commonStructure({
  required BuildContext context,
  required Widget child,
  PreferredSize? appBar,
  Color bgColor = whiteColor,
  Widget? bottomNavigation,
  Widget? floatingAction,
}) {
  ///Pass null in appbar when it's optional ex = appBar : null
  return Stack(
    children: [
      commonAppBackground(),
      Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        appBar: appBar,
        bottomNavigationBar: bottomNavigation,
        floatingActionButton: floatingAction,
        ///adding listView cause scroll issue
        body: Container(
          height: getScreenHeight(context),
          color: Colors.transparent,
          child: child,
        ),
      ),
    ],
  );
}

Widget commonAppBackground() {
  return Obx(() {
    return Container(
      decoration: BoxDecoration(
        color: ConvertTheme.convertTheme.getBackGroundColor(),
      ),
    );
  });
}


PreferredSize commonSearchAppBar({BuildContext? context,
  Widget? leadingWidget, String? title, Widget? actionIcon}) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(56.0),
      child: Obx(() {
        return AppBar(
          centerTitle: true,
          // this is all you need
          backgroundColor: whiteColor,
          // or use Brightness.dark
          leading: leadingWidget!,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Text(
            isNotEmptyString(title) ? title! : GeneralController.to.dashBoardTitle.value,
            textAlign: TextAlign.center,
            style: black18PxBold,
          ),
          actions: [actionIcon ?? Container()],
        );
      }));
}

commonHeaderTitle({String title = "",
  double height = 1.0,
  double fontSize = 1,int fontWeight = 0,
  Color color = whiteColor,
  bool isChangeColor = false,
  TextAlign align = TextAlign.start,
  FontStyle fontStyle = FontStyle.normal}){
  return Text(
    title,
    style: white14PxNormal
        .apply(
        color: isChangeColor ? color : ConvertTheme.convertTheme.getWhiteToFontColor(),
        fontStyle: fontStyle,
        fontSizeFactor: fontSize,
        fontFamily: "Poppins",
        fontWeightDelta: fontWeight)
        .merge(TextStyle(height: height)),
    textAlign: align,
  );
}

void commonBottomView(
    {BuildContext? context,
      Widget? child}) {
  showModalBottomSheet(
      context: context!,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: ConvertTheme.convertTheme.getBackGroundColor(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (builder) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: child
          ),
        );
        // return FractionallySizedBox(
        //   heightFactor: 0.92,
        //   child:,
        // );
      });
}

Widget commonBorderButtonView(
    {required BuildContext context,
      required String title,
      required Function tapOnButton,
      required bool isLoading,
      Color? color,
      double height = 50,
      IconData? iconData}) {
  return Container(
    decoration: neurmorphicBoxDecoration,
    width: MediaQuery.of(context).size.width - (commonHorizontalPadding * 2),
    height: height,
    child: ElevatedButton(
      onPressed: () {
        if (!isLoading) {
          tapOnButton();
        }
      },
      style: ElevatedButton.styleFrom(
        // shadowColor: blackColor.withOpacity(0.8),
        alignment: Alignment.center,
        primary: ConvertTheme.convertTheme.getBackGroundColor(),
        // side: const BorderSide(
        //   color: blackColor,
        //   width: 1.0,
        // ),
        shape: RoundedRectangleBorder(
          borderRadius: commonBorderRadius,
        ),
        padding: EdgeInsets.symmetric(vertical: height == 50.0 ? 15 : 2),
        elevation: 0.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: black15PxW800.copyWith(
                color: blackColor,
                fontWeight: FontWeight.bold,
                fontSize: height >= 50.0 ? 16 : 12),
          ),
          iconData != null ? commonHorizontalSpacing() : const SizedBox(),
          iconData != null
              ? Icon(
            iconData,
            size: 20,
            color: blackColor,
          )
              : const SizedBox(),
        ],
      ),
    ),
  );
}

Widget commonFillButtonView(
    {required BuildContext context,
      required String title,
      required Function tapOnButton,
      required bool isLoading,
      bool isLightButton = false,
      Color color = primaryColor,
      Color? fontColor = blackColor,
      double? height = 50.0,
      double? width}) {
  return SizedBox(
      width: width ?? MediaQuery
          .of(context)
          .size
          .width - (commonHorizontalPadding * 2),
      height: height,
      child: ElevatedButton(
          onPressed: () {
            if (!isLoading) {
              tapOnButton();
            }
          },
          style: ElevatedButton.styleFrom(
            shadowColor: blackColor.withOpacity(0.8), backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: commonButtonBorderRadius),
            padding: EdgeInsets.symmetric(vertical: height == 50.0 ? 15 : 2),
            elevation: 5.0,
          ),
          child: Text(
            title,
            style: black15PxW800.copyWith(
                color: fontColor,
                fontWeight: isLightButton ? FontWeight.w500 : FontWeight.bold,
                fontSize: height! >= 50.0 ? 16 : 14),
          )
      )
  );
}

commonDecoratedTextView({String title = "", bool isChangeColor = false,double bottom = 25}){
  return Container(
    padding: const EdgeInsets.all(12),
    margin: EdgeInsets.only(bottom: bottom),
    decoration: neurmorphicBoxDecoration,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        commonHeaderTitle(
            title: title,
            isChangeColor: isChangeColor,
            fontSize: isTablet() ? 1.4 : 1.1,
            color: blackColor.withOpacity(0.4)
        ),
        commonHorizontalSpacing(),
        Icon(Icons.keyboard_arrow_down,color: ConvertTheme.convertTheme.getWhiteToFontColor(),)
      ],
    ),
  );
}

Widget commonCheckBoxTile({Function? callback,bool isSelected = false, String title = ""}){
  return CheckboxListTile(
    controlAffinity: ListTileControlAffinity.leading,
    visualDensity: VisualDensity.comfortable,
    title: Text(title),
    value: isSelected,
    activeColor: greenColor,
    onChanged: (bool? value) {
      callback!(value);
    },
  );
}

PreferredSize commonAppbar({BuildContext? context,
  String title = "",
  bool isLeadingCCustom = false,
  Widget? leadingWidget,
  bool centerTitle = false}){
  return PreferredSize(
    preferredSize: const Size.fromHeight(56.0),
    child: Obx(() {
      return AppBar(
        backgroundColor: ConvertTheme.convertTheme.getBackGroundColor(),
        centerTitle: centerTitle,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: commonHeaderTitle(title: title,fontSize: 1.3,fontWeight: 2,align: TextAlign.center),
        ),
        leading: isLeadingCCustom ? leadingWidget! : InkWell(
            onTap: (){
              Get.back();
            },
            child: Container()),
        // actions: [],
      );
    }),
  );
}

Widget monthSelectionView({Function? callback}){
  num selectedYear = DateTime.now().year;
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    child: Container(
      padding: const EdgeInsets.all(18.0),
      margin: const EdgeInsets.only(top: 13.0,right: 8.0),
      decoration: BoxDecoration(
          color: whiteColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 0.0,
              offset: Offset(0.0, 0.0),
            ),
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StatefulBuilder(builder: (context, newSetState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(alignment: Alignment.centerLeft,onPressed: (){
                  newSetState((){
                    selectedYear -= 1;
                  });
                }, icon: const Icon(Icons.arrow_back_ios)),
                commonHeaderTitle(
                    title: selectedYear.toString(),
                    isChangeColor: true,
                    color: blackColor,
                    fontSize: 1.5,
                    fontWeight: 2,
                    align: TextAlign.center
                ),
                IconButton(alignment: Alignment.centerRight,onPressed: (){
                  newSetState((){
                    selectedYear += 1;
                  });
                }, icon: const Icon(Icons.arrow_forward_ios))
              ],
            );
          },),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 16 / 9,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: monthsLists.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  callback!("${monthsLists[index]}-$selectedYear");
                  Get.back();
                },
                child: commonHeaderTitle(title: monthsLists[index],align: TextAlign.center,fontSize: 1.3),
              );
            },
          )
        ],
      ),
    ),
  );
}

commonVerticalSpacing({double spacing = 10}){
  return SizedBox(height: spacing);
}

commonHorizontalSpacing({double spacing = 10}){
  return SizedBox(width: spacing);
}
