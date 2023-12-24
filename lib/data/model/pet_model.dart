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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['petID'] = this.petID;
    data['name'] = this.name;
    data['type'] = this.type;
    data['breed'] = this.breed;
    data['gender'] = this.gender;
    data['birthDate'] = this.birthDate;
    data['image'] = this.image;
    return data;
  }
}
