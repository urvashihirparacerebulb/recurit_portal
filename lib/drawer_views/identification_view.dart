import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widgets_view.dart';
import '../controllers/candidate_controller.dart';
import '../theme/convert_theme_colors.dart';
import '../utility/color_utility.dart';
import '../utility/common_methods.dart';
import '../utility/constants.dart';
import '../utility/screen_utility.dart';

class IdentificationView extends StatefulWidget {
  const IdentificationView({Key? key}) : super(key: key);

  @override
  State<IdentificationView> createState() => _IdentificationViewState();
}

class _IdentificationViewState extends State<IdentificationView> {

  TextEditingController idTypeController = TextEditingController();
  TextEditingController idNoController = TextEditingController();
  TextEditingController issuingAuthorityController = TextEditingController();
  String issuingDate = DateTime.now().toString();
  String expiryDate =  DateTime.now().toString();
  File? attachmentImage;

  @override
  void initState() {
    CandidateController.to.getIdentificationInfoList();
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: "Identification", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
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
              Obx(() => CandidateController.to.identificationList.isNotEmpty ? SizedBox(
                height: getScreenHeight(context) - 157,
                child: ListView(
                    shrinkWrap: true,
                    children: CandidateController.to.identificationList.map((e) => Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: neurmorphicBoxDecoration,
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            color: Colors.grey,
                          ),
                          commonHorizontalSpacing(),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    commonHeaderTitle(title: e.idType ?? "", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 3),
                                    commonHeaderTitle(title: e.idNumber ?? "", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 3),
                                  ],
                                ),
                                commonVerticalSpacing(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    commonHeaderTitle(title: e.issuedDate ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                                    commonHeaderTitle(title: e.expiredDate ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                                  ],
                                ),
                                commonVerticalSpacing(),
                                Row(
                                  children: [
                                    commonHeaderTitle(title: e.issuedAuthority ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
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
                          )
                        ],
                      ),
                    )).toList()
                ),
              ) : ListView(
                shrinkWrap: true,
                children: [
                  CommonTextFiled(
                      fieldTitleText: "ID Type *",
                      hintText: "ID Type *",
                      // isBorderEnable: false,
                      textEditingController: idTypeController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(),
                  CommonTextFiled(
                      fieldTitleText: "ID No *",
                      hintText: "ID No *",
                      // isBorderEnable: false,
                      textEditingController: idNoController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(),
                  CommonTextFiled(
                      fieldTitleText: "Issuing Authority",
                      hintText: "Issuing Authority",
                      // isBorderEnable: false,
                      textEditingController: issuingAuthorityController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(),
                  Row(
                    children: [
                      Expanded(child: Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: commonHorizontalPadding),
                          decoration: neurmorphicBoxDecoration,
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: commonHeaderTitle(
                                      fontSize: isTablet() ? 1.3 : 1,
                                      height: 1.2,
                                      title: issuingDate.isEmpty ? "Issuing Date" : issuingDate)
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      openCalendarView(
                                        context,
                                        initialDate: DateTime.now().toString(),

                                      ).then((value) {
                                        setState(() {
                                          issuingDate = DateFormat("dd-MM-yyyy").format(value);
                                        });
                                      });
                                    },
                                    child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                                  )),
                            ],
                          ))),
                      commonHorizontalSpacing(),
                      Expanded(child: Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: commonHorizontalPadding),
                          decoration: neurmorphicBoxDecoration,
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: commonHeaderTitle(
                                      fontSize: isTablet() ? 1.3 : 1,
                                      height: 1.2,
                                      title: expiryDate.isEmpty ? "Expiry Date" : expiryDate)
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      openCalendarView(
                                        context,
                                        initialDate: DateTime.now().toString(),

                                      ).then((value) {
                                        setState(() {
                                          expiryDate = DateFormat("dd-MM-yyyy").format(value);
                                        });
                                      });
                                    },
                                    child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                                  )),
                            ],
                          )))
                    ],
                  ),
                  commonVerticalSpacing(spacing: 20),
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
