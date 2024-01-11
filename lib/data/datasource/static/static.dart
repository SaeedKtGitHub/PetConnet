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
import 'package:get/get.dart';
import 'package:pet_connect/core/constant/imageasset.dart';
import 'package:pet_connect/data/model/pet_model.dart';
import 'package:pet_connect/data/model/slide_show.dart';
import 'package:pet_connect/data/model/user_model.dart';
import 'package:pet_connect/view/widgets/choose_post_type_pop_up/tag_item.dart';

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
// List<PostModel> testPosts = [
//   PostModel(
//     name: "Ahmad",
//     profilePic: "ahmad.png",
//     petID: "pet Id 1",
//     image: "assets/images/pets1.jpeg",
//     title: "سندس",
//     content:
//         "قطتي الجميلة أحبها كثيرا,ألعب معها كل يوم هي لطيفة جدا ولا تؤذي أحدا ,اللعنة على الكفااااار  ",
//   ),
//   PostModel(
//     name: "Ahmad",
//     profilePic: "ahmad.png",
//     petID: "pet Id 2",
//     image: "assets/images/pets1.jpeg",
//     title: "سندس",
//     content:
//         "قطتي الجميلة أحبها كثيرا,ألعب معها كل يوم هي لطيفة جدا ولا تؤذي أحدا ,اللعنة على الكفااااار  ",
//   ),
//   // Add more posts as needed
// ];

// Temp user data for test purposes
List<UserModel> users = [
  UserModel(
      userID: "1",
      name: "سوسو الأمورة",
      email: 'soso@gmail.com',
      profilePic: 'assets/images/pets1.jpeg',
      role: 'user'),
  UserModel(
      userID: "2",
      name: "لولو المغرورة",
      email: 'lolo@gmail.com',
      profilePic: 'assets/images/pets1.jpeg',
      role: 'user'),
];

//temp posts for test purposes :
List<PetModel> testPetList = [
  PetModel(
    petID: '1',
    userID: "hassan",
    name: "zuzu",
    type: "cat",
    breed: "Turkish",
    gender: "f",
    birthDate: "2022-03-10T00:00:00.000Z",
    image: AppImageAsset.testDog,
  ),
  PetModel(
    petID: '2',
    userID: "hassan",
    name: "momo",
    type: "cat",
    breed: "Turkish",
    gender: "f",
    birthDate: "2022-03-10T00:00:00.000Z",
    image: AppImageAsset.testDog,
  ),
  PetModel(
    petID: '3',
    userID: "hassan",
    name: "hoho",
    type: "cat",
    breed: "Turkish",
    gender: "f",
    birthDate: "2022-03-10T00:00:00.000Z",
    image: AppImageAsset.testDog,
  ),
];

//List of traffic users tags :
List<TagItem> trafficTagsItems = [
   TagItem(
      iconPath: 'assets/images/tags_items_popup_icons/adoptAnimalTagIcon.png',
      text: '170'.tr),
   TagItem(
      iconPath: 'assets/images/tags_items_popup_icons/mating.png',
      text: '171'.tr),
   TagItem(
      iconPath: 'assets/images/tags_items_popup_icons/offer_for_sale.png',
      text: '172'.tr),
   TagItem(
      iconPath: 'assets/images/tags_items_popup_icons/lost_animal.png',
      text: '173'.tr),
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
enum postsTags {
  adoption,
  mating,
  trading,
  lost,
  social,
}


    //  List<CommentModel> getDemoComments() {
    // return [
    // CommentModel(
    // userID: '1',
    // name: 'Saeed',
    // content: 'This is the first comment.',
    // profilePic: '',
    // date: '2022-01-01',
    // ),
    // CommentModel(
    // userID: '2',
    // name: 'Ahmad',
    // content: 'This is the second comment.',
    // profilePic: '',
    // date: '2022-01-02',
    // ),
    // CommentModel(
    // userID: '3',
    // name: 'Hassan',
    // content: 'This is the third comment.',
    // profilePic: '',
    // date: '2022-01-03',
    // ),
    //   CommentModel(
    //     userID: '3',
    //     name: 'Hassan',
    //     content: 'This is the third comment.',
    //     profilePic: '',
    //     date: '2022-01-03',
    //   ), CommentModel(
    //     userID: '3',
    //     name: 'Hassan',
    //     content: 'This is the third comment.',
    //     profilePic: '',
    //     date: '2022-01-03',
    //   ), CommentModel(
    //     userID: '3',
    //     name: 'Hassan',
    //     content: 'This is the third comment.',
    //     profilePic: '',
    //     date: '2022-01-03',
    //   ),
    //   CommentModel(
    //     userID: '3',
    //     name: 'Hassan',
    //     content: 'This is the third comment.',
    //     profilePic: '',
    //     date: '2022-01-03',
    //   ),
    // ];
    // }