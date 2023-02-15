import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_textfields/common_bottom_string_view.dart';
import '../common_widgets/common_widgets_view.dart';
import '../controllers/candidate_controller.dart';
import '../utility/screen_utility.dart';

class QuestionaryView extends StatefulWidget {
  const QuestionaryView({Key? key}) : super(key: key);

  @override
  State<QuestionaryView> createState() => _QuestionaryViewState();
}

class _QuestionaryViewState extends State<QuestionaryView> {
  bool isReadyToRelocate = false;
  bool isPermanentWFH = false;
  bool isCandidateAccept = false;
  String selectedNoticePeriod = "";
  String expInYears = "";
  String expInMonths = "";
  bool isEdit = false;

  @override
  void initState() {
    CandidateController.to.getCandidateQuestionaryInfo(callback: (){
      var val = CandidateController.to.candidateDetail.value;
      isReadyToRelocate = val.relocateStatus == null ? false : (val.relocateStatus == "Yes" ? true : false);
      isPermanentWFH = val.workFromHome == null ? false : (val.workFromHome == "Yes" ? true : false);
      isCandidateAccept = val.bondStatus == null ? false : (val.bondStatus == "Yes" ? true : false);
      if(isCandidateAccept) {
        expInYears = "${val.bondYears ?? ""} Years";
        expInMonths = "${val.bondMonths ?? ""} Months";
      }
      selectedNoticePeriod = "${val.noticePeriod ?? ""} Days";
      setState(() {});
    });
    super.initState();
  }

  List<String> getDaysList(){
    List<String> list = [];
    for(int i = 1; i < 181; i ++){
      list.add('$i Days');
    }
    return list;
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
                        CandidateController.to.updateQuestionaryView(
                          bondStatus: isCandidateAccept,
                           relocateStatus: isReadyToRelocate,
                           wfh: isPermanentWFH,
                           months: expInMonths,
                           years: expInYears,
                           noticePeriod: selectedNoticePeriod,
                           status: CandidateController.to.candidateDetail.value.status,
                            callback: (){
                              Get.back();
                            });
                      },
                      isLoading: false)
                  )
                ],
              )
          ),
        ) : Container(height: 0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonHeaderTitle(title: "Questionary", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
                  commonFillButtonView(
                      context: context,
                      title: "Edit",
                      width: 70,
                      height: 35,
                      tapOnButton: () {

                      },
                      isLoading: false)
                ],
              ),
              commonVerticalSpacing(),
              commonCheckBoxTile(title: "Ready to relocate?",callback: (bool val){
                setState(() {
                  isReadyToRelocate = val;
                });
              },isSelected: isReadyToRelocate),
              commonCheckBoxTile(title: "Permanent work from home?",callback: (bool val){
                setState(() {
                  isPermanentWFH = val;
                });
              },isSelected: isPermanentWFH),
              commonCheckBoxTile(title: "Candidate Accept Bond?",callback: (bool val){
                setState(() {
                  isCandidateAccept = val;
                });
              },isSelected: isCandidateAccept),
              commonVerticalSpacing(),

              isCandidateAccept ? Row(
                children: [
                  Expanded(child: InkWell(
                    onTap: (){
                      commonBottomView(context: context,
                          child: CommonBottomStringView(
                              hintText: "Bond Time",
                              myItems: const ["0 Years","1 Years", "2 Years", "3 Years", "4 Years", "5 Years", "6 Years", "7 Years", "8 Years", "9 Years", "10 Years"
                                ,"11 Years", "12 Years", "13 Years", "14 Years", "15 Years", "16 Years", "17 Years", "18 Years", "19 Years", "20 Years"
                              ],
                              selectionCallBack: (
                                  String val) {
                                setState(() {
                                  expInYears = val;
                                });
                              }));
                    },
                    child: commonDecoratedTextView(
                        title: expInYears == "" ? "Years" : expInYears,
                        isChangeColor: expInYears == "" ? true : false
                    ),
                  )),
                  commonHorizontalSpacing(),
                  Expanded(child: InkWell(
                    onTap: (){
                      commonBottomView(context: context,
                          child: CommonBottomStringView(
                              hintText: "Select Month",
                              myItems: const ["0 Months","1 Months", "2 Months", "3 Months", "4 Months", "5 Months"
                                , "6 Months", "7 Months", "8 Months", "9 Months", "10 Months", "11 Months", "12 Months"
                              ],
                              selectionCallBack: (
                                  String val) {
                                setState(() {
                                  expInMonths = val;
                                });
                              }));
                    },
                    child: commonDecoratedTextView(
                        title: expInMonths == "" ? "Months" : expInMonths,
                        isChangeColor: expInMonths == "" ? true : false
                    ),
                  )),
                ],
              ) : Container(),

              commonVerticalSpacing(),
              InkWell(
                onTap: (){
                  commonBottomView(context: context,
                      child: CommonBottomStringView(
                          hintText: "Days",
                          myItems: getDaysList(),
                          selectionCallBack: (
                              String val) {
                            setState(() {
                              selectedNoticePeriod = val;
                            });
                          }));
                },
                child: commonDecoratedTextView(
                    title: selectedNoticePeriod == "" ? "Days" : selectedNoticePeriod,
                    isChangeColor: selectedNoticePeriod == "" ? true : false
                ),
              )
            ],
          ),
        )
    );
  }
}
