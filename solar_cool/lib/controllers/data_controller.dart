import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class DataController extends GetxController {
  RxInt batteryLevel = 82.obs;
  RxInt currentTemp = 37.obs;
  RxInt maxTemp = 43.obs;
  RxInt minTemp = 32.obs;
  RxBool isOn = false.obs;

  final DatabaseReference ref = FirebaseDatabase.instance.ref("device/status");

  @override
  void onInit() {
    super.onInit();
    fetchData(); // initial
    listenToRealtime(); // real-time updates
  }

  void fetchData() async {
    final snapshot = await ref.get();
    if (snapshot.exists) {
      var data = Map<String, dynamic>.from(snapshot.value as Map);
      batteryLevel.value = data["battery"] ?? 82;
      currentTemp.value = data["currentTemp"] ?? 37;
      maxTemp.value = data["maxTemp"] ?? 43;
      minTemp.value = data["minTemp"] ?? 32;
      isOn.value = data["isOn"] ?? false;
    }
  }

  void togglePower(bool value) async {
    isOn.value = value;
    await ref.update({"isOn": value});
  }

  void listenToRealtime() {
    ref.onValue.listen((event) {
      if (event.snapshot.exists) {
        var data = Map<String, dynamic>.from(event.snapshot.value as Map);
        batteryLevel.value = data["battery"] ?? 82;
        currentTemp.value = data["currentTemp"] ?? 37;
        maxTemp.value = data["maxTemp"] ?? 43;
        minTemp.value = data["minTemp"] ?? 32;
        isOn.value = data["isOn"] ?? false;
      }
    });
  }
}
