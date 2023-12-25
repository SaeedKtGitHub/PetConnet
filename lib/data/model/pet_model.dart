class PetModel {
  String? userID;
  String? petID;
  String? name;
  String? type;
  String? breed;
  String? gender;
  String? birthDate;
  String? image;

  PetModel(
      {this.userID,
      this.petID,
      this.name,
      this.type,
      this.breed,
      this.gender,
      this.birthDate,
      this.image});

  PetModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    petID = json['_id'];
    name = json['name'];
    type = json['type'];
    breed = json['breed'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['petID'] = petID;
    data['name'] = name;
    data['type'] = type;
    data['breed'] = breed;
    data['gender'] = gender;
    data['birthDate'] = birthDate;
    data['image'] = image;
    return data;
  }
}
