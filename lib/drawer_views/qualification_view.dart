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
import '../utility/common_methods.dart';
import '../utility/constants.dart';
import '../utility/delete_dialog_view.dart';
import '../utility/screen_utility.dart';

class QualificationView extends StatefulWidget {
  const QualificationView({Key? key}) : super(key: key);

  @override
  State<QualificationView> createState() => _QualificationViewState();
}

class _QualificationViewState extends State<QualificationView> {
  List<ImageModel>? markSheetImages = [];
  File? certificateImage;
  TextEditingController instituteNameController = TextEditingController();
  TextEditingController departmentNameController = TextEditingController();
  TextEditingController degreeNameController = TextEditingController();
  String durationFrom = "";
  String durationTo = "";
  bool isCurrentlyPersuing = false;
  bool isAdd = false;
  bool isEdit = false;
  Qualification? selectedQualification;

  @override
  void initState() {
    CandidateController.to.getQualificationsList();
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
                ) : Expanded(child: (selectedQualification != null && selectedFile == null) ?
                      selectedQualification!.certificate == null ? commonHeaderTitle(
                          title: "No File Chosen",
                          color: blackColor.withOpacity(0.4),
                          isChangeColor: true
                      ) : Image.network(selectedQualification!.certificate ?? "", height: 100) :
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
      height: markSheetImages!.isNotEmpty ? 180 : 80,
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
            itemCount: markSheetImages?.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if(markSheetImages![index].filePath == null){
                return Row(
                  children: [
                    InkWell(
                      onTap: (){
                        launchInBrowser(markSheetImages![index].link ?? "");
                      },
                      child: GetUtils.isPDF(markSheetImages![index].link ?? "") ?
                      const Icon(Icons.picture_as_pdf_outlined,color: dangerColor,size: 100,) : Image.network(markSheetImages![index].link ?? "", height: 100),
                    ),
                    commonHorizontalSpacing(spacing: 20),
                    InkWell(
                      onTap: (){
                        CandidateController.to.deleteMarkSheetsInQualification(
                            qulId: selectedQualification?.id,
                            docName: markSheetImages![index].filename ?? "",
                            callback: () {
                              CandidateController.to.getQualificationsList();
                            }
                        );
                      },
                      child: const Icon(Icons.delete_forever_outlined, color: dangerColor),
                    ),
                    commonHorizontalSpacing(spacing: 20),
                  ],
                );
              }
              return Image.file(markSheetImages![index].filePath!, height: 100);
            },
          ))
        ],
      ),
    );
  }

  void _showPopupMenu(Offset offset, Qualification qualification) async {
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
                      selectedQualification = qualification;
                      instituteNameController.text = qualification.instituteName ?? "";
                      departmentNameController.text = qualification.departmentName ?? "";
                      degreeNameController.text = qualification.degreeName ?? "";
                      durationFrom = qualification.fromMonth ?? "";
                      durationTo = qualification.toMonth ?? "";
                      isCurrentlyPersuing = qualification.persuing != null ? qualification.persuing == "Yes" ? true : false : false;
                      if(qualification.marksheet!.isNotEmpty){
                        markSheetImages!.addAll(qualification.marksheet ?? []);
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
              )
          ),
          PopupMenuItem<String>(
              value: 'Delete',
              child: InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (BuildContext context) => DeleteDialogView(doneCallback: (){
                      CandidateController.to.deleteQualification(qulID: (qualification.id ?? "").toString());
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
                      const Text('Download'),
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
                  commonHeaderTitle(title: "Qualification Information", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
                  isAdd ? commonFillButtonView(
                      context: context,
                      title: "SAVE",
                      width: 70,
                      height: 35,
                      tapOnButton: () {
                        CandidateController.to.addEditQualificationInfo(
                            name: instituteNameController.text,
                            department: departmentNameController.text,
                            degreeName: degreeNameController.text,
                            fromMonth: durationFrom,
                            toMonth: durationTo,
                            persuing: isCurrentlyPersuing,
                            isEdit: isEdit,
                            qualificationId: selectedQualification != null ? selectedQualification!.id.toString() : "",
                            status: "Active",
                            certificate: certificateImage,
                            markSheets: markSheetImages!.where((element) => element.filename != null).map((e) => e.filePath!).toList(),
                            callback: (){
                              CandidateController.to.getQualificationsList();
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
                  children: CandidateController.to.qualificationsList.map((e) => Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: neurmorphicBoxDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        commonHeaderTitle(title: e.instituteName ?? "", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 2),
                        commonVerticalSpacing(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            commonHeaderTitle(title: e.departmentName ?? "", fontSize: isTablet() ? 1.3 : 1.1, fontWeight: 1),
                            commonHeaderTitle(title: e.degreeName ?? "", fontSize: isTablet() ? 1.3 : 1.1, fontWeight: 1),
                          ],
                        ),
                        commonVerticalSpacing(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                commonHeaderTitle(title: e.fromMonth ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                                commonHeaderTitle(title: e.toMonth ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1)
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
                      fieldTitleText: "Institute Name *",
                      hintText: "Institute Name *",
                      // isBorderEnable: false,
                      textEditingController: instituteNameController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(),
                  CommonTextFiled(
                      fieldTitleText: "Department Name",
                      hintText: "Department Name",
                      // isBorderEnable: false,
                      textEditingController: departmentNameController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(),
                  CommonTextFiled(
                      fieldTitleText: "Degree Name",
                      hintText: "Degree Name",
                      // isBorderEnable: false,
                      textEditingController: degreeNameController,
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
                          if(!isCurrentlyPersuing) {
                            showDialog(context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) =>
                                    monthSelectionView(callback: (String val) {
                                      setState(() {
                                        durationTo = val;
                                      });
                                    }));
                          }
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
                  commonCheckBoxTile(title: "Currently Persuing",callback: (bool val){
                    setState(() {
                      isCurrentlyPersuing = val;
                    });
                  },isSelected: isCurrentlyPersuing),
                  commonVerticalSpacing(spacing: 15),
                  multipleImageView(title: "Marksheet", onChanged: (File file){
                    setState(() {
                      ImageModel marksheet = ImageModel();
                      marksheet.filename = "";
                      marksheet.link = "";
                      marksheet.filePath = file;
                      markSheetImages?.add(marksheet);
                    });
                  }),
                  commonVerticalSpacing(spacing: 20),
                  imageView(title: "Certificate", onChanged: (File file){
                    setState(() {
                      certificateImage = file;
                    });
                  },selectedFile: certificateImage)
                ],
              ))
            ],
          ),
        )
    );
  }
}
