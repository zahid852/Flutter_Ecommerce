class SliderObject {
  final String title;
  final String subtitle;
  final String image;
  SliderObject(
      {required this.title, required this.subtitle, required this.image});
}

class SliderViewObject {
  final SliderObject sliderObject;
  final int currnetIndex;
  SliderViewObject({required this.sliderObject, required this.currnetIndex});
}

class Category {
  String id;
  String name;
  String des;
  String imageUrl;
  int parameter;
  Category(this.id, this.name, this.des, this.imageUrl, this.parameter);
}
