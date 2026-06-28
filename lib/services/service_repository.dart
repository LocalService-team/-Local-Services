import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service.dart';
import '../data/service_data.dart';

class ServiceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Service>> getServices() {
    return _firestore.collection('service').snapshots().map((snapshot) {
      print('Firestore returned ${snapshot.docs.length} documents');
      if (snapshot.docs.isEmpty) {
        print('Firestore empty - using local data');
        return ServiceData.allServices;
      }
      return snapshot.docs.map((doc) {
        return Service.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }
}