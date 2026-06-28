import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service.dart';
import '../data/service_data.dart';

class ServiceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Service>> getServices() {
    return _firestore.collection('service').snapshots().map((snapshot) {
      if (snapshot.docs.length < 10) {
        return ServiceData.allServices;
      }
      return snapshot.docs.map((doc) {
        return Service.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }
}