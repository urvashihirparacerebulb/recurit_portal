import 'package:cerebulb_recruit_portal/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'drawer_views/Expierence_view.dart';
import 'drawer_views/achievements_view.dart';
import 'drawer_views/address_view.dart';
import 'drawer_views/attachments_view.dart';
import 'drawer_views/basic_information_form_view.dart';
import 'common_widgets/common_widgets_view.dart';
import 'controllers/general_controller.dart';
import 'drawer_view.dart';
import 'drawer_views/certification_view.dart';
import 'drawer_views/compensation_view.dart';
import 'drawer_views/family_details_view.dart';
import 'drawer_views/identification_view.dart';
import 'drawer_views/industry_view.dart';
import 'drawer_views/languages_view.dart';
import 'drawer_views/qualification_view.dart';
import 'drawer_views/questionary_view.dart';
import 'drawer_views/references_view.dart';
import 'drawer_views/skills_view.dart';
import 'utility/assets_utility.dart';
import 'utility/color_utility.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerView(),
      appBar: commonSearchAppBar(
        context: context,
          leadingWidget: InkWell(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 4.0, 4.0, 4.0),
                child: Image(
                  image: menuIcon,
                  color: blackColor,
                ),
              ),
            ),
            onTap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          )
      ),
      body: Obx(() => GeneralController.to.dashBoardTitle.value == basicInformation ? const BasicInformationView() :
      GeneralController.to.dashBoardTitle.value == identification ? const IdentificationView() :
      GeneralController.to.dashBoardTitle.value == addressText ? const AddressView() :
      GeneralController.to.dashBoardTitle.value == skills ? const SkillsView() :
      GeneralController.to.dashBoardTitle.value == qualification ? const QualificationView() :
      GeneralController.to.dashBoardTitle.value == experience ? const ExpierenceView() :
      GeneralController.to.dashBoardTitle.value == compensation ? const CompensationView() :
      GeneralController.to.dashBoardTitle.value == questionary ? const QuestionaryView() :
      GeneralController.to.dashBoardTitle.value == familyInfo ? const FamilyDetailsView() :
      GeneralController.to.dashBoardTitle.value == industryDomain ? const IndustryView() :
      GeneralController.to.dashBoardTitle.value == certification ? const CertificationView() :
      GeneralController.to.dashBoardTitle.value == awardAchievements ? const AchievementsView() :
      GeneralController.to.dashBoardTitle.value == languages ? const LanguagesView() :
      GeneralController.to.dashBoardTitle.value == references ? const ReferencesView() :
      GeneralController.to.dashBoardTitle.value == attachments ? const AttachmentsView() :
      Container()),
    );
  }
}
