import 'package:flutkit/animation/shopping/models/subscription.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  bool showLoading = true, uiLoading = true;
  List<Subscription>? subscriptions;
  late Subscription subscription;
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    subscriptions = await Subscription.getDummyList();
    subscription = subscriptions!.first;
    await Future.delayed(Duration(seconds: 1));
    showLoading = false;
    uiLoading = false;
    update();
  }

  void selectSubscription(Subscription newSubscription) {
    subscription = newSubscription;
    update();
  }

  void goBack() {
    Get.back();
  }
}
