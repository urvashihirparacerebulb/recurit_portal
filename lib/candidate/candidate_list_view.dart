import 'package:cerebulb_recruit_portal/controllers/candidate_controller.dart';
import 'package:cerebulb_recruit_portal/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widgets/common_widgets_view.dart';
import '../utility/screen_utility.dart';

class CandidateListView extends StatefulWidget {
  const CandidateListView({Key? key}) : super(key: key);

  @override
  State<CandidateListView> createState() => _CandidateListViewState();
}

class _CandidateListViewState extends State<CandidateListView> {

  @override
  void initState() {
    CandidateController.to.getCandidateListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return commonStructure(
      context: context,
      appBar: commonAppbar(context: context,title: "Needle Record List"),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => CandidateController.to.candidateList.isEmpty ? Center(
          child: commonHeaderTitle(title: "Records Not Found",fontWeight: 3,fontSize: isTablet() ? 1.5 : 1.2),
        ) : ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                // CandidateController.to.candidateId.value = (CandidateController.to.candidateList[index].candidateId ?? "").toString();
                Get.to(() => const DashboardScreen());
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: neurmorphicBoxDecoration,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonHeaderTitle(
                          title: CandidateController.to.candidateList[index].name ?? "",
                          fontWeight: 3,
                          fontSize: 1.2
                        ),
                        commonHorizontalSpacing(),
                        commonHeaderTitle(
                          title: CandidateController.to.candidateList[index].candidateUniqueId ?? "",
                          fontSize: 1.1
                        )
                      ],
                    ),
                    commonVerticalSpacing(),
                    commonHeaderTitle(
                      title: CandidateController.to.candidateList[index].email ?? "",
                      fontSize: 1.1
                    ),
                    commonVerticalSpacing(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonHeaderTitle(
                          title: CandidateController.to.candidateList[index].phone ?? "",
                          fontSize: 1.1
                        ),
                        commonHorizontalSpacing(),
                        commonHeaderTitle(
                          title: (CandidateController.to.candidateList[index].status ?? "").toUpperCase(),
                          fontWeight: 2,
                          fontSize: 1.2
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          })),
      )
    );
  }
}
