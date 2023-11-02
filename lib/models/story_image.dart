class StoryModel{
  String? name;
  String? uId;
  String? image;
  String? storyImage;

  StoryModel({
    this.name,
    this.uId,
    this.image,
    this.storyImage,
  });


  StoryModel.fromJson(Map<String,dynamic> json)
  {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    storyImage = json['storyImage'];
  }

  Map<String , dynamic> toMap()
  {
    return{
      'name':name,
      'uId':uId,
      'image':image,
      'storyImage':storyImage,
    };
  }
}