
import 'package:flutter/material.dart';

import '../common_textfields/common_bottom_string_view.dart';
import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widgets_view.dart';
import '../controllers/candidate_controller.dart';
import '../utility/constants.dart';
import '../utility/screen_utility.dart';

class AddressView extends StatefulWidget {
  const AddressView({Key? key}) : super(key: key);

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {

  TextEditingController houseNumController = TextEditingController();
  TextEditingController streetLocalityController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  String selectedZipcode = "";
  bool isAddressSame = false;

  TextEditingController correspondenceHouseNumController = TextEditingController();
  TextEditingController correspondenceStreetLocalityController = TextEditingController();
  TextEditingController correspondenceLandmarkController = TextEditingController();
  TextEditingController correspondenceCityController = TextEditingController();
  TextEditingController correspondenceStateController = TextEditingController();
  TextEditingController correspondenceCountryController = TextEditingController();
  String correspondenceSelectedZipcode = "";

  @override
  void initState() {
    CandidateController.to.getCandidateAddressInfo(callback: (){
      var val = CandidateController.to.candidateDetail.value;
      houseNumController.text = val.blockHouseNo ?? "";
      streetLocalityController.text = val.streetLocality ?? "";
      landmarkController.text = val.landmark ?? "";

      if(val.sameCorrespondenceAddress == 1){
        isAddressSame = true;
      }
      correspondenceHouseNumController.text = val.cblockHouseNo ?? "";
      correspondenceStreetLocalityController.text = val.cstreet ?? "";
      correspondenceLandmarkController.text = val.clandmark ?? "";

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
              commonHeaderTitle(title: "Permanent Address", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
              commonVerticalSpacing(),
              CommonTextFiled(
                  fieldTitleText: "Block / House No. *",
                  hintText: "Block / House No. *",
                  // isBorderEnable: false,
                  textEditingController: houseNumController,
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  }),
              commonVerticalSpacing(),
              CommonTextFiled(
                  fieldTitleText: "Street/ Locality *",
                  hintText: "Street/ Locality *",
                  // isBorderEnable: false,
                  textEditingController: streetLocalityController,
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  }),
              commonVerticalSpacing(),
              CommonTextFiled(
                  fieldTitleText: "Landmark *",
                  hintText: "Landmark *",
                  // isBorderEnable: false,
                  textEditingController: landmarkController,
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  }),
              commonVerticalSpacing(),
              InkWell(
                onTap: (){
                  commonBottomView(context: context,
                      child: CommonBottomStringView(
                          hintText: "Zip/Postal Code *",
                          myItems: const ["395006","395008","395007"],
                          selectionCallBack: (
                              String val) {
                            setState(() {
                              selectedZipcode = val;
                            });
                          }));
                },
                child: commonDecoratedTextView(
                    bottom: 10,
                    title: selectedZipcode == "" ? "Select Pin Code" : selectedZipcode,
                    isChangeColor: selectedZipcode == "" ? true : false
                ),
              ),

              CommonTextFiled(
                  fieldTitleText: "City",
                  hintText: "City",
                  // isBorderEnable: false,
                  textEditingController: cityController,
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  }),

              commonVerticalSpacing(),
              CommonTextFiled(
                  fieldTitleText: "State/Province",
                  hintText: "State/Province",
                  // isBorderEnable: false,
                  textEditingController: stateController,
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  }),

              commonVerticalSpacing(),
              CommonTextFiled(
                  fieldTitleText: "Country",
                  hintText: "Country",
                  // isBorderEnable: false,
                  textEditingController: countryController,
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  }),

              commonVerticalSpacing(spacing: 30),
              commonHeaderTitle(title: "Correspondence Address", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
              commonVerticalSpacing(),
              commonCheckBoxTile(title: "Same As Above",callback: (bool val){
                setState(() {
                  isAddressSame = val;
                });
              },isSelected: isAddressSame),
              commonVerticalSpacing(),
              CommonTextFiled(
                  fieldTitleText: "Block / House No. *",
                  hintText: "Block / House No. *",
                  // isBorderEnable: false,
                  textEditingController: correspondenceHouseNumController,
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  }),
              commonVerticalSpacing(),
              CommonTextFiled(
                  fieldTitleText: "Street/ Locality *",
                  hintText: "Street/ Locality *",
                  // isBorderEnable: false,
                  textEditingController: correspondenceStreetLocalityController,
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  }),
              commonVerticalSpacing(),
              CommonTextFiled(
                  fieldTitleText: "Landmark *",
                  hintText: "Landmark *",
                  // isBorderEnable: false,
                  textEditingController: correspondenceLandmarkController,
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  }),
              commonVerticalSpacing(),
              InkWell(
                onTap: (){
                  commonBottomView(context: context,
                      child: CommonBottomStringView(
                          hintText: "Zip/Postal Code *",
                          myItems: const ["395006","395008","395007"],
                          selectionCallBack: (
                              String val) {
                            setState(() {
                              correspondenceSelectedZipcode = val;
                            });
                          }));
                },
                child: commonDecoratedTextView(
                    bottom: 10,
                    title: correspondenceSelectedZipcode == "" ? "Select Pin Code" : correspondenceSelectedZipcode,
                    isChangeColor: correspondenceSelectedZipcode == "" ? true : false
                ),
              ),
              CommonTextFiled(
                  fieldTitleText: "City",
                  hintText: "City",
                  // isBorderEnable: false,
                  textEditingController: correspondenceCityController,
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  }),

              commonVerticalSpacing(),
              CommonTextFiled(
                  fieldTitleText: "State/Province",
                  hintText: "State/Province",
                  // isBorderEnable: false,
                  textEditingController: correspondenceStateController,
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  }),

              commonVerticalSpacing(),
              CommonTextFiled(
                  fieldTitleText: "Country",
                  hintText: "Country",
                  // isBorderEnable: false,
                  textEditingController: correspondenceCountryController,
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
