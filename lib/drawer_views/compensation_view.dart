import 'package:flutter/material.dart';

import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widgets_view.dart';
import '../controllers/candidate_controller.dart';
import '../utility/constants.dart';
import '../utility/screen_utility.dart';

class CompensationView extends StatefulWidget {
  const CompensationView({Key? key}) : super(key: key);

  @override
  State<CompensationView> createState() => _CompensationViewState();
}

class _CompensationViewState extends State<CompensationView> {
  TextEditingController currentCTCController = TextEditingController();
  TextEditingController expectedCTCController = TextEditingController();
  bool isNegotiable = false;

  @override
  void initState() {
    CandidateController.to.getCandidateCompensationInfo(callback: (){
      var val = CandidateController.to.candidateDetail.value;
      currentCTCController.text = val.currentCtc ?? "";
      expectedCTCController.text = val.expectedCtc ?? "";
      isNegotiable = val.negotiable == null ? false : (val.negotiable == "Yes" ? true : false);
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
                commonHeaderTitle(title: "Compensation Information", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
                // commonFillButtonView(
                //     context: context,
                //     title: "ADD",
                //     width: 70,
                //     height: 35,
                //     tapOnButton: () {
                //
                //     },
                //     isLoading: false)
              ],
            ),
            commonVerticalSpacing(),
            CommonTextFiled(
                fieldTitleText: "Current CTC *",
                hintText: "Current CTC *",
                // isBorderEnable: false,
                textEditingController: currentCTCController,
                onChangedFunction: (String value){
                },
                validationFunction: (String value) {
                  return value.toString().isEmpty
                      ? notEmptyFieldMessage
                      : null;
                }),
            commonVerticalSpacing(),
            CommonTextFiled(
                fieldTitleText: "Expected CTC *",
                hintText: "Expected CTC *",
                // isBorderEnable: false,
                textEditingController: expectedCTCController,
                onChangedFunction: (String value){
                },
                validationFunction: (String value) {
                  return value.toString().isEmpty
                      ? notEmptyFieldMessage
                      : null;
                }),
            commonVerticalSpacing(),
            commonCheckBoxTile(title: "Negotiable",callback: (bool val){
              setState(() {
                isNegotiable = val;
              });
            },isSelected: isNegotiable),
          ],
        ),
      )
    );
  }
}
