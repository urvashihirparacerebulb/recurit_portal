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

class CertificationView extends StatefulWidget {
  const CertificationView({Key? key}) : super(key: key);

  @override
  State<CertificationView> createState() => _CertificationViewState();
}

class _CertificationViewState extends State<CertificationView> {
  TextEditingController certificateNameController = TextEditingController();
  TextEditingController issuingOrgController = TextEditingController();
  TextEditingController credIdController = TextEditingController();
  TextEditingController credURLController = TextEditingController();
  TextEditingController instituteNameController = TextEditingController();
  String issueDate = "";
  String expirationDate = "";
  bool isCredNotExpire = false;
  File? attachmentImage;

  @override
  void initState() {
    CandidateController.to.getCertificationInfoList();
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

  void _showPopupMenu(Offset offset,{Certification? certification}) async {
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
                    showDialog(context: context, builder: (BuildContext context) => DeleteDialogView(doneCallback: (){
                      CandidateController.to.deleteCertificate(certificationId: certification!.id ?? "");
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
                  commonHeaderTitle(title: "Certificates", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
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
              Obx(() => CandidateController.to.certificationList.isNotEmpty ? SizedBox(
                height: getScreenHeight(context) - 157,
                child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: CandidateController.to.certificationList.map((e) => Container(
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
                              commonHeaderTitle(title: e.certificateName ?? "", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 2),
                              commonHeaderTitle(title: e.issuingOrganization ?? "", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 2),
                            ],
                          ),
                          commonVerticalSpacing(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              commonHeaderTitle(title: e.issueMonth ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                              commonHeaderTitle(title: e.expireMonth ?? "-", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                            ],
                          ),
                          commonVerticalSpacing(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              commonHeaderTitle(title: e.credentialId ?? "", fontSize: isTablet() ? 1.3 : 1, fontWeight: 1),
                              Expanded(flex: 2,child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                      onTapDown: (TapDownDetails details) {
                                        _showPopupMenu(details.globalPosition, certification: e);
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
                ),
              ) : ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  CommonTextFiled(
                      fieldTitleText: "Certificate Name *",
                      hintText: "Certificate Name *",
                      // isBorderEnable: false,
                      textEditingController: certificateNameController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(),
                  CommonTextFiled(
                      fieldTitleText: "Issuing Organization *",
                      hintText: "Issuing Organization *",
                      // isBorderEnable: false,
                      textEditingController: issuingOrgController,
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
                              issueDate = val;
                            });
                          }));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: neurmorphicBoxDecoration,
                          child: commonHeaderTitle(
                              title: issueDate.isEmpty ? "Issue Date *" : issueDate
                          ),
                        ),
                      )),
                      commonHorizontalSpacing(spacing: 10),
                      Expanded(child: InkWell(
                        onTap: (){
                          showDialog(context: context, barrierDismissible: false,builder: (BuildContext context) => monthSelectionView(callback: (String val){
                            setState(() {
                              expirationDate = val;
                            });
                          }));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: neurmorphicBoxDecoration,
                          child: commonHeaderTitle(
                              title: expirationDate.isEmpty ? "Expiration Date *" : expirationDate
                          ),
                        ),
                      ))
                    ],
                  ),
                  commonVerticalSpacing(spacing: 15),
                  commonCheckBoxTile(title: "This credential does not expire",callback: (bool val){
                    setState(() {
                      isCredNotExpire = val;
                    });
                  },isSelected: isCredNotExpire),
                  commonVerticalSpacing(spacing: 15),
                  CommonTextFiled(
                      fieldTitleText: "Credential ID",
                      hintText: "Credential ID",
                      // isBorderEnable: false,
                      textEditingController: credIdController,
                      onChangedFunction: (String value){
                      },
                      validationFunction: (String value) {
                        return value.toString().isEmpty
                            ? notEmptyFieldMessage
                            : null;
                      }),
                  commonVerticalSpacing(),
                  CommonTextFiled(
                      fieldTitleText: "Credential URL",
                      hintText: "Credential URL",
                      // isBorderEnable: false,
                      textEditingController: credURLController,
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
