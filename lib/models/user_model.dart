class UserModel{
  String? email;
  String? name;
  String? phone;
  String? uId;
  String? image;
  String? coverImage;
  String? bio;
  bool? isEmailVerified;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.image,
    this.coverImage,
    this.bio,
    this.isEmailVerified,
  });


  UserModel.fromJson(Map<String,dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    coverImage = json['coverImage'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String , dynamic> toMap()
  {
    return{
      'email':email,
      'name':name,
      'phone':phone,
      'uId':uId,
      'image':image,
      'coverImage':coverImage,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }
}