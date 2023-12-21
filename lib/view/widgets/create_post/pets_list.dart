import 'package:flutter/material.dart';
import 'package:pet_connect/view/widgets/create_post/custom_pet_widget.dart';

class PetsList extends StatelessWidget {
  const PetsList(
      {super.key,
      required this.listOfPetWidget,
      required this.onPressed,
      required this.onLongPress});
  final List<CustomPetWidget> listOfPetWidget;
  final void Function()? onPressed;
  final void Function()? onLongPress;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //primary: false,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: listOfPetWidget.length,
      itemBuilder: (context, index) {
        // return Padding(
        //   padding:  EdgeInsets.only(top: 10.0.h),
        //   child: CustomPetWidget(petIcon: AppImageAsset.dogIcon, onPressed: (){}, onLongPress: (){}),
        // );
        return CustomPetWidget(
            petName: listOfPetWidget[index].petName,
            petImage: listOfPetWidget[index].petImage,
            petIcon: listOfPetWidget[index].petIcon,
            onPressed: () {},
            onLongPress: () {});
      },
    );
  }
}
