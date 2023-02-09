import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../common_widgets/common_widgets_view.dart';
import '../utility/color_utility.dart';
import '../utility/screen_utility.dart';

class AttachmentsView extends StatefulWidget {
  const AttachmentsView({Key? key}) : super(key: key);

  @override
  State<AttachmentsView> createState() => _AttachmentsViewState();
}

class _AttachmentsViewState extends State<AttachmentsView> {
  File? resumeImage;
  File? coverLetterImage;
  File? attachmentsImage;

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
                    title: "ADD",
                    width: 70,
                    height: 35,
                    tapOnButton: () {

                    },
                    isLoading: false)
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
            imageView(title: "Other Attachments", onChanged: (File file){
              setState(() {
                attachmentsImage = file;
              });
            },selectedFile: attachmentsImage),
          ],
        ),
      )
    );
  }
}
