import 'package:ecomerce/Domain/Model/model.dart';
import 'package:ecomerce/Presentations/Boarding/onBoarding_view_model.dart';
import 'package:ecomerce/Presentations/resources/assets_manager.dart';
import 'package:ecomerce/Presentations/resources/color_manager.dart';
import 'package:ecomerce/Presentations/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class onBoardingScreen extends StatefulWidget {
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  onBoardingViewModel _viewModel = onBoardingViewModel();

  @override
  void initState() {
    _viewModel.start();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Widget getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.SolidCircleIc);
    }
  }

  Widget _getBottomSheet(SliderViewObject sliderViewObject) {
    return Container(
      color: Colors.orangeAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_viewModel.gePrevious(),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
              child: SizedBox(
                height: 20,
                width: 20,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < _viewModel.BoardingList.length; i++)
                Padding(
                  padding: EdgeInsets.all(8),
                  child: getProperCircle(i, sliderViewObject.currnetIndex),
                )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_viewModel.goNext(),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
              child: SizedBox(
                height: 20,
                width: 20,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outPutSliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  Widget _getContentWidget(SliderViewObject? _sliderViewObject) {
    if (_sliderViewObject == null) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: PageView.builder(
          controller: _pageController,
          itemCount: _viewModel.BoardingList.length,
          onPageChanged: (int index) {
            _viewModel.changedBySwapping(index);
          },
          itemBuilder: (context, int) {
            return onBoarding(_sliderViewObject.sliderObject);
          }),
      bottomSheet: Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(routes.loginRoute);
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(color: ColorManager.primery),
                    ),
                  ),
                ),
              ),
            ),
            _getBottomSheet(_sliderViewObject)
          ],
        ),
      ),
    );
  }

  Widget onBoarding(SliderObject _sliderObject) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.center,
            child: Text(
              "${_sliderObject.title}",
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.topCenter,
            child: Text(
              "${_sliderObject.subtitle}",
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('${_sliderObject.image}'))),
          )
        ],
      ),
    );
  }
}
