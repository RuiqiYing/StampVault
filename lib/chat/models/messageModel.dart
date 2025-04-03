import 'userModel.dart';

class Message {
  User sender;
  String time;
  String text;
  bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.unread,
  });
}

// YOU - current user
User currentUser = User(
  id: 0,
  name: '阿桔',
  imageUrl: 'lib/assets/images/xj1.jpg',
);

// USERS
final User greg = User(
  id: 1,
  name: 'Y',
  imageUrl: 'lib/assets/images/xj1.jpg',
);
final User james = User(
  id: 2,
  name: '西伯利亚大松鼠',
  imageUrl: 'lib/assets/images/xj2.jpg',
);
final User john = User(
  id: 3,
  name: '犹桑！',
  imageUrl: 'lib/assets/images/xj3.jpg',
);
final User olivia = User(
  id: 4,
  name: '羊习习',
  imageUrl: 'lib/assets/images/xj4.jpg',
);
final User sam = User(
  id: 5,
  name: '乔治没有来',
  imageUrl: 'lib/assets/images/xj5.jpg',
);
final User sophia = User(
  id: 6,
  name: '呱呱是个好呱呱',
  imageUrl: 'lib/assets/images/xj6.jpg',
);
final User steven = User(
  id: 7,
  name: '青年大学习',
  imageUrl: 'lib/assets/images/xj7.jpeg',
);

// FAVORITE CONTACTS
List<User> favorites = [sam, steven, olivia, john, greg];

// // EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: james,
    time: '17:30',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: true,
  ),
  Message(
    sender: olivia,
    time: '16:30',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: true,
  ),
  Message(
    sender: john,
    time: '15:30',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: false,
  ),
  Message(
    sender: sophia,
    time: '14:30',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: true,
  ),
  Message(
    sender: steven,
    time: '13:30',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: false,
  ),
  Message(
    sender: sam,
    time: '12:30',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: false,
  ),
  Message(
    sender: greg,
    time: '11:30',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: james,
    time: '17:30',
    text: 'Hey, how\'s it going? What did you do today?',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '16:30',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    unread: true,
  ),
  Message(
    sender: james,
    time: '15:45',
    text: 'How\'s the doggo?',
    unread: true,
  ),
  Message(
    sender: james,
    time: '15:15',
    text: 'All the food',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '14:30',
    text: 'Nice! What kind of food did you eat?',
    unread: true,
  ),
  Message(
    sender: james,
    time: '14:00',
    text: 'I ate so much food today.',
    unread: true,
  ),
];
