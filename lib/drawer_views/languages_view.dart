import 'package:cerebulb_recruit_portal/models/candidate_model.dart';
import 'package:cerebulb_recruit_portal/utility/color_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widgets_view.dart';
import '../controllers/candidate_controller.dart';
import '../theme/convert_theme_colors.dart';
import '../utility/constants.dart';
import '../utility/delete_dialog_view.dart';
import '../utility/screen_utility.dart';

class LanguagesView extends StatefulWidget {
  const LanguagesView({Key? key}) : super(key: key);

  @override
  State<LanguagesView> createState() => _LanguagesViewState();
}

class _LanguagesViewState extends State<LanguagesView> {

  TextEditingController languageNameController = TextEditingController();
  bool isRead = false;
  bool isWrite = false;
  bool isSpeak = false;
  bool isAdd = false;
  bool isEdit = false;
  Language? selectedLanguage;

  @override
  void initState() {
    CandidateController.to.getLanguagesList();
    super.initState();
  }

  void _showPopupMenu(Offset offset,Language language) async {
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
                    setState((){
                      isAdd = true;
                      isEdit = true;
                      selectedLanguage = language;
                      languageNameController.text = language.language ?? "";
                      isRead = language.read != null ? language.read == "Yes" ? true : false : false;
                      isWrite = language.write != null ? language.write == "Yes" ? true : false : false;
                      isSpeak = language.speak != null ? language.speak == "Yes" ? true : false : false;
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.edit),
                      commonHorizontalSpacing(),
                      const Text('Edit')
                    ],
                  )
              )),
          PopupMenuItem<String>(
              value: 'Delete',
              child: InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (BuildContext context) => DeleteDialogView(doneCallback: (){
                      CandidateController.to.deleteLanguage(lanId: (language.id ?? "").toString());
                    }));
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.delete_forever_outlined),
                      commonHorizontalSpacing(),
                      const Text('Delete')
                    ]
                  )
              )
          )
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
                  commonHeaderTitle(title: "Language", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 2),
                  isAdd ? commonFillButtonView(
                      context: context,
                      title: "SAVE",
                      width: 70,
                      height: 35,
                      tapOnButton: () {
                        CandidateController.to.addEditLanguageInfo(
                            langName: languageNameController.text,
                            isRead: isRead,
                            isWrite: isWrite,
                            isSpeak: isSpeak,
                            isEdit: isEdit,
                            langId: selectedLanguage != null ? selectedLanguage!.id.toString() : "",
                            status: "Active",
                            callback: (){
                              CandidateController.to.getLanguagesList();
                              setState(() {
                                isAdd = false;
                                isEdit = false;
                              });
                            }
                        );
                      },
                      isLoading: false) : commonFillButtonView(
                      context: context,
                      title: "ADD",
                      width: 70,
                      height: 35,
                      tapOnButton: () {
                        setState(() {
                          isAdd = true;
                          languageNameController.text = "";
                          isRead = false;
                          isWrite = false;isSpeak = false;
                        });
                      },
                      isLoading: false)
                ],
              ),
              commonVerticalSpacing(),
              Obx(() => !isAdd ? ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: CandidateController.to.languagesList.map((e) => Container(
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
                            commonHeaderTitle(title: e.language ?? "", fontSize: isTablet() ? 1.3 : 1.1, fontWeight: 2),
                            Expanded(flex: 2,child: Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                    onTapDown: (TapDownDetails details) {
                                      _showPopupMenu(details.globalPosition,e);
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xffD9D9D9)
                                        ),
                                        child: Icon(Icons.more_vert_rounded,size: isTablet() ? 28 : 20))
                                )
                            ))
                          ],
                        ),
                        commonVerticalSpacing(spacing: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                commonHeaderTitle(title: "READ", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                                commonVerticalSpacing(),
                                e.read != null && (e.read == "Yes") ? const Icon(Icons.check_circle_outline,color: greenColor) :
                                const Icon(Icons.close,color: dangerColor)
                              ],
                            )),

                            Expanded(child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                commonHeaderTitle(title: "WRITE", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                                commonVerticalSpacing(),
                                e.write != null && (e.write == "Yes") ? const Icon(Icons.check_circle_outline,color: greenColor) :
                                const Icon(Icons.close,color: dangerColor)
                              ],
                            )),

                            Expanded(child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                commonHeaderTitle(title: "SPEAK", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                                commonVerticalSpacing(),
                                e.speak != null && (e.speak == "Yes") ? const Icon(Icons.check_circle_outline,color: greenColor) :
                                const Icon(Icons.close,color: dangerColor)
                              ],
                            ))
                          ],
                        )
                      ],
                    ),
                  )).toList()
              ) : ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  CommonTextFiled(
                      fieldTitleText: "Language Name",
                      hintText: "Enter Language Name",
                      // isBorderEnable: false,
                      textEditingController: languageNameController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(),
                  commonCheckBoxTile(title: "READ",callback: (bool val){
                    setState(() {
                      isRead = val;
                    });
                  },isSelected: isRead),
                  commonCheckBoxTile(title: "WRITE",callback: (bool val){
                    setState(() {
                      isWrite = val;
                    });
                  },isSelected: isWrite),
                  commonCheckBoxTile(title: "SPEAK",callback: (bool val){
                    setState(() {
                      isSpeak = val;
                    });
                  },isSelected: isSpeak),
                ],
              ))
            ],
          ),
        )
    );
  }
}
