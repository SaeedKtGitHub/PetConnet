// import 'package:ecommerce_app/core/constant/imageasset.dart';
// import 'package:ecommerce_app/data/model/onboardingmodel.dart';
//import 'package:get/get.dart';
//
// List<OnBoardingModel> onBoardingList = [
//   OnBoardingModel(
//       title: "2".tr, body: "3".tr, image: AppImageAsset.onBoardingImageOne),
//   OnBoardingModel(
//       title: "4".tr, body: "5".tr, image: AppImageAsset.onBoardingImageTwo),
//   OnBoardingModel(
//       title: "6".tr, body: "7".tr, image: AppImageAsset.onBoardingImageThree),
//   // OnBoardingModel(
//   //     title: "Fast Delivery",
//   //     body:
//   //         "We Have a 100k Product , Choose \n Your Product From Our E-commerce Shop",
//   //     image: AppImageAsset.onBoardingImageFour),
// ];
//My comment
//محمحححمحمح

//some temp data for the home screen:

import 'package:flutter/material.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/data/model/post.dart';
import 'package:pet_connect/data/model/slide_show.dart';
import 'package:pet_connect/data/model/user.dart';
import 'package:pet_connect/view/widgets/choose_post_type_pop_up/tag_item.dart';
import 'package:pet_connect/view/widgets/create_post/custom_pet_widget.dart';
import 'package:pet_connect/view/widgets/home/post_widget.dart';

// final tempTexts= [
//   'قطك يحتاج إلى النوم عشر ساعات يوميا!',
//   'أمراض القطط في الشتاء',
//       'هل مرض صراع الكلب منتشر في الأردن؟',
//   ];
// final tempImages= [
//   'assets/images/pets1.jpeg',
//   'assets/images/pets2.jpeg',
//   'assets/images/pets3.webp'  ];

//bottom appbar icons list :
final bottomNavBarIems = [
  const Icon(Icons.home_outlined),
];

//temp data slides  for test purposes :
List<SlideShow> slides = [
  SlideShow('assets/images/pets1.jpeg', 'قطك يحتاج إلى النوم عشر ساعات يوميا!'),
  SlideShow('assets/images/pets2.jpeg', 'أمراض القطط في الشتاء'),
  SlideShow('assets/images/pets3.webp', 'هل مرض صراع الكلب منتشر في الأردن؟'),
];

//temp posts for test purposes :
List<Post> testPosts = [
  Post(
      username: "Ahmad",
      profileImg: "ahmad.png",
      pets: ["cat1", "dog2"],
      image: "assets/images/pets1.jpeg",
      title: "سندس",
      content:
          "قطتي الجميلة أحبها كثيرا,ألعب معها كل يوم هي لطيفة جدا ولا تؤذي أحدا ,اللعنة على الكفااااار  ",
      author: 'abcd'),
  Post(
      username: "Ahmad",
      profileImg: "ahmad.png",
      pets: ["cat1", "dog2"],
      image: "assets/images/pets1.jpeg",
      title: "سندس",
      content:
          "قطتي الجميلة أحبها كثيرا,ألعب معها كل يوم هي لطيفة جدا ولا تؤذي أحدا ,اللعنة على الكفااااار  ",
      author: 'abcd'),
  // Add more posts as needed
];
// Temp user data for test purposes
List<User> users = [
  User(
      name: "سوسو الأمورة",
      email: 'soso@gmail.com',
      photo: 'assets/images/pets1.jpeg',
      role: 'user'),
  User(
      name: "لولو المغرورة",
      email: 'lolo@gmail.com',
      photo: 'assets/images/pets1.jpeg',
      role: 'user'),
];

//temp posts for test purposes :
List<CustomPetWidget> testPetList = [
  CustomPetWidget(
      petName: 'Dog 1',
      petImage: AppImageAsset.testDog,
      petIcon: AppImageAsset.dogIcon,
      index: 0,
      onPressed: () {},
      onLongPress: () {}),
  CustomPetWidget(
      petName: 'Dog 2',
      petImage: AppImageAsset.testDog,
      petIcon: AppImageAsset.dogIcon,
      index: 0,
      onPressed: () {},
      onLongPress: () {}),
  CustomPetWidget(
      petName: 'Dog 3',
      petImage: AppImageAsset.testDog,
      petIcon: AppImageAsset.dogIcon,
      index: 0,
      onPressed: () {},
      onLongPress: () {}),
  CustomPetWidget(
      petName: 'Dog 4',
      petImage: AppImageAsset.testDog,
      petIcon: AppImageAsset.dogIcon,
      index: 0,
      onPressed: () {},
      onLongPress: () {}),
];

//List of traffic users tags :
List<TagItem> trafficTagsItems = [
  const TagItem(
      iconPath: 'assets/images/tags_items_popup_icons/adoptAnimalTagIcon.png',
      text: 'التبرع بحيوان'),
  const TagItem(
      iconPath: 'assets/images/tags_items_popup_icons/mating.png',
      text: 'البحث عن تزاوج'),
  const TagItem(
      iconPath: 'assets/images/tags_items_popup_icons/offer_for_sale.png',
      text: 'عرض للبيع'),
  const TagItem(
      iconPath: 'assets/images/tags_items_popup_icons/lost_animal.png',
      text: 'ابلاغ عن حيوان ضائع'),
];

//List of other users(vets,shops,writer) tags :
List<TagItem> businessTagsItems = [
  const TagItem(
      iconPath: 'assets/images/tags_items_popup_icons/offer_service.png',
      text: 'عرض خدمة'),
  const TagItem(
      iconPath: 'assets/images/tags_items_popup_icons/offer_product.png',
      text: 'عرض منتج للبيع'),
  const TagItem(
      iconPath:
          'assets/images/tags_items_popup_icons/offer_medical_service.png',
      text: 'عرض خدمة طبية'),
  const TagItem(
      iconPath: 'assets/images/tags_items_popup_icons/write_article.png',
      text: 'كتابة مقالة'),
];
