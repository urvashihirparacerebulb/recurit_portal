import 'dart:io';

import 'package:cerebulb_recruit_portal/common_widgets/common_methods.dart';
import 'package:cerebulb_recruit_portal/configurations/config_file.dart';
import 'package:cerebulb_recruit_portal/models/candidate_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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

class IdentificationView extends StatefulWidget {
  const IdentificationView({Key? key}) : super(key: key);

  @override
  State<IdentificationView> createState() => _IdentificationViewState();
}

class _IdentificationViewState extends State<IdentificationView> {

  TextEditingController idTypeController = TextEditingController();
  TextEditingController idNoController = TextEditingController();
  TextEditingController issuingAuthorityController = TextEditingController();
  String issuingDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String expiryDate =  DateFormat("yyyy-MM-dd").format(DateTime.now());
  File? attachmentImage;
  bool isAdd = false;
  bool isEdit = false;
  Identification? selectedIdentification;

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
                selectedFile == null && !isEdit ? commonHeaderTitle(
                    title: "No File Chosen",
                    color: blackColor.withOpacity(0.4),
                    isChangeColor: true
                ) : Expanded(child: (selectedIdentification != null && selectedFile == null) ?
                  Image.network(selectedIdentification!.attachment ?? "", height: 100) :
                  Image.file(selectedFile!, height: 100)
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPopupMenu(Offset offset,Identification identification) async {
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
                      selectedIdentification = identification;
                      idTypeController.text = identification.idType ?? "";
                      idNoController.text = identification.idNumber ?? "";
                      issuingAuthorityController.text = identification.issuedAuthority ?? "";
                      issuingDate = identification.issuedDate ?? "";
                      expiryDate = identification.expiredDate ?? "";
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
                    Get.back();
                    showDialog(context: context, builder: (BuildContext context) => DeleteDialogView(doneCallback: (){
                      CandidateController.to.deleteIdentification(id: (identification.id ?? "").toString());
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
                  onTap: () async {
                    Get.back();
                    var tempDir = await getApplicationDocumentsDirectory();
                    String fullPath = tempDir.path;
                    if(identification.attachment != null && identification.attachment!.isNotEmpty){
                      download2(APIProvider.getDio(), identification.attachment ?? "", fullPath);
                    }
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.download),
                      commonHorizontalSpacing(),
                      const Text('Download'),
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
                  commonHeaderTitle(title: "Identification", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
                  isAdd ? commonFillButtonView(
                      context: context,
                      title: "SAVE",
                      width: 70,
                      height: 35,
                      tapOnButton: () {
                        if(idTypeController.text.isNotEmpty && idNoController.text.isNotEmpty && issuingAuthorityController.text.isNotEmpty) {
                          CandidateController.to.addEditIdentificationView(
                              idType: idTypeController.text,
                              idNumber: idNoController.text,
                              issuedAuthority: issuingAuthorityController.text,
                              issuedDate: DateFormat("yyyy-MM-dd").format(
                                  DateTime.parse(issuingDate)),
                              expiryDate: DateFormat("yyyy-MM-dd").format(
                                  DateTime.parse(expiryDate)),
                              attachment: attachmentImage,
                              isEdit: isEdit,
                              indentificationId: selectedIdentification != null
                                  ? selectedIdentification!.id.toString()
                                  : "",
                              status: selectedIdentification != null
                                  ? selectedIdentification!.status
                                  : "Active",
                              callback: () {
                                CandidateController.to
                                    .getIdentificationInfoList();
                                setState(() {
                                  isAdd = false;
                                  isEdit = false;
                                });
                              }
                          );
                        }else{
                          showSnackBar(title: ApiConfig.error, message: "Fill all remaining fields");
                        }
                      },
                      isLoading: false) : commonFillButtonView(
                      context: context,
                      title: "ADD",
                      width: 70,
                      height: 35,
                      tapOnButton: () {
                        setState(() {
                          isAdd = true;
                          idTypeController.text = "";
                          idNoController.text = "";
                          issuingAuthorityController.text = "";
                          attachmentImage = null;
                        });
                      },
                      isLoading: false)
                ],
              ),
              commonVerticalSpacing(),
              Obx(() => !isAdd ? ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: CandidateController.to.identificationList.map((e) => Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: neurmorphicBoxDecoration,
                    child: Row(
                      children: [
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
                                            _showPopupMenu(details.globalPosition,e);
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
              ) : ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                                          issuingDate = DateFormat("yyyy-MM-dd").format(value);
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
                                          expiryDate = DateFormat("yyyy-MM-dd").format(value);
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
