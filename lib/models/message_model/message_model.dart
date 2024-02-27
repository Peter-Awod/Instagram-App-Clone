class MessageModel
{
  String? messageText;
  String? senderID;
  String? receiverID;
  String? messageDateTime;

  MessageModel({
    this.messageText,
    this.senderID,
    this.receiverID,
    this.messageDateTime,

  });
  MessageModel.fromJson(Map<String,dynamic>json){
    messageText=json['messageText'];
    senderID=json['senderID'];
    receiverID=json['receiverID'];
    messageDateTime=json['messageDateTime'];

  }

  Map<String,dynamic>toMap(){
    return {
      'messageText':messageText,
      'senderID':senderID,
      'receiverID':receiverID,
      'messageDateTime':messageDateTime,
    };
  }
}
