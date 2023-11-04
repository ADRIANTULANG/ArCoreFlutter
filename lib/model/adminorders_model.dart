import 'dart:convert';

List<AdminOrder> adminOrderFromJson(String str) =>
    List<AdminOrder>.from(json.decode(str).map((x) => AdminOrder.fromJson(x)));

String adminOrderToJson(List<AdminOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminOrder {
  String userAddress;
  DateTime dateTime;
  int quantity;
  String woodType;
  String id;
  double totalPrice;
  double price;
  String userContactno;
  String productname;
  String userEmail;
  String productimage;
  String status;
  CustomerDetails customerDetails;

  AdminOrder({
    required this.id,
    required this.userAddress,
    required this.dateTime,
    required this.quantity,
    required this.woodType,
    required this.totalPrice,
    required this.price,
    required this.userContactno,
    required this.productname,
    required this.userEmail,
    required this.productimage,
    required this.status,
    required this.customerDetails,
  });

  factory AdminOrder.fromJson(Map<String, dynamic> json) => AdminOrder(
        userAddress: json["userAddress"],
        dateTime: DateTime.parse(json["dateTime"]),
        quantity: json["quantity"],
        id: json["id"],
        woodType: json["woodType"],
        totalPrice: double.parse(json["totalPrice"].toString()),
        price: double.parse(json["price"].toString()),
        userContactno: json["userContactno"],
        productname: json["productname"],
        userEmail: json["userEmail"],
        productimage: json["productimage"],
        status: json["status"],
        customerDetails: CustomerDetails.fromJson(json["customerDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "userAddress": userAddress,
        "id": id,
        "dateTime": dateTime.toIso8601String(),
        "quantity": quantity,
        "woodType": woodType,
        "totalPrice": totalPrice,
        "price": price,
        "userContactno": userContactno,
        "productname": productname,
        "userEmail": userEmail,
        "productimage": productimage,
        "status": status,
        "customerDetails": customerDetails.toJson(),
      };
}

class CustomerDetails {
  String firstname;
  String documentID;

  String address;
  bool isVerified;
  String provider;
  String imageUrl;
  bool isOnline;
  String fcmToken;
  String userid;
  String email;
  String contactno;
  String lastname;

  CustomerDetails({
    required this.firstname,
    required this.documentID,
    required this.address,
    required this.isVerified,
    required this.provider,
    required this.imageUrl,
    required this.isOnline,
    required this.fcmToken,
    required this.userid,
    required this.email,
    required this.contactno,
    required this.lastname,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      CustomerDetails(
        firstname: json["firstname"],
        documentID: json["documentID"],
        address: json["address"],
        isVerified: json["isVerified"],
        provider: json["provider"],
        imageUrl: json["imageUrl"],
        isOnline: json["isOnline"],
        fcmToken: json["fcmToken"],
        userid: json["userid"],
        email: json["email"],
        contactno: json["contactno"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "documentID": documentID,
        "address": address,
        "isVerified": isVerified,
        "provider": provider,
        "imageUrl": imageUrl,
        "isOnline": isOnline,
        "fcmToken": fcmToken,
        "userid": userid,
        "email": email,
        "contactno": contactno,
        "lastname": lastname,
      };
}
