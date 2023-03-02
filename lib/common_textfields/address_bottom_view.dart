import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widgets_view.dart';
import '../models/address_model.dart';

class AddressBottomView extends StatefulWidget {
  final String title;
  final List<CountryState> myItems;
  final Function? selectionCallBack;
  const AddressBottomView({Key? key, required this.myItems, this.selectionCallBack, required this.title}) : super(key: key);

  @override
  State<AddressBottomView> createState() => _AddressBottomViewState();
}

class _AddressBottomViewState extends State<AddressBottomView> {
  TextEditingController searchController = TextEditingController();
  List<CountryState> searchedItems = [];

  @override
  void initState() {
    searchedItems = List.from(widget.myItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ListView(
        shrinkWrap: true,
        children: [
          commonVerticalSpacing(spacing: 15),
          commonHeaderTitle(title: widget.title,fontWeight: 2,fontSize: 1.5),
          commonVerticalSpacing(spacing: 15),
          CommonTextFiled(
            fieldTitleText: "Search",
            hintText: "Search",
            // isBorderEnable: false,
            isChangeFillColor: true,
            textEditingController: searchController,
            onChangedFunction: (String value){
              setState(() {
                if(value.isEmpty){
                  searchedItems = widget.myItems;
                }else{
                  searchedItems = widget.myItems.where((p0) => widget.title == "Zip/Postal Code *" ? p0.pinCodeNo!.toLowerCase().startsWith(value.toLowerCase()) : p0.name!.toLowerCase().startsWith(value.toLowerCase())).toList();
                }
              });
            },
          ),
          commonVerticalSpacing(spacing: 30),
          ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: searchedItems.length,
              itemBuilder: (context, index) => InkWell(
                onTap: (){
                  Get.back();
                  widget.selectionCallBack!(searchedItems[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: commonHeaderTitle(
                      title: widget.title == "Zip/Postal Code *" ? searchedItems[index].pinCodeNo ?? "" : searchedItems[index].name ?? "",
                      fontSize: 1.2
                  ),
                ),
              )
          ),
          commonVerticalSpacing(spacing: 30),
        ],
      ),
    );
  }
}
