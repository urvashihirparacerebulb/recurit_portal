import 'package:get/get.dart';

import '../controllers/address_controller.dart';
import '../controllers/authentication_controller.dart';
import '../controllers/candidate_controller.dart';
import '../controllers/general_controller.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<GeneralController>(GeneralController(), permanent: true);
    Get.put<CandidateController>(CandidateController(), permanent: true);
    Get.put<AuthenticationController>(AuthenticationController(), permanent: true);
    Get.put<AddressController>(AddressController(), permanent: true);
  }
}
