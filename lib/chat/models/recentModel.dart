import 'userModel.dart';

class Recent {
  User sender;
  String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  String text;
  bool unread;

  Recent({
    this.sender,
    this.time,
    this.text,
    this.unread,
  });
}