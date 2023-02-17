import 'dart:io';

import 'package:cerebulb_recruit_portal/models/candidate_model.dart';
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
import '../utility/delete_dialog_view.dart';
import '../utility/screen_utility.dart';

class ExpierenceView extends StatefulWidget {
  const ExpierenceView({Key? key}) : super(key: key);

  @override
  State<ExpierenceView> createState() => _ExpierenceViewState();
}

class _ExpierenceViewState extends State<ExpierenceView> {

  TextEditingController profileNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController responsibilityController = TextEditingController();
  String durationFrom = "";
  String durationTo = "";
  bool isCurrentlyWorkingHere = false;

  File? offerLetterImage;
  File? relievingLetterImage;
  File? experienceLetterImage;

  bool isAdd = false;
  bool isEdit = false;
  Experience? selectedExperience;
  List<ImageModel>? salarySlipsImages = [];
  List<ImageModel>? otherAttachmentsImages = [];

  @override
  void initState() {
    CandidateController.to.getExperiencesList();
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
                selectedFile == null && !isEdit ? commonHeaderTitle(
                    title: "No File Chosen",
                    color: blackColor.withOpacity(0.4),
                    isChangeColor: true
                ) : Expanded(child: (selectedExperience != null && selectedFile == null) ?
                (title == "Offer Letter" ? selectedExperience!.offerLetter == null :
                title == "Relieving Letter" ? selectedExperience!.relievingLetter == null :
                selectedExperience!.experienceLetter == null)? commonHeaderTitle(
                    title: "No File Chosen",
                    color: blackColor.withOpacity(0.4),
                    isChangeColor: true
                ) : Image.network((title == "Offer Letter" ? (selectedExperience!.offerLetter ?? "") :
                title == "Relieving Letter" ? (selectedExperience!.relievingLetter ?? "") :
                (selectedExperience!.experienceLetter ?? "")), height: 100) :
                   Image.file(selectedFile!, height: 100)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  multipleImageView({String title = "", Function? onChanged}) {
    return SizedBox(
      height: 80,
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
            height: 50,
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
                commonHeaderTitle(
                    title: "No File Chosen",
                    color: blackColor.withOpacity(0.4),
                    isChangeColor: true
                )
              ],
            ),
          ),
          commonVerticalSpacing(spacing: 8),
          Expanded(child: ListView.builder(
            shrinkWrap: true,
            itemCount: title == "Salary Slips" ? salarySlipsImages?.length : otherAttachmentsImages?.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if((title == "Salary Slips" ? salarySlipsImages![index].filePath : otherAttachmentsImages![index].filePath) == null){
                return GetUtils.isPDF(title == "Salary Slips" ? salarySlipsImages![index].link ?? "" : otherAttachmentsImages![index].link ?? "") ?
                const Icon(Icons.picture_as_pdf_outlined,color: dangerColor,size: 100,) : Image.network(title == "Salary Slips" ? salarySlipsImages![index].link ?? "" : otherAttachmentsImages![index].link ?? "", height: 100);
              }
              return Image.file(title == "Salary Slips" ? salarySlipsImages![index].filePath! : otherAttachmentsImages![index].filePath!, height: 100);
            },
          ))
        ],
      ),
    );
  }

  void _showPopupMenu(Offset offset, Experience experience) async {
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
                      selectedExperience = experience;
                      profileNameController.text = experience.occupationName ?? "";
                      companyNameController.text = experience.companyName ?? "";
                      responsibilityController.text = experience.responsibility ?? "";
                      durationFrom = experience.fromMonths ?? "";
                      durationTo = experience.toMonths ?? "";
                      isCurrentlyWorkingHere = experience.currentlyWorking != null ? experience.currentlyWorking == "Yes" ? true : false : false;
                      if(experience.salarySlip!.isNotEmpty){
                        salarySlipsImages!.addAll(experience.salarySlip ?? []);
                      }
                      if(experience.otherAttachement!.isNotEmpty){
                        otherAttachmentsImages!.addAll(experience.otherAttachement ?? []);
                      }
                    });
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
                      CandidateController.to.deleteExperience(expId: (experience.id ?? "").toString());
                    }));
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.delete_forever_outlined),
                      commonHorizontalSpacing(),
                      const Text('Delete'),
                    ],
                  )
              )
          ),
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
                      const Text('Download')
                    ],
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
                  commonHeaderTitle(title: "Experience", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
                  isAdd ? commonFillButtonView(
                      context: context,
                      title: "SAVE",
                      width: 70,
                      height: 35,
                      tapOnButton: () {
                        CandidateController.to.addEditExperienceInfo(
                            name: profileNameController.text,
                            companyName: companyNameController.text,
                            responsibility: responsibilityController.text,
                            fromMonth: durationFrom,
                            toMonth: durationTo,
                            currentlyWorking: isCurrentlyWorkingHere,
                            isEdit: isEdit,
                            expId: selectedExperience != null ? selectedExperience!.id.toString() : "",
                            status: "Active",
                            offerLetter: offerLetterImage,
                            experienceLetter: experienceLetterImage,
                            relievingLetter: relievingLetterImage,
                            salarySlips: salarySlipsImages!.where((element) => element.filename != null).map((e) => e.filePath!).toList(),
                            otherAttachments: otherAttachmentsImages!.where((element) => element.filename != null).map((e) => e.filePath!).toList(),
                            callback: (){
                              CandidateController.to.getExperiencesList();
                              isAdd = false;
                              isEdit = false;
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
                        });
                      },
                      isLoading: false)
                ],
              ),
              commonVerticalSpacing(),
              Obx(() => !isAdd ? ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: CandidateController.to.experiencesList.map((e) => Container(
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
                            commonHeaderTitle(title: e.occupationName ?? "", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 2),
                            commonHeaderTitle(title: e.companyName ?? "", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 2),
                          ],
                        ),
                        commonVerticalSpacing(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            commonHeaderTitle(title: e.fromMonths ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                            commonHeaderTitle(title: e.toMonths ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                          ],
                        ),
                        commonVerticalSpacing(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            commonHeaderTitle(title: e.responsibility ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
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
                        )
                      ],
                    ),
                  )).toList()
              ) : ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  CommonTextFiled(
                      fieldTitleText: "Profile/Designation *",
                      hintText: "Profile/Designation *",
                      // isBorderEnable: false,
                      textEditingController: profileNameController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(),
                  CommonTextFiled(
                      fieldTitleText: "Company Name *",
                      hintText: "Company Name *",
                      // isBorderEnable: false,
                      textEditingController: companyNameController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(),
                  CommonTextFiled(
                      fieldTitleText: "Responsibility",
                      hintText: "Responsibility",
                      maxLine: 5,
                      // isBorderEnable: false,
                      textEditingController: responsibilityController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(spacing: 15),
                  Row(
                    children: [
                      Expanded(child: InkWell(
                        onTap: (){
                          showDialog(context: context, barrierDismissible: false,builder: (BuildContext context) => monthSelectionView(callback: (String val){
                            setState(() {
                              durationFrom = val;
                            });
                          }));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: neurmorphicBoxDecoration,
                          child: commonHeaderTitle(
                              title: durationFrom.isEmpty ? "Duration From" : durationFrom
                          ),
                        ),
                      )),
                      commonHorizontalSpacing(spacing: 10),
                      Expanded(child: InkWell(
                        onTap: (){
                          showDialog(context: context, barrierDismissible: false,builder: (BuildContext context) => monthSelectionView(callback: (String val){
                            setState(() {
                              durationTo = val;
                            });
                          }));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: neurmorphicBoxDecoration,
                          child: commonHeaderTitle(
                              title: durationTo.isEmpty ? "Duration To" : durationTo
                          ),
                        ),
                      ))
                    ],
                  ),
                  commonVerticalSpacing(spacing: 15),
                  commonCheckBoxTile(title: "Currently Working Here",callback: (bool val){
                    setState(() {
                      isCurrentlyWorkingHere = val;
                    });
                  },isSelected: isCurrentlyWorkingHere),
                  commonVerticalSpacing(spacing: 15),
                  imageView(title: "Offer Letter", onChanged: (File file){
                    setState(() {
                      offerLetterImage = file;
                    });
                  },selectedFile: offerLetterImage),
                  commonVerticalSpacing(spacing: 20),
                  imageView(title: "Relieving Letter", onChanged: (File file){
                    setState(() {
                      relievingLetterImage = file;
                    });
                  },selectedFile: relievingLetterImage),
                  commonVerticalSpacing(spacing: 20),
                  imageView(title: "Experience Letter", onChanged: (File file){
                    setState(() {
                      experienceLetterImage = file;
                    });
                  },selectedFile: experienceLetterImage),
                  commonVerticalSpacing(spacing: 15),
                  multipleImageView(title: "Salary Slips", onChanged: (File file){
                    setState(() {
                      ImageModel marksheet = ImageModel();
                      marksheet.filename = "";
                      marksheet.link = "";
                      marksheet.filePath = file;
                      salarySlipsImages?.add(marksheet);
                    });
                  }),
                  commonVerticalSpacing(spacing: 20),
                  multipleImageView(title: "Other attachments", onChanged: (File file){
                    setState(() {
                      ImageModel marksheet = ImageModel();
                      marksheet.filename = "";
                      marksheet.link = "";
                      marksheet.filePath = file;
                      otherAttachmentsImages?.add(marksheet);
                    });
                  }),
                  commonVerticalSpacing(spacing: 20),
                ],
              ))
            ],
          ),
        )
    );
  }
}
