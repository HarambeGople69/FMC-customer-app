import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetaiModel {
  final String? orderUID; //done
  final String? ownerUID;
  final String? name; //done
  final String? phone; //done
  final String? email; //done
  final String? country;
  final String? postalCode;
  final String? adminArea;
  final String? subAdminArea;
  final String? locality;
  final String? subLocality;
  final double? longitude;
  final double? latitude;
  final String? verifyUID;
  final String? riderUID;
  final String? riderName;
  final String? riderPhone;
  final String? orderState;
  final List? items;
  final double? price;
  final Timestamp? orderPlaced;
  final Timestamp? timestamp;

  OrderDetaiModel({
    required this.orderUID,
    required this.ownerUID,
    required this.name,
    required this.phone,
    required this.email,
    required this.country,
    required this.postalCode,
    required this.adminArea,
    required this.subAdminArea,
    required this.locality,
    required this.subLocality,
    required this.longitude,
    required this.latitude,
    required this.verifyUID,
    required this.riderUID,
    required this.riderName,
    required this.riderPhone,
    required this.orderState,
    required this.items,
    required this.price,
    required this.orderPlaced,
    required this.timestamp,
  });

  factory OrderDetaiModel.fromMap(
      QueryDocumentSnapshot<Map<String, dynamic>> map) {
    return OrderDetaiModel(
      orderUID: map["orderUID"],
      ownerUID: map["ownerUID"],
      name: map["name"],
      phone: map["phone"],
      email: map["email"],
      country: map["country"],
      postalCode: map["postalCode"],
      adminArea: map["adminArea"],
      subAdminArea: map["subAdminArea"],
      locality: map["locality"],
      subLocality: map["subLocality"],
      longitude: map["longitude"],
      latitude: map["latitude"],
      verifyUID: map["verifyUID"],
      riderName: map["riderName"],
      riderPhone: map["riderPhone"],
      orderState: map["orderState"],
      items: map["items"],
      price: map["price"],
      orderPlaced: map["orderPlaced"],
      timestamp: map["timestamp"],
      riderUID: map["riderUID"],
    );
  }
}
