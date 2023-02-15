import 'package:cerebulb_recruit_portal/utility/color_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common_widgets/common_textfield.dart';
import '../common_widgets/common_widgets_view.dart';
import '../controllers/candidate_controller.dart';
import '../models/candidate_model.dart';
import '../utility/constants.dart';
import '../utility/delete_dialog_view.dart';
import '../utility/screen_utility.dart';

class SkillsView extends StatefulWidget {
  const SkillsView({Key? key}) : super(key: key);

  @override
  State<SkillsView> createState() => _SkillsViewState();
}

class _SkillsViewState extends State<SkillsView> {
  TextEditingController skillsController = TextEditingController();
  String selectedSkillTag = "1";

  @override
  void initState() {
    CandidateController.to.getSkillsInfoList();
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
            commonHeaderTitle(title: "Skills", fontSize: isTablet() ? 1.5 : 1.3, fontWeight: 4),
            commonVerticalSpacing(),
            CommonTextFiled(
                fieldTitleText: "Skill Name",
                hintText: "Enter skill name",
                // isBorderEnable: false,
                textEditingController: skillsController,
                onChangedFunction: (String value){
                },
                suffixIcon: commonFillButtonView(
                    context: context,
                    title: "ADD",
                    width: 100,
                    height: 35,
                    tapOnButton: () {
                      setState(() {
                        Skills skill = Skills();
                        skill.skill = skillsController.text;
                        skill.level = (selectedSkillTag == "1" ? "Master" : selectedSkillTag == "2" ? "Intermediate" : "Beginner");
                        CandidateController.to.addEditSkillsView(
                          status: "Active",
                          level: skill.level,
                          skill: skill.skill ?? "",
                          callback: (){
                            CandidateController.to.skillsList.add(skill);
                            skillsController.text = "";
                          }
                        );
                      });
                    },
                    isLoading: false),
                validationFunction: (String value) {
                  return value.toString().isEmpty
                      ? notEmptyFieldMessage
                      : null;
                }),
            commonVerticalSpacing(),
            Row(
              children: [
                Expanded(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Radio<String>(
                        value: '1',
                        groupValue: selectedSkillTag,
                        activeColor: greenColor,
                        onChanged: (value) {
                          setState(() {
                            selectedSkillTag = value!;
                          });
                        },
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text('Master'),
                    ),

                    Container(
                      width: 70,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: greenColor
                      ),
                    )
                  ],
                )),

                Expanded(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Radio<String>(
                        value: '2',
                        groupValue: selectedSkillTag,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          setState(() {
                            selectedSkillTag = value!;
                          });
                        },
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text('Intermediate'),
                    ),

                    Container(
                      width: 70,
                      height: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor
                      ),
                    )
                  ],
                )),
                Expanded(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Radio<String>(
                        value: '3',
                        groupValue: selectedSkillTag,
                        activeColor: dangerColor,
                        onChanged: (value) {
                          setState(() {
                            selectedSkillTag = value!;
                          });
                        },
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text('Beginner'),
                    ),

                    Container(
                      width: 70,
                      height: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: dangerColor
                      ),
                    )
                  ],
                ))
              ],
            ),
            commonVerticalSpacing(spacing: 20),
            Obx(() => Wrap(
              spacing: 8,
              runSpacing: 8,
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              children: CandidateController.to.skillsList.map((i) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: i.level == "Master" ? greenColor : i.level == "Intermediate" ? primaryColor : dangerColor,
                      )
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(i.skill ?? "",style: TextStyle(
                          color: i.level == "Master" ? greenColor : i.level == "Intermediate" ? primaryColor : dangerColor,
                          fontSize: 14,
                        fontWeight: FontWeight.w500
                      )),
                      commonHorizontalSpacing(),
                      InkWell(
                          onTap: (){
                            // CandidateController.to.skillsList.remove(i);
                            // Get.back();
                            showDialog(context: context, builder: (BuildContext context) => DeleteDialogView(doneCallback: (){
                              CandidateController.to.deleteSkill(skillId: (i.id ?? "").toString());
                            }));
                          },
                          child: const Icon(Icons.close,
                              color: blackColor,
                              size: 20))
                    ],
                  )
              )).toList(),
            ))
          ],
        ),
      )
    );
  }
}


// class SelectedSkills{
//   String? title;
//   String? selectedColor;
// }