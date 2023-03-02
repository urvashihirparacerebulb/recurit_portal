import 'package:cerebulb_recruit_portal/controllers/candidate_controller.dart';
import 'package:cerebulb_recruit_portal/utility/color_utility.dart';
import 'package:cerebulb_recruit_portal/utility/common_methods.dart';
import 'package:cerebulb_recruit_portal/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../common_textfields/common_bottom_string_view.dart';
import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widgets_view.dart';
import '../utility/screen_utility.dart';

class BasicInformationView extends StatefulWidget {
  const BasicInformationView({Key? key}) : super(key: key);

  @override
  State<BasicInformationView> createState() => _BasicInformationViewState();
}

class _BasicInformationViewState extends State<BasicInformationView> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController secondaryEmailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController otherMobileController = TextEditingController();
  String selectedGender = "";
  String expInYears = "";
  String expInMonths = "";
  String dateOfBirth = DateFormat("yyyy-MM-dd").format(DateTime.now());
  bool isEdit = false;

  @override
  void initState() {
    updateInfoRefresh();
    super.initState();
  }

  updateInfoRefresh(){
    CandidateController.to.getCandidateBasicInfo(callback: (){
      var val = CandidateController.to.candidateDetail.value;
      nameController.text = val.name ?? "";
      emailController.text = val.email ?? "";
      secondaryEmailController.text = val.emailTwo ?? "";
      selectedGender = val.gender ?? "";
      if(val.dateOfBirth != null) {
        dateOfBirth = val.dateOfBirth ?? "";
      }
      mobileController.text = val.phone ?? "";
      otherMobileController.text = val.phoneTwo ?? "";
      expInYears = val.totalExperienceYear ?? "";
      expInMonths = val.totalExperienceMonth ?? "";
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      bottomNavigation: Padding(
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
                      CandidateController.to.updateBasicInformation(
                          infoId: CandidateController.to.candidateDetail.value.candidateId.toString(),
                          name: nameController.text,
                          dob: dateOfBirth,email: emailController.text,
                          emailTwo: secondaryEmailController.text,gender: selectedGender,pDialCode: CandidateController.to.candidateDetail.value.phoneDialCode,
                          pCountryCode: CandidateController.to.candidateDetail.value.phoneCountryCode,
                          pTwoCountryCode: CandidateController.to.candidateDetail.value.phoneTwoCountryCode,
                          phone: mobileController.text,
                          phoneTwo: otherMobileController.text,
                          pTwoDialCode: CandidateController.to.candidateDetail.value.phoneTwoDialCode,
                          status: CandidateController.to.candidateDetail.value.status,
                          totalExpMonth: expInMonths,
                          totalExpYear: expInYears,
                          callback: (){
                            Get.back();
                          });
                    },
                    isLoading: false)
                )
              ],
            )
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                commonHeaderTitle(title: "Basic Details", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
                commonFillButtonView(
                    context: context,
                    title: "EDIT",
                    width: 70, height: 35,
                    tapOnButton: () {
                      setState(() {
                        isEdit = true;
                      });
                    }, isLoading: false
                )
              ],
            ),
            commonVerticalSpacing(),
            CommonTextFiled(
                fieldTitleText: "Name *",
                hintText: "Name *",
                isEnabled: isEdit,
                // isBorderEnable: false,
                textEditingController: nameController,
                onChangedFunction: (String value){

                },
                validationFunction: (String value) {
                  return value.toString().isEmpty
                      ? notEmptyFieldMessage
                      : null;
                }),
            commonVerticalSpacing(),
            CommonTextFiled(
              fieldTitleText: "Email *",
              hintText: "Email *",
              isEnabled: isEdit,
                // isBorderEnable: false,
              textEditingController: emailController,
              preFixIcon: const Icon(Icons.email,color: blackColor),
              onChangedFunction: (String value){
              },
              validationFunction: (String value) {
                return value.toString().isEmpty
                    ? notEmptyFieldMessage
                    : null;
              }),
            commonVerticalSpacing(),
            CommonTextFiled(
              fieldTitleText: "Secondary Email",
              hintText: "Secondary Email",
              isEnabled: isEdit,
              // isBorderEnable: false,
              textEditingController: secondaryEmailController,
              preFixIcon: const Icon(Icons.email,color: blackColor),
              onChangedFunction: (String value){
              },
              validationFunction: (String value) {
                return value.toString().isEmpty
                    ? notEmptyFieldMessage
                    : null;
              }),
            commonVerticalSpacing(spacing: 20),
            commonHeaderTitle(title: "Gender *", isChangeColor: true, color: Colors.grey,fontSize: 1.0,fontWeight: 2),
            commonVerticalSpacing(spacing: 8),
            InkWell(
              onTap: (){
                commonBottomView(context: context,
                    child: CommonBottomStringView(
                        hintText: "Gender *",
                        myItems: const ["Male","Female", "Other"],
                        selectionCallBack: (
                            String val) {
                          setState(() {
                            selectedGender = val;
                          });
                        }));
              },
              child: commonDecoratedTextView(
                  title: selectedGender == "" ? "Gender" : selectedGender,
                  isChangeColor: selectedGender == "" ? true : false
              ),
            ),
            commonHeaderTitle(title: "Date Of Birth", isChangeColor: true, color: Colors.grey,fontSize: 1.0,fontWeight: 2),
            commonVerticalSpacing(spacing: 8),
            Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: commonHorizontalPadding),
                decoration: neurmorphicBoxDecoration,
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: commonHeaderTitle(
                            fontSize: isTablet() ? 1.3 : 1,
                            title: dateOfBirth.isEmpty ? "Date Of Birth" : dateOfBirth)
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            openCalendarView(
                              context,
                              initialDate: DateTime(DateTime.now().year - 18, 01, 01).toString(),
                            ).then((value) {
                              setState(() {
                                dateOfBirth = DateFormat("yyyy-MM-dd").format(value);
                              });
                            });
                          },
                          child: Icon(Icons.calendar_month, color: blackColor.withOpacity(0.4)),
                        )),
                  ],
                )),
            commonVerticalSpacing(),
            CommonTextFiled(
              fieldTitleText: "Mobile *",
              hintText: "Mobile *",
              isEnabled: isEdit,
              // isBorderEnable: false,
              textEditingController: mobileController,
              inputFormatter: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
              preFixIcon: const Icon(Icons.phone,color: blackColor),
              onChangedFunction: (String value){
              },
              validationFunction: (String value) {
                return value.toString().isEmpty
                    ? notEmptyFieldMessage
                    : null;
              },),

            commonVerticalSpacing(),
            CommonTextFiled(
              fieldTitleText: "Other Mobile No ",
              hintText: "Other Mobile No ",
              isEnabled: isEdit,
                // isBorderEnable: false,
              textEditingController: otherMobileController,
              inputFormatter: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
              preFixIcon: const Icon(Icons.phone,color: blackColor),
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
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonVerticalSpacing(),
                    commonHeaderTitle(title: "Total Experience *", isChangeColor: true, color: Colors.grey,fontSize: 1.0,fontWeight: 2),
                    commonVerticalSpacing(spacing: 8),
                    InkWell(
                      onTap: (){
                        commonBottomView(context: context,
                            child: CommonBottomStringView(
                                hintText: "Total Experience *",
                                myItems: const ["0 Years","1 Years", "2 Years", "3 Years", "4 Years", "5 Years", "6 Years", "7 Years", "8 Years", "9 Years", "10 Years",
                                  "11 Years", "12 Years", "13 Years", "14 Years", "15 Years", "16 Years", "17 Years", "18 Years", "19 Years", "20 Years"
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
                    ),
                  ],
                )),
                commonHorizontalSpacing(),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonVerticalSpacing(),
                    commonHeaderTitle(title: "Select Month", isChangeColor: true, color: Colors.grey,fontSize: 1.0,fontWeight: 2),
                    commonVerticalSpacing(spacing: 8),
                    InkWell(
                      onTap: (){
                        commonBottomView(context: context,
                            child: CommonBottomStringView(
                                hintText: "Select Month",
                                myItems: const ["0 Months","1 Months", "2 Months", "3 Months", "4 Months", "5 Months",
                                  "6 Months", "7 Months", "8 Months", "9 Months", "10 Months", "11 Months", "12 Months"
                                ],
                                selectionCallBack: (String val) {
                                  setState(() {
                                    expInMonths = val;
                                  });
                                })
                        );
                      },
                      child: commonDecoratedTextView(
                          title: expInMonths == "" ? "Months" : expInMonths,
                          isChangeColor: expInMonths == "" ? true : false,
                      ),
                    ),
                  ],
                )),
              ],
            )
          ],
        ),
      )
    );
  }
}
