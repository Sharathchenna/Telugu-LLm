import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RecordedInfoViewModel extends BaseViewModel {
  TextEditingController userNameController = TextEditingController();
  TextEditingController conversationTopicController = TextEditingController();
  TextEditingController geoLocationController = TextEditingController();

  FocusNode userNameFocusNode = FocusNode();
  FocusNode conversationTopicFocusNode = FocusNode();
  FocusNode geoLocationFocusNode = FocusNode();

  bool _isFormSubmitted = false;

  bool get isFormSubmitted => _isFormSubmitted;

  // LocationData? _currentPosition;

  // LocationData? get currentPosition => _currentPosition;

  // Future<void> getCurrentLocation() async {
  //   try {
  //     Location location = Location();
  //     _currentPosition = await location.getLocation();
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error getting location: $e');
  //     _currentPosition = null;
  //     notifyListeners();
  //   }
  // }

  @override
  void dispose() {
    // Clean up controllers and focus nodes
    userNameController.dispose();
    conversationTopicController.dispose();
    geoLocationController.dispose();
    userNameFocusNode.dispose();
    conversationTopicFocusNode.dispose();
    geoLocationFocusNode.dispose();
    super.dispose();
  }

  void setFormSubmitted(bool value) {
    _isFormSubmitted = value;
    notifyListeners();
  }
}
