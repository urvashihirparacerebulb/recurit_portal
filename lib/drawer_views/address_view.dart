import 'package:cerebulb_recruit_portal/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_textfields/address_bottom_view.dart';
import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widgets_view.dart';
import '../controllers/address_controller.dart';
import '../controllers/candidate_controller.dart';
import '../utility/constants.dart';
import '../utility/screen_utility.dart';
import 'add_pincode_view.dart';

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
  CountryState? selectedZipcode;
  CountryState? selectedCountry;
  CountryState? selectedState;
  CountryState? selectedCity;
  bool isAddressSame = false;

  TextEditingController correspondenceHouseNumController = TextEditingController();
  TextEditingController correspondenceStreetLocalityController = TextEditingController();
  TextEditingController correspondenceLandmarkController = TextEditingController();
  TextEditingController correspondenceCityController = TextEditingController();
  TextEditingController correspondenceStateController = TextEditingController();
  TextEditingController correspondenceCountryController = TextEditingController();
  CountryState? correspondenceSelectedZipcode;
  CountryState? correspondenceSelectedCountry;
  CountryState? correspondenceSelectedState;
  CountryState? correspondenceSelectedCity;
  bool isEdit = false;

  @override
  void initState() {
    addressRefresh();
    super.initState();
  }

  addressRefresh(){
    CandidateController.to.getCandidateAddressInfo(callback: (){
      var val = CandidateController.to.candidateDetail.value;
      AddressController.to.getPinCodesList(callback: () {
        AddressController.to.getCountriesList(callback: () {
          selectedCountry = AddressController.to.countriesList.where((p0) => p0.name == "India").toList().first;
          correspondenceSelectedCountry = selectedCountry;
          AddressController.to.getStatesList(countryId: selectedCountry?.id.toString(),callback: (){
            selectedState = AddressController.to.statesList.where((p0) => p0.name == "Gujarat").toList().first;
            correspondenceSelectedState = selectedState;
            AddressController.to.getCitiesList(stateId: selectedState?.id.toString(),callback: (){
              selectedCity = AddressController.to.citiesList.where((p0) => p0.name == "Gandhinagar").toList().first;
              correspondenceSelectedCity = selectedCity;

              CountryState selectedPin = CountryState();
              selectedPin.id = val.pincodeId;
              selectedPin.pinCodeNo = val.pinCodeNo ?? "";
              selectedZipcode = selectedPin;

              CountryState cSelectedPin = CountryState();
              cSelectedPin.id = val.pincodeId;
              cSelectedPin.pinCodeNo = val.pinCodeNo ?? "";
              correspondenceSelectedZipcode = cSelectedPin;

              houseNumController.text = val.blockHouseNo ?? "";
              streetLocalityController.text = val.streetLocality ?? "";
              landmarkController.text = val.landmark ?? "";
              countryController.text = selectedCountry?.name ?? "";
              stateController.text = selectedState?.name ?? "";
              cityController.text = selectedCity?.name ?? "";

              if(val.sameCorrespondenceAddress == 1){
                isAddressSame = true;
              }
              correspondenceHouseNumController.text = val.cblockHouseNo ?? "";
              correspondenceStreetLocalityController.text = val.cstreet ?? "";
              correspondenceLandmarkController.text = val.clandmark ?? "";
              correspondenceCountryController.text = correspondenceSelectedCountry?.name ?? "";
              correspondenceStateController.text = correspondenceSelectedState?.name ?? "";
              correspondenceCityController.text = correspondenceSelectedCity?.name ?? "";

              setState(() {});
            });
          });
        });
      });
    });
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
                  commonHeaderTitle(title: "Address", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
                  isEdit ? Row(
                    children: [
                      commonFillButtonView(
                          context: context,
                          title: "EDIT",
                          width: 70, height: 35,
                          tapOnButton: () {
                            CandidateController.to.updateAddressView(
                                blockNo: houseNumController.text,
                                street: streetLocalityController.text,
                                pinCode: selectedZipcode,
                                cityId: selectedCity?.id,
                                stateId: selectedState?.id,
                                countryId: selectedCountry?.id,
                                cblockNo: correspondenceHouseNumController.text,
                                cCity: correspondenceSelectedCity?.id,
                                cCountry: correspondenceSelectedCountry?.id,
                                cState: correspondenceSelectedState?.id,
                                cLandmark: correspondenceLandmarkController.text,
                                cPinCode: correspondenceSelectedZipcode,
                                cStreet: correspondenceStreetLocalityController.text,
                                landmark: landmarkController.text,
                                sameAddress: isAddressSame,
                                callback: (){
                                  addressRefresh();
                                }
                            );
                          }, isLoading: false
                      ),
                      commonHorizontalSpacing(),
                       commonBorderButtonView(
                           context: context,
                           title: "Cancel",
                           height: 35, width: 80,
                           tapOnButton: () {
                             Get.back();
                           },
                           isLoading: false
                       )
                    ],
                  ) : commonFillButtonView(
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
              commonHeaderTitle(title: "Permanent Address", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
              commonVerticalSpacing(),
              CommonTextFiled(
                  fieldTitleText: "Block / House No. *",
                  hintText: "Block / House No. *",
                  isEnabled: isEdit,
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
                  isEnabled: isEdit,
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
                  isEnabled: isEdit,
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
                  if(isEdit) {
                    commonBottomView(context: context,
                        child: AddressBottomView(
                            title: "Zip/Postal Code *",
                            myItems: AddressController.to.pinCodesList.value,
                            selectionCallBack: (CountryState val) {
                            AddressController.to.getAddressFromPinCode(
                              pinCode: val.pinCodeNo ?? "",
                              callback: (){
                                for (var element in AddressController.to.addressLists) {
                                  if(element.pincodeNo == val.pinCodeNo){
                                    setState(() {
                                      CountryState country = CountryState();
                                      country.id = element.countryId ?? 0;
                                      country.name = element.countryName ?? "";
                                      selectedCountry = country;

                                      CountryState state = CountryState();
                                      state.id = element.stateId ?? 0;
                                      state.name = element.stateName ?? "";
                                      selectedState = state;

                                      CountryState city = CountryState();
                                      city.id = element.cityId ?? 0;
                                      city.name = element.cityName ?? "";
                                      selectedCity = city;

                                      selectedZipcode = val;
                                    });
                                  }
                                }
                              }
                            );
                        })
                    );
                  }
                },
                child: Row(
                  children: [
                    Expanded(child: commonDecoratedTextView(
                        bottom: 10,
                        title: selectedZipcode == null ? "Select Pin Code" : selectedZipcode!.pinCodeNo ?? "",
                        isChangeColor: selectedZipcode == null ? true : false
                    )),
                    commonHorizontalSpacing(),
                    Padding(padding: const EdgeInsets.only(bottom: 8),
                      child: commonFillButtonView(
                          context: context,
                          title: "New Pincode",
                          width: 120, height: 40,
                          tapOnButton: () {
                            showDialog(context: context, builder: (BuildContext context) => AddPinCodeView(country: selectedCountry?.name ?? "",state: selectedState?.name ?? "",doneCallback: (CountryState countryState, String pin){
                              AddressController.to.addNewPinCode(
                                cityId: selectedCity?.id,
                                pinCode: pin,
                                callback: (){
                                  AddressController.to.getPinCodesList(callback: (){});
                                }
                              );
                            }));
                          }, isLoading: false
                      ),
                    )
                  ],
                ),
              ),
              CommonTextFiled(
                  fieldTitleText: "Country",
                  hintText: "Country",
                  isEnabled: false,
                  textEditingController: countryController,
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
                  isEnabled: false,
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
                  fieldTitleText: "City",
                  hintText: "City",
                  isEnabled: false,
                  textEditingController: cityController,
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
                  isEnabled: isEdit,
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
                  isEnabled: isEdit,
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
                  isEnabled: isEdit,
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
                  if(isEdit) {
                    commonBottomView(context: context,
                        child: AddressBottomView(
                            title: "Zip/Postal Code *",
                            myItems: AddressController.to.pinCodesList,
                            selectionCallBack: (CountryState val) {
                              AddressController.to.getAddressFromPinCode(
                                  pinCode: val.pinCodeNo ?? "",
                                  callback: (){
                                    for (var element in AddressController.to.addressLists) {
                                      if(element.pincodeNo == val.pinCodeNo){
                                        setState(() {
                                          CountryState country = CountryState();
                                          country.id = element.countryId ?? 0;
                                          country.name = element.countryName ?? "";
                                          correspondenceSelectedCountry = country;

                                          CountryState state = CountryState();
                                          state.id = element.stateId ?? 0;
                                          state.name = element.stateName ?? "";
                                          correspondenceSelectedState = state;

                                          CountryState city = CountryState();
                                          city.id = element.cityId ?? 0;
                                          city.name = element.cityName ?? "";
                                          correspondenceSelectedCity = city;

                                          correspondenceSelectedZipcode = val;
                                        });
                                      }
                                    }
                                  }
                              );
                            }
                        )
                    );
                  }
                },
                child: Row(
                  children: [
                    Expanded(child: commonDecoratedTextView(
                        bottom: 10,
                        title: correspondenceSelectedZipcode == null ? "Select Pin Code" : correspondenceSelectedZipcode!.pinCodeNo ?? "",
                        isChangeColor: correspondenceSelectedZipcode == null ? true : false
                    )),
                    commonHorizontalSpacing(),
                    Padding(padding: const EdgeInsets.only(bottom: 8),
                      child: commonFillButtonView(
                          context: context,
                          title: "New Pincode",
                          width: 120, height: 40,
                          tapOnButton: () {
                            showDialog(context: context, builder: (BuildContext context) => AddPinCodeView(country: selectedCountry?.name ?? "",state: selectedState?.name ?? "",doneCallback: (CountryState countryState, String pin){
                              AddressController.to.addNewPinCode(
                                  cityId: selectedCity?.id,
                                  pinCode: pin,
                                  callback: (){
                                    AddressController.to.getPinCodesList(callback: (){});
                                  }
                              );
                            }));
                          },
                          isLoading: false
                      ),
                    )
                  ],
                ),
              ),
              CommonTextFiled(
                  fieldTitleText: "Country",
                  hintText: "Country",
                  isEnabled: false,
                  textEditingController: correspondenceCountryController,
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
                  isEnabled: false,
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
                  fieldTitleText: "City",
                  hintText: "City",
                  isEnabled: false,
                  textEditingController: correspondenceCityController,
                  onChangedFunction: (String value){
                  },
                  validationFunction: (String value) {
                    return value.toString().isEmpty
                        ? notEmptyFieldMessage
                        : null;
                  }),
              commonVerticalSpacing(),

            ],
          ),
        )
    );
  }
}
