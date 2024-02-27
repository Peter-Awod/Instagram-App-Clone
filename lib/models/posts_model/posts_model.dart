class PostModel
{
  String? uId;
  String? postId;
  String? name;
  String? text;
  String? profile;
  String? postImage;
  String? dateTime;
  PostModel({
    this.uId,
    this.postId,
    this.name,
    this.text,
    this.profile,
    this.postImage,
    this.dateTime,
  });
  PostModel.fromJson(Map<String,dynamic>json){
    uId=json['uId'];
    postId=json['postId'];
    name=json['name'];
    text=json['text'];
    profile=json['profile'];
    postImage=json['postImage'];
    dateTime=json['dateTime'];
  }

  Map<String,dynamic>toMap(){
    return {
      'uId':uId,
      'postId':postId,
      'name':name,
      'text':text,
      'profile':profile,
      'postImage':postImage,
      'dateTime':dateTime,
    };
  }
}