import 'dart:io';

import 'package:cerebulb_recruit_portal/models/candidate_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widgets_view.dart';
import '../configurations/api_service.dart';
import '../configurations/api_utility.dart';
import '../controllers/candidate_controller.dart';
import '../theme/convert_theme_colors.dart';
import '../utility/color_utility.dart';
import '../utility/common_methods.dart';
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
      height: title == "Salary Slips" ? salarySlipsImages!.isNotEmpty ? 180 : 80 : otherAttachmentsImages!.isNotEmpty ? 180 : 80,
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
                      FilePickerResult? result =
                      await FilePicker.platform.pickFiles(allowMultiple: true,
                        type: FileType.custom,
                        allowedExtensions: ["pdf", "docx","jpg","jpeg","png","exe"]
                      );

                      if (result != null) {
                        List<File?> files = result.paths.map((path) => File(path!)).toList();
                        onChanged!(files);
                      } else {
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
                return Row(
                  children: [
                    InkWell(
                      onTap: (){
                        launchInBrowser(title == "Salary Slips" ? salarySlipsImages![index].link ?? "" : otherAttachmentsImages![index].link ?? "");
                      },
                      child: GetUtils.isPDF(title == "Salary Slips" ? salarySlipsImages![index].link ?? "" :
                        otherAttachmentsImages![index].link ?? "") ?
                        const Icon(Icons.picture_as_pdf_outlined,color: dangerColor,size: 100,) :
                        Image.network(title == "Salary Slips" ? salarySlipsImages![index].link ?? "" :
                        otherAttachmentsImages![index].link ?? "", height: 100),
                    ),
                    commonHorizontalSpacing(spacing: 20),
                    InkWell(
                      onTap: (){
                        if(title == "Salary Slips") {
                          CandidateController.to.deleteOtherAttachmentsForExperience(
                              expId: selectedExperience?.id,
                              docName: salarySlipsImages![index]
                                  .filename ?? "",
                              callback: () {
                                CandidateController.to.getExperiencesList();
                              }
                          );
                        }else{
                          CandidateController.to.deleteSalarySlipsExperience(
                              expId: selectedExperience?.id,
                              docName: otherAttachmentsImages![index]
                                  .filename ?? "",
                              callback: () {
                                CandidateController.to.getExperiencesList();
                              }
                          );
                        }
                      },
                      child: const Icon(Icons.delete_forever_outlined, color: dangerColor),
                    ),
                    commonHorizontalSpacing(spacing: 20),
                  ],
                );
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
                    salarySlipsImages?.clear();
                    otherAttachmentsImages?.clear();
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
                        experience.salarySlip?.forEach((element) {
                          if((element.link != null || element.filename != "")){
                            salarySlipsImages!.add(element);
                          }
                        });
                      }
                      if(experience.otherAttachement!.isNotEmpty){
                        experience.otherAttachement?.forEach((element) {
                          if((element.link != null || element.filename != "")){
                            otherAttachmentsImages!.add(element);
                          }
                        });
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
                    showDialog(context: context, builder: (BuildContext context) => Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      child: Container(
                        margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                        child: Container(
                          padding: const EdgeInsets.only(top: 18.0),
                          margin: const EdgeInsets.only(top: 13.0, right: 8.0),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Get.back();
                                      },
                                      child: const Icon(Icons.clear,color: blackColor),
                                    )
                                  ],
                                ),
                                commonVerticalSpacing(),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: experience.salarySlip?.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonHeaderTitle(
                                          title: "Salary Slips",
                                          fontWeight: 1,
                                        ),
                                        InkWell(
                                            onTap: () async {
                                              var tempDir = await getTemporaryDirectory();
                                              String fullPath = tempDir.path;
                                              if(experience.salarySlip!.isNotEmpty){
                                                download2(APIProvider.getDio(), experience.salarySlip![index].link ?? "", fullPath);
                                              }
                                            },
                                            child: const Icon(Icons.download))
                                      ],
                                    );
                                  },),
                                commonVerticalSpacing(),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: experience.otherAttachement?.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        commonHeaderTitle(
                                          title: "Other Attachments",
                                          fontWeight: 1,
                                        ),
                                        InkWell(
                                            onTap: () async {
                                              var tempDir = await getTemporaryDirectory();
                                              String fullPath = tempDir.path;
                                              if(experience.otherAttachement!.isNotEmpty){
                                                download2(APIProvider.getDio(), experience.otherAttachement![index].link ?? "", fullPath);
                                              }
                                            },
                                            child: const Icon(Icons.download))
                                      ],
                                    );
                                  },),
                                commonVerticalSpacing(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    commonHeaderTitle(
                                      title: "Offer Letter",
                                      fontWeight: 1,
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          var tempDir = await getTemporaryDirectory();
                                          String fullPath = tempDir.path;
                                          if(experience.offerLetter != null && experience.offerLetter!.isNotEmpty){
                                            download2(APIProvider.getDio(), experience.offerLetter ?? "", fullPath);
                                          }
                                        },
                                        child: const Icon(Icons.download))
                                  ],
                                ),
                                commonVerticalSpacing(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    commonHeaderTitle(
                                      title: "Relieving Letter",
                                      fontWeight: 1,
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          var tempDir = await getTemporaryDirectory();
                                          String fullPath = tempDir.path;
                                          if(experience.relievingLetter != null && experience.relievingLetter!.isNotEmpty){
                                            download2(APIProvider.getDio(), experience.relievingLetter ?? "", fullPath);
                                          }
                                        },
                                        child: const Icon(Icons.download)
                                    )
                                  ],
                                ),
                                commonVerticalSpacing(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    commonHeaderTitle(
                                      title: "Experience Letter",
                                      fontWeight: 1,
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          var tempDir = await getTemporaryDirectory();
                                          String fullPath = tempDir.path;
                                          if(experience.experienceLetter != null && experience.experienceLetter!.isNotEmpty){
                                            download2(APIProvider.getDio(), experience.experienceLetter ?? "", fullPath);
                                          }
                                        },
                                        child: const Icon(Icons.download))
                                  ],
                                ),
                                commonVerticalSpacing(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
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
                            commonHeaderTitle(title: parse(e.responsibility).body!.text, fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
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
                  multipleImageView(title: "Salary Slips", onChanged: (List<File> filePaths){
                    setState(() {
                      for (var element in filePaths) {
                        ImageModel salarySlip = ImageModel();
                        salarySlip.filename = "";
                        salarySlip.link = "";
                        salarySlip.filePath = element;
                        salarySlipsImages?.add(salarySlip);
                      }
                    });
                  }),
                  commonVerticalSpacing(spacing: 20),
                  multipleImageView(title: "Other attachments", onChanged: (List<File> filePaths){
                    setState(() {
                      for (var element in filePaths) {
                        ImageModel otherAttachment = ImageModel();
                        otherAttachment.filename = "";
                        otherAttachment.link = "";
                        otherAttachment.filePath = element;
                        otherAttachmentsImages?.add(otherAttachment);
                      }
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
