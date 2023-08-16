import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../common_textfields/address_bottom_view.dart';
import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widgets_view.dart';
import '../controllers/address_controller.dart';
import '../models/address_model.dart';
import '../utility/color_utility.dart';
import '../utility/constants.dart';

class AddPinCodeView extends StatefulWidget {
  final Function doneCallback;
  final String country;
  final String state;
  const AddPinCodeView({Key? key, required this.doneCallback, required this.country, required this.state}) : super(key: key);

  @override
  State<AddPinCodeView> createState() => _AddPinCodeViewState();
}

class _AddPinCodeViewState extends State<AddPinCodeView> {
  // TextEditingController stateController = TextEditingController();
  // TextEditingController countryController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  CountryState? selectedCountry;
  CountryState? selectedState;
  CountryState? selectedCity;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: pinCodeView(context),
    );
  }

  Widget pinCodeView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Container(
        padding: const EdgeInsets.only(top: 18.0),
        margin: const EdgeInsets.only(top: 13.0, right: 8.0),
        decoration: BoxDecoration(
            color: whiteColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 0.0,
                offset: Offset(0.0, 0.0),
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            shrinkWrap: true,
            // mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              commonVerticalSpacing(spacing: 20),
              commonHeaderTitle(title: "Country *", isChangeColor: true, color: Colors.grey,fontSize: 1.0,fontWeight: 2),
              commonVerticalSpacing(spacing: 8),
              InkWell(
                onTap: (){
                  commonBottomView(context: context,
                      child: AddressBottomView(
                          title: "Country *",
                          myItems: AddressController.to.countriesList.value,
                          selectionCallBack: (CountryState val) {
                            AddressController.to.getStatesList(callback: (){},countryId: val.id.toString());
                            selectedState = null;
                            selectedCity = null;
                            setState(() {
                              selectedCountry = val;
                            });
                          })
                  );
                },
                child: commonDecoratedTextView(
                    bottom: 10,
                    title: selectedCountry == null ? "Select Country" : selectedCountry!.name ?? "",
                    isChangeColor: selectedCountry == null ? true : false
                ),
              ),
              commonVerticalSpacing(spacing: 20),
              commonHeaderTitle(title: "State/Province *", isChangeColor: true, color: Colors.grey,fontSize: 1.0,fontWeight: 2),
              commonVerticalSpacing(spacing: 8),
              InkWell(
                onTap: (){
                  commonBottomView(context: context,
                      child: AddressBottomView(
                          title: "State/Province *",
                          myItems: AddressController.to.statesList.value,
                          selectionCallBack: (CountryState val) {
                            AddressController.to.getCitiesList(callback: (){},stateId: val.id.toString());
                            selectedCity = null;
                            setState(() {
                              selectedState = val;
                            });
                          })
                  );
                },
                child: commonDecoratedTextView(
                    bottom: 10,
                    title: selectedState == null ? "Select State/Province" : selectedState!.name ?? "",
                    isChangeColor: selectedState == null ? true : false
                ),
              ),
              commonVerticalSpacing(spacing: 20),
              commonHeaderTitle(title: "City *", isChangeColor: true, color: Colors.grey,fontSize: 1.0,fontWeight: 2),
              commonVerticalSpacing(spacing: 8),
              InkWell(
                onTap: (){
                    commonBottomView(context: context,
                        child: AddressBottomView(
                            title: "City *",
                            myItems: AddressController.to.citiesList.value,
                            selectionCallBack: (CountryState val) {
                              setState(() {
                                selectedCity = val;
                              });
                            })
                    );
                },
                child: commonDecoratedTextView(
                    bottom: 10,
                    title: selectedCity == null ? "Select City" : selectedCity!.name ?? "",
                    isChangeColor: selectedCity == null ? true : false
                ),
              ),
              commonVerticalSpacing(),
              CommonTextFiled(
                  fieldTitleText: "Zip/Postal Code",
                  hintText: "Zip/Postal Code",
                  textEditingController: pinCodeController,
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  }),
              commonVerticalSpacing(),
              SizedBox(
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
                            if(selectedCity != null && pinCodeController.text.isNotEmpty) {
                              widget.doneCallback(
                                  selectedCity, pinCodeController.text);
                            }
                          },
                          isLoading: false)
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
