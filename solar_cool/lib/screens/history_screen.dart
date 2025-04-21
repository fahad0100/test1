import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/data_controller.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DataController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
        elevation: 0,
        leading: Icon(Icons.history),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Battery Level",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Spacer(),
                        const Icon(Icons.battery_full, color: Colors.green),
                        Text("${controller.batteryLevel.value}%"),
                        Spacer(),
                        //save button
                        ElevatedButton(
                          onPressed: () {
                            //save data to firebase
                            // await  controller.ref.update({
                            //    "battery": controller.batteryLevel.value,
                            //    "currentTemp": controller.currentTemp.value,
                            //    "maxTemp": controller.maxTemp.value,
                            //    "minTemp": controller.minTemp.value,
                            //    "isOn": controller.isOn.value,
                            //  });
                            Get.snackbar(
                              "Success",
                              "Data saved",
                              backgroundColor: Colors.green,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          child: Text("Save"),
                        ),
                      ],
                    ),
                    tempBox(
                      "Current temperature",
                      controller.currentTemp.value,
                    ),
                    tempBox("MAX Temperature", controller.maxTemp.value),
                    tempBox("MIN Temperature", controller.minTemp.value),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.isOn.value ? "On" : "Off",
                    style: TextStyle(
                      fontSize: 18,
                      color: controller.isOn.value ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(width: 10),
                  //make color of switch green when On and red when Off
                  Switch(
                    value: controller.isOn.value,
                    onChanged: (val) => controller.togglePower(val),
                    activeTrackColor: Colors.green[300],
                    inactiveTrackColor: Colors.red[300],
                    activeColor: Colors.white,
                    inactiveThumbColor: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tempBox(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Container(
          height: 45,
          width: 150,
          decoration: BoxDecoration(
            color: Color(0xfff8bd40),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text("$value", style: const TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}
