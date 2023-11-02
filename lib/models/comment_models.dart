class CommentModels{
  String? name;
  String? uId;
  String? image;
  String? comment;
  String? postId;

  CommentModels({
    this.name,
    this.uId,
    this.image,
    this.comment,
    this.postId,
  });


  CommentModels.fromJson(Map<String,dynamic> json)
  {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    comment = json['comment'];
    postId = json['postId'];
  }

  Map<String , dynamic> toMap()
  {
    return{
      'name':name,
      'uId':uId,
      'image':image,
      'comment':comment,
      'postId':postId,
    };
  }
}