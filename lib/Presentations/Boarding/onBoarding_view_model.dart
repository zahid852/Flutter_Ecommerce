import 'dart:async';

import 'package:ecomerce/Domain/Model/model.dart';
import 'package:ecomerce/Presentations/BaseViewModel/base_view_model.dart';
import 'package:ecomerce/Presentations/resources/assets_manager.dart';
import 'package:ecomerce/Presentations/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class onBoardingViewModel extends baseViewModel
    with onBoardingViewModelInputs, onBoardingViewModelOutputs {
  StreamController _streamController = BehaviorSubject<SliderViewObject>();
  List<SliderObject> BoardingList = [];
  int _currentIndex = 0;
  List<SliderObject> _getList() {
    return [
      SliderObject(
          title: AppStrings.onBoardingTitle1,
          subtitle: AppStrings.onBoardingSubtitle1,
          image: ImageAssets.clothing),
      SliderObject(
          title: AppStrings.onBoardingTitle2,
          subtitle: AppStrings.onBoardingSubtitle2,
          image: ImageAssets.shoes),
      SliderObject(
          title: AppStrings.onBoardingTitle3,
          subtitle: AppStrings.onBoardingSubtitle3,
          image: ImageAssets.beauty),
      SliderObject(
          title: AppStrings.onBoardingTitle4,
          subtitle: AppStrings.onBoardingSubtitle4,
          image: ImageAssets.staionary),
    ];
  }

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    BoardingList = _getList();
    _postDataToView();
  }

  @override
  int gePrevious() {
    int previous_index = (_currentIndex--);

    if (previous_index == 0) {
      _currentIndex = BoardingList.length - 1;
    }
    return _currentIndex;
  }

  @override
  int goNext() {
    int next_index = _currentIndex++;
    if (next_index == BoardingList.length - 1) {
      _currentIndex = 0;
    }

    return _currentIndex;
  }

  changedBySwapping(int index) {
    _currentIndex = index;

    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject {
    return _streamController.sink;
  }

  _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
        sliderObject: BoardingList[_currentIndex],
        currnetIndex: _currentIndex));
  }

  @override
  Stream<SliderViewObject> get outPutSliderViewObject {
    return _streamController.stream
        .map((sliver_view_object) => sliver_view_object);
  }
}

//onBoardingViewModelInputs will receive orders from our onboarding screen
abstract class onBoardingViewModelInputs {
  void goNext();
  void gePrevious();
  Sink get inputSliderViewObject;
}

//onBoardingViewModelOutputs will send results to our onboarding screen
abstract class onBoardingViewModelOutputs {
  Stream<SliderViewObject> get outPutSliderViewObject;
}
