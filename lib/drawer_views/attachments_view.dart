import 'dart:io';

import 'package:cerebulb_recruit_portal/models/candidate_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../common_widgets/common_widgets_view.dart';
import '../controllers/candidate_controller.dart';
import '../utility/color_utility.dart';
import '../utility/common_methods.dart';
import '../utility/screen_utility.dart';

class AttachmentsView extends StatefulWidget {
  const AttachmentsView({Key? key}) : super(key: key);

  @override
  State<AttachmentsView> createState() => _AttachmentsViewState();
}

class _AttachmentsViewState extends State<AttachmentsView> {
  File? resumeImage;
  File? coverLetterImage;
  bool isEdit = false;
  Attachments? selectedAttachment;
  List<ImageModel>? otherAttachmentsImages = [];

  @override
  void initState() {
    getListOfAttachments();
    super.initState();
  }

  getListOfAttachments(){
    otherAttachmentsImages?.clear();
    CandidateController.to.getAttachmentsList(
        callback: (){
          setState(() {
            selectedAttachment = CandidateController.to.attachmentDetail.value;
            if(selectedAttachment!.otherAttachment!.isNotEmpty){
              otherAttachmentsImages!.addAll(selectedAttachment!.otherAttachment ?? []);
            }
          });
        }
    );
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
                      if(title == "Resume" && selectedAttachment?.resume == null) {
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
                      }else{
                        if(selectedAttachment?.coverLetter == null){
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
                Expanded(child: (selectedAttachment != null) ?
                (title == "Resume" ? (selectedAttachment!.resume == null) :
                (selectedAttachment!.coverLetter == null)) ? commonHeaderTitle(
                    title: "No File Chosen",
                    color: blackColor.withOpacity(0.4),
                    isChangeColor: true
                ) : GetUtils.isPDF(title == "Resume" ? (selectedAttachment!.resume ?? "") :
                (selectedAttachment!.coverLetter ?? "")) ? const Icon(Icons.picture_as_pdf_outlined,color: dangerColor,size: 40) : Image.network((title == "Resume" ? (selectedAttachment!.resume ?? "") :
                (selectedAttachment!.coverLetter ?? "")), height: 100) : selectedFile == null ? commonHeaderTitle(
                    title: "No File Chosen",
                    color: blackColor.withOpacity(0.4),
                    isChangeColor: true
                ) : Image.file(selectedFile, height: 100)
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
      height: otherAttachmentsImages!.isNotEmpty ? 180 : 80,
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
            // shrinkWrap: true,
            itemCount: otherAttachmentsImages?.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if(otherAttachmentsImages![index].filePath == null){
                return Row(
                  children: [
                    InkWell(
                      onTap: (){
                        launchInBrowser(otherAttachmentsImages![index].link ?? "");
                      },
                      child: GetUtils.isPDF(otherAttachmentsImages![index].link ?? "") ?
                      const Icon(Icons.picture_as_pdf_outlined,color: dangerColor,size: 100) :
                      Image.network(otherAttachmentsImages![index].link ?? "", height: 100),
                    ),
                    commonHorizontalSpacing(spacing: 20),
                    InkWell(
                      onTap: (){
                        CandidateController.to.deleteOtherAttachment(
                          docName: otherAttachmentsImages![index].filename ?? "",
                          callback: (){
                            getListOfAttachments();
                          }
                        );
                      },
                      child: const Icon(Icons.delete_forever_outlined, color: dangerColor),
                    ),
                    commonHorizontalSpacing(spacing: 20),
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.file(otherAttachmentsImages![index].filePath!, height: 100),
                  commonHorizontalSpacing(spacing: 20),
                  InkWell(
                    onTap: (){
                      setState(() {
                        otherAttachmentsImages!.removeAt(index);
                      });
                    },
                    child: const Icon(Icons.delete_forever_outlined, color: dangerColor),
                  ),
                  commonHorizontalSpacing(spacing: 20),
                ],
              );
            },
          ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
        bottomNavigation: isEdit ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(child: commonBorderButtonView(
                      context: context,
                      title: "Cancel",
                      height: 50,
                      tapOnButton: () {
                        Get.back();
                      },
                      isLoading: false)),
                  commonHorizontalSpacing(),
                  Expanded(child: commonFillButtonView(
                      context: context,
                      title: "Save",
                      height: 50,
                      tapOnButton: () {
                        CandidateController.to.editAttachmentsInfo(
                          coverLetter: coverLetterImage,
                          resume: resumeImage,
                          otherAttachments: otherAttachmentsImages!,
                          callback: (){
                            getListOfAttachments();
                            isEdit = false;
                          }
                        );
                      },
                      isLoading: false)
                  )
                ],
              )
          ),
        ) : Container(height: 0),
        child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Attachment Information", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
                !isEdit ? commonFillButtonView(
                    context: context,
                    title: "Edit",
                    width: 70,
                    height: 35,
                    tapOnButton: () {
                      setState(() {
                        isEdit = true;
                      });
                    },
                    isLoading: false) : Container()
              ],
            ),
            commonVerticalSpacing(spacing: 20),
            imageView(title: "Resume", onChanged: (File file){
              setState(() {
                resumeImage = file;
              });
            },selectedFile: resumeImage),
            commonVerticalSpacing(spacing: 20),
            imageView(title: "Cover Letter", onChanged: (File file){
              setState(() {
                coverLetterImage = file;
              });
            },selectedFile: coverLetterImage),
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
        ),
      )
    );
  }
}
