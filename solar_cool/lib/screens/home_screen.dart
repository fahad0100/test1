import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/data_controller.dart';
import 'history_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [HomeScreen(), HistoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,

        selectedItemColor: Color(0xfff8bd40),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.find<DataController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,

        elevation: 0,
        leading: Icon(Icons.home),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //show image logo with size 300 with fit is cover
              Image.asset("assets/images/logo.jpeg", fit: BoxFit.contain),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Text(
                    "Battery Level",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Spacer(),
                  const Icon(Icons.battery_full, color: Colors.green),
                  Text("${controller.batteryLevel.value}%"),
                ],
              ),
              const SizedBox(height: 20),
              tempBox("Current temperature", controller.currentTemp.value),
              Spacer(),

              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.isOn.value ? "On" : "Off",
                      style: TextStyle(
                        fontSize: 18,
                        color:
                            controller.isOn.value ? Colors.green : Colors.red,
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
      ),
    );
  }

  Widget tempBox(String label, int value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Spacer(),
        Container(
          height: 45,
          width: 150,
          decoration: BoxDecoration(
            //#f8bd40
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
