import 'dart:convert';

List<Chats> chatsFromJson(String str) =>
    List<Chats>.from(json.decode(str).map((x) => Chats.fromJson(x)));

String chatsToJson(List<Chats> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chats {
  DateTime datetime;
  CustomerDetail customerDetail;
  String orderId;
  String sender;
  String message;
  bool isText;

  Chats({
    required this.datetime,
    required this.customerDetail,
    required this.orderId,
    required this.sender,
    required this.message,
    required this.isText,
  });

  factory Chats.fromJson(Map<String, dynamic> json) => Chats(
        datetime: DateTime.parse(json["datetime"]),
        customerDetail: CustomerDetail.fromJson(json["customerDetail"]),
        orderId: json["orderID"],
        isText: json["isText"],
        sender: json["sender"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "datetime": datetime.toIso8601String(),
        "customerDetail": customerDetail.toJson(),
        "orderID": orderId,
        "isText": isText,
        "sender": sender,
        "message": message,
      };
}

class CustomerDetail {
  String firstname;
  String address;
  bool isVerified;
  String provider;
  String imageUrl;
  String userid;
  String fcmToken;
  String email;
  String lastname;
  String contactno;

  CustomerDetail({
    required this.firstname,
    required this.address,
    required this.isVerified,
    required this.provider,
    required this.imageUrl,
    required this.userid,
    required this.fcmToken,
    required this.email,
    required this.lastname,
    required this.contactno,
  });

  factory CustomerDetail.fromJson(Map<String, dynamic> json) => CustomerDetail(
        firstname: json["firstname"],
        address: json["address"],
        isVerified: json["isVerified"],
        provider: json["provider"],
        imageUrl: json["imageUrl"],
        userid: json["userid"],
        fcmToken: json["fcmToken"],
        email: json["email"],
        lastname: json["lastname"],
        contactno: json["contactno"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "address": address,
        "isVerified": isVerified,
        "provider": provider,
        "imageUrl": imageUrl,
        "userid": userid,
        "fcmToken": fcmToken,
        "email": email,
        "lastname": lastname,
        "contactno": contactno,
      };
}
