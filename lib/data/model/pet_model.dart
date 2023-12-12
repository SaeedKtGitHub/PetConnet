class PetModel {
  PetModel({
    this.petId,
    this.petImage,
    this.petName,
    //this.petIcon,
  });

  String? petId;
  String? petImage;
  String? petName;
  //String? petIcon;

  PetModel.fromJson(Map<String, dynamic> json) {
    petId = json['pets_id'];
    petImage = json['pets_image'];
    petName = json['pet_name'];
    //petIcon = json['pets_icon'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['notes_id'] = notesId;
//   data['notes_title'] = notesTitle;
//   data['notes_content'] = notesContent;
//   data['notes_image'] = notesImage;
//   data['notes_users'] = notesUsers;
//   return data;
// }
}
