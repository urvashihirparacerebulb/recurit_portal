import 'dart:io';

import 'package:cerebulb_recruit_portal/models/candidate_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  bool isAdd = false;
  bool isEdit = false;
  Attachments? selectedAttachment;
  List<ImageModel>? otherAttachmentsImages = [];

  @override
  void initState() {
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
                ) : Expanded(child: (selectedAttachment != null && selectedFile == null) ?
                (title == "Resume" ? selectedAttachment!.resume == null :
                selectedAttachment!.coverLetter == null) ? commonHeaderTitle(
                    title: "No File Chosen",
                    color: blackColor.withOpacity(0.4),
                    isChangeColor: true
                ) : Image.network((title == "Resume" ? (selectedAttachment!.resume ?? "") :
                (selectedAttachment!.coverLetter ?? "")), height: 100) :
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
            itemCount: otherAttachmentsImages?.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if(otherAttachmentsImages![index].filePath == null){
                return InkWell(
                  onTap: (){
                    launchInBrowser(otherAttachmentsImages![index].link ?? "");
                  },
                  child: GetUtils.isPDF(otherAttachmentsImages![index].link ?? "") ?
                  const Icon(Icons.picture_as_pdf_outlined,color: dangerColor,size: 100,) : Image.network(otherAttachmentsImages![index].link ?? "", height: 100),
                );
              }
              return Image.file(otherAttachmentsImages![index].filePath!, height: 100);
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Attachment Information", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
                commonFillButtonView(
                    context: context,
                    title: "SAVE",
                    width: 70,
                    height: 35,
                    tapOnButton: () {
                      // CandidateController.to.editAttachmentsInfo(
                      //   coverLetter:
                      // );
                    },
                    isLoading: false
                )
              ],
            ),
            commonVerticalSpacing(),
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
        ),
      )
    );
  }
}
