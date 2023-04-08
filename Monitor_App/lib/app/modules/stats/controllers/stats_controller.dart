import 'package:get/get.dart';

class StatsController extends GetxController {
  final _filterTime = "Daily".obs;
  get filterTime => _filterTime.value;
  set filterTime(value) => this._filterTime.value = value;
}
