import 'package:flutter/foundation.dart';
import 'activetabmodel.dart';
import 'homeinfomodel.dart';

class HomeInfoModel {
  String title;
  String currentTemp;
  String humidity;
  int setTemp;
  int fanSpeed;
  bool isFanOn;
  double knobReading;

  HomeInfoModel({
    this.title = "room",
    this.isFanOn = false,
    this.humidity = '24%',
    this.setTemp = 0,
    this.fanSpeed = 2,
    this.currentTemp = '28°C',
    required this.knobReading,
  });

  void switchFan() {
    isFanOn = !isFanOn;
  }

  void setFanSpeed(int speed) {
    fanSpeed = speed;
  }

  void setKnobReading(double reading) {
    knobReading = reading;
  }
}

class HomeInfoData extends ChangeNotifier {
  List<HomeInfoModel> infoData = [
    HomeInfoModel(
        title: 'Mechanic',
        isFanOn: false,
        humidity: '33%',
        setTemp: 23,
        fanSpeed: 0,
        currentTemp: '25°C',
        knobReading: 0.37),
    HomeInfoModel(
        title: 'Truck',
        isFanOn: false,
        humidity: '48%',
        setTemp: 28,
        fanSpeed: 3,
        currentTemp: '30°C',
        knobReading: 0.45),
  ];

  late ActiveTabIndex tabIndex;

  void setTabIndex(int index) {
    tabIndex.setActiveTabIndex(index);
    notifyListeners();
  }

  int get tabIndexCount {
    return tabIndex.activeIndex;
  }

  void changeFanSpeed(HomeInfoModel infoModel, int speed) {
    infoModel.setFanSpeed(speed);
    notifyListeners();
  }

  HomeInfoModel infoModel(int index) {
    return infoData[index];
  }

  void changeTemp(HomeInfoModel infoModel, int changeTemp) {
    infoModel.setTemp = changeTemp;
    notifyListeners();
  }

  int get roomCount {
    return infoData.length;
  }

  void switchFan(HomeInfoModel infoModel) {
    infoModel.switchFan();
    notifyListeners();
  }

  void setKnobPreCent(HomeInfoModel infoModel, double reading) {
    infoModel.setKnobReading(reading);
    notifyListeners();
  }

  double getKnobReading(int index) {
    return infoData[index].knobReading;
  }
}
