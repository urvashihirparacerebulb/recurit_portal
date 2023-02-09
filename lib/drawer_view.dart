import 'package:cerebulb_recruit_portal/utility/color_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/general_controller.dart';
import 'utility/constants.dart';
import 'utility/theme_utils.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints){
          return Container(
            color: whiteColor,
            padding: EdgeInsets.zero,
            child: ListView(
              shrinkWrap: true,
              children: [
                drawerListTile(Icons.people, basicInformation, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = basicInformation;
                }),
                drawerListTile(Icons.people, identification, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = identification;
                }),
                drawerListTile(Icons.location_on, addressText, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = addressText;
                }),
                drawerListTile(Icons.people, skills, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = skills;
                }),
                drawerListTile(Icons.people, qualification, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = qualification;
                }),
                drawerListTile(Icons.people, experience, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = experience;
                }),
                drawerListTile(Icons.people, compensation, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = compensation;
                }),
                drawerListTile(Icons.people, questionary, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = questionary;
                }),
                drawerListTile(Icons.people, familyInfo, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = familyInfo;
                }),
                drawerListTile(Icons.people, industryDomain, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = industryDomain;
                }),
                drawerListTile(Icons.people, certification, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = certification;
                }),
                drawerListTile(Icons.people, awardAchievements, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = awardAchievements;
                }),
                drawerListTile(Icons.people, languages, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = languages;
                }),
                drawerListTile(Icons.people, references, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = references;
                }),
                drawerListTile(Icons.people, attachments, changeIndexOfDashBoard: () {
                  GeneralController.to.dashBoardTitle.value = attachments;
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget drawerListTile(IconData image, String title,
      {Widget? screenWidget, Function? changeIndexOfDashBoard}) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 0),
        color: (GeneralController.to.dashBoardTitle.value == title ? primaryColor : whiteColor),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0.0),
          onTap: () {
            Get.back();
            if (changeIndexOfDashBoard != null) {
              changeIndexOfDashBoard();
            }
            if (screenWidget != null) {
              Get.to(() => screenWidget);
            }
          },
          tileColor: whiteColor,
          selected: GeneralController.to.dashBoardTitle.value == title,
          selectedTileColor: primaryColor,
          leading: SizedBox(
            width: 50,
            child: Icon(image,color: blackColor),
          ),
          title: Text(
            title,
            style: black14PxNormal.copyWith(
              color: blackColor
            ),
          ),
        ),
      );
    });
  }
}
