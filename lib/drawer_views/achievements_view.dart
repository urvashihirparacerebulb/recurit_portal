import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widgets_view.dart';
import '../controllers/candidate_controller.dart';
import '../theme/convert_theme_colors.dart';
import '../utility/color_utility.dart';
import '../utility/constants.dart';
import '../utility/screen_utility.dart';

class AchievementsView extends StatefulWidget {
  const AchievementsView({Key? key}) : super(key: key);

  @override
  State<AchievementsView> createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView> {

  TextEditingController awardNameController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController orgFromController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  File? attachmentImage;

  @override
  void initState() {
    CandidateController.to.getAchievementsInfo();
    super.initState();
  }

  imageView({String title = "", Function? onChanged, File? selectedFile}) {
    return SizedBox(
      height: selectedFile == null ? 72 : 144,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonHeaderTitle(
              title: title,
              color: blackColor,
              isChangeColor: true
          ),
          commonVerticalSpacing(spacing: 8),
          Container(
            height: selectedFile == null ? 50 : 100,
            padding: const EdgeInsets.all(10),
            decoration: neurmorphicBoxDecoration,
            child: Row(
              children: [
                InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      try {
                        final XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        setState(() {
                          onChanged!(File(pickedFile!.path));
                        });
                      } catch (e) {
                        if (kDebugMode) {
                          print(e);
                        }
                      }
                    },
                    child: commonHeaderTitle(
                        title: "Choose File",
                        color: blackColor.withOpacity(0.4),
                        isChangeColor: true
                    )
                ),
                commonHorizontalSpacing(spacing: 10),
                Container(height: 40, width: 1, color: fontColor),
                commonHorizontalSpacing(spacing: 10),
                selectedFile == null ? commonHeaderTitle(
                    title: "No File Chosen",
                    color: blackColor.withOpacity(0.4),
                    isChangeColor: true
                ) : Expanded(child: Image.file(selectedFile, height: 100))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPopupMenu(Offset offset) async {
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
                    Get.back();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.delete_forever_outlined),
                      commonHorizontalSpacing(),
                      const Text('Delete'),
                    ],
                  )
              )),
          PopupMenuItem<String>(
              value: 'Download',
              child: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.download),
                      commonHorizontalSpacing(),
                      const Text('Download'),
                    ],
                  )
              ))
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
                  commonHeaderTitle(title: "Achievement Information", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
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
              Obx(() => CandidateController.to.candidateAchievementsList.isNotEmpty ? SizedBox(
                height: getScreenHeight(context) - 157,
                child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: CandidateController.to.candidateAchievementsList.map((e) => Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: neurmorphicBoxDecoration,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              commonHeaderTitle(title: e.name ?? "", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 2),
                              commonHeaderTitle(title: e.from ?? "", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 2),
                            ],
                          ),
                          commonVerticalSpacing(),
                          commonHeaderTitle(title: e.purpose ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                          commonVerticalSpacing(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              commonHeaderTitle(title: e.remark ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                              Expanded(flex: 2,child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                      onTapDown: (TapDownDetails details) {
                                        _showPopupMenu(details.globalPosition);
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
                      fieldTitleText: "Award Name *",
                      hintText: "Award Name *",
                      // isBorderEnable: false,
                      textEditingController: awardNameController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(),
                  CommonTextFiled(
                      fieldTitleText: "Purpose",
                      hintText: "Purpose",
                      // isBorderEnable: false,
                      textEditingController: purposeController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(spacing: 15),
                  CommonTextFiled(
                      fieldTitleText: "Organization From",
                      hintText: "Organization From",
                      // isBorderEnable: false,
                      textEditingController: orgFromController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(),
                  CommonTextFiled(
                      fieldTitleText: "Remark",
                      hintText: "Remark",
                      // isBorderEnable: false,
                      textEditingController: remarksController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(spacing: 15),
                  imageView(title: "Attachment", onChanged: (File file){
                    setState(() {
                      attachmentImage = file;
                    });
                  },selectedFile: attachmentImage),
                ],
              ))
            ],
          ),
        )
    );
  }
}
