import 'package:get/get.dart';
import 'package:snap_share_orange/presentation/state_holders/forgot_password_screen_controller.dart';
import 'package:snap_share_orange/presentation/state_holders/log_in_screen_controller.dart';
import 'package:snap_share_orange/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:snap_share_orange/presentation/state_holders/sign_up_screen_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(LogInScreenController());
    Get.put(SignUpScreenController());
    Get.put(ForgotPasswordScreenController());
  }
}
