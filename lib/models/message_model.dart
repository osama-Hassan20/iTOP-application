class MessageModel {
  String? name;
  String? receiverId;
  String? dateTime;
  String? text;
  String? imageUrl;
  String? senderId;

  MessageModel({
    this.name,
    this.receiverId,
    this.dateTime,
    this.text,
    this.imageUrl,
    this.senderId,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    imageUrl = json['imageUrl'];
    senderId = json['senderId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'imageUrl': imageUrl,
      'senderId': senderId,
    };
  }
}