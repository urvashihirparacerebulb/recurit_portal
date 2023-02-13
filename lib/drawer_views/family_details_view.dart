import 'package:cerebulb_recruit_portal/models/candidate_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widgets_view.dart';
import '../controllers/candidate_controller.dart';
import '../theme/convert_theme_colors.dart';
import '../utility/color_utility.dart';
import '../utility/constants.dart';
import '../utility/delete_dialog_view.dart';
import '../utility/screen_utility.dart';

class FamilyDetailsView extends StatefulWidget {
  const FamilyDetailsView({Key? key}) : super(key: key);

  @override
  State<FamilyDetailsView> createState() => _FamilyDetailsViewState();
}

class _FamilyDetailsViewState extends State<FamilyDetailsView> {

  TextEditingController nameController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    CandidateController.to.getFamilyDetailInfo();
    super.initState();
  }

  void _showPopupMenu(Offset offset, FamilyDetail familyDetail) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
        context: context,
        color: ConvertTheme.convertTheme.getBackGroundColor(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        position: RelativeRect.fromLTRB(left, top, 20, 0),
        items: [
          PopupMenuItem<String>(
              value: 'Edit',
              child: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.edit),
                      commonHorizontalSpacing(),
                      const Text('Edit'),
                    ],
                  )
              )),
          PopupMenuItem<String>(
              value: 'Delete',
              child: InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (BuildContext context) => DeleteDialogView(doneCallback: (){
                      CandidateController.to.deleteFamilyInfo(familyInfoId: (familyDetail.id ?? "").toString());
                    }));
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.delete_forever_outlined),
                      commonHorizontalSpacing(),
                      const Text('Delete'),
                    ],
                  )
              )),
        ],
        elevation: 8.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
        context: context,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: "Family Details", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
                  commonFillButtonView(
                      context: context,
                      title: "ADD",
                      width: 70,
                      height: 35,
                      tapOnButton: () {

                      },
                      isLoading: false)
                ],
              ),
              commonVerticalSpacing(),
              Obx(() => CandidateController.to.candidateFamilyList.isNotEmpty ? SizedBox(
                height: getScreenHeight(context) - 157,
                child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: CandidateController.to.candidateFamilyList.map((e) => Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: neurmorphicBoxDecoration,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          commonHeaderTitle(title: e.relativeName ?? "", fontSize: isTablet() ? 1.3 : 1.4, fontWeight: 3),
                          commonVerticalSpacing(spacing: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              commonHeaderTitle(title: e.relativeOccupation ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                              commonHeaderTitle(title: e.relativeRelation ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                            ],
                          ),
                          commonVerticalSpacing(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  commonHeaderTitle(title: e.relativeEmail ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                                  commonVerticalSpacing(spacing: 5),
                                  commonHeaderTitle(title: e.relativePhone ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                                ],
                              ),
                              Expanded(flex: 2,child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                      onTapDown: (TapDownDetails details) {
                                        _showPopupMenu(details.globalPosition, e);
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(5.0),
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffD9D9D9)
                                          ),
                                          child: Icon(Icons.more_vert_rounded,size: isTablet() ? 28 : 20)
                                      )
                                  )
                              ))
                            ],
                          )
                        ],
                      ),
                    )).toList()
                ),
              ) : ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  CommonTextFiled(
                      fieldTitleText: "Name *",
                      hintText: "Name *",
                      // isBorderEnable: false,
                      textEditingController: nameController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(),
                  CommonTextFiled(
                      fieldTitleText: "Occupation *",
                      hintText: "Occupation *",
                      // isBorderEnable: false,
                      textEditingController: occupationController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(),
                  CommonTextFiled(
                      fieldTitleText: "Relation *",
                      hintText: "Relation *",
                      // isBorderEnable: false,
                      textEditingController: relationController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(spacing: 15),
                  CommonTextFiled(
                    fieldTitleText: "Email *",
                    hintText: "Email *",
                    // isBorderEnable: false,
                    textEditingController: emailController,
                    preFixIcon: const Icon(Icons.email,color: blackColor),
                    onChangedFunction: (String value){
                    },
                    validationFunction: (String value) {
                      return value.toString().isEmpty
                          ? notEmptyFieldMessage
                          : null;
                    },),
                  commonVerticalSpacing(spacing: 15),
                  CommonTextFiled(
                    fieldTitleText: "Mobile *",
                    hintText: "Mobile *",
                    // isBorderEnable: false,
                    textEditingController: mobileController,
                    inputFormatter: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    preFixIcon: const Icon(Icons.phone,color: blackColor),
                    onChangedFunction: (String value){
                    },
                    validationFunction: (String value) {
                      return value.toString().isEmpty
                          ? notEmptyFieldMessage
                          : null;
                    },),
                ],
              ))
            ],
          ),
        )
    );
  }
}
