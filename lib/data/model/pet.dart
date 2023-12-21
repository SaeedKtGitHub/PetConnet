class Pet {
  String? owner;
  String? name;
  String? type;
  String? breed;
  String? gender;
  String? birthDate;
  String? image;

  Pet(
      {this.owner,
        this.name,
        this.type,
        this.breed,
        this.gender,
        this.birthDate,
        this.image});

  Pet.fromJson(Map<String, dynamic> json) {
    owner = json['owner'];
    name = json['name'];
    type = json['type'];
    breed = json['breed'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['owner'] = this.owner;
    data['name'] = this.name;
    data['type'] = this.type;
    data['breed'] = this.breed;
    data['gender'] = this.gender;
    data['birthDate'] = this.birthDate;
    data['image'] = this.image;
    return data;
  }
}
