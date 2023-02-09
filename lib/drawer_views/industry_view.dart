import 'package:flutter/material.dart';

import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widgets_view.dart';
import '../controllers/candidate_controller.dart';
import '../utility/constants.dart';
import '../utility/screen_utility.dart';

class IndustryView extends StatefulWidget {
  const IndustryView({Key? key}) : super(key: key);

  @override
  State<IndustryView> createState() => _IndustryViewState();
}

class _IndustryViewState extends State<IndustryView> {
  TextEditingController industryNameController = TextEditingController();
  TextEditingController industryExpertiseController = TextEditingController();

  @override
  void initState() {
    CandidateController.to.getIndustryInfo(callback: (){
      var val = CandidateController.to.candidateDetail.value;
      industryNameController.text = val.industryName ?? "";
      industryExpertiseController.text = val.expertise ?? "";
      setState(() {});
    });
    super.initState();
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
                commonHeaderTitle(title: "Industry Information", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
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

            CommonTextFiled(
                fieldTitleText: "Industry Name *",
                hintText: "Industry Name *",
                // isBorderEnable: false,
                textEditingController: industryNameController,
                onChangedFunction: (String value){
                },
                validationFunction: (String value) {
                  return value.toString().isEmpty
                      ? notEmptyFieldMessage
                      : null;
                }),
            commonVerticalSpacing(),
            CommonTextFiled(
                fieldTitleText: "Industry Expertise",
                hintText: "Industry Expertise",
                // isBorderEnable: false,
                maxLine: 5,
                textEditingController: industryExpertiseController,
                onChangedFunction: (String value){
                },
                validationFunction: (String value) {
                  return value.toString().isEmpty
                      ? notEmptyFieldMessage
                      : null;
                }),
          ],
        ),
      )
    );
  }
}
