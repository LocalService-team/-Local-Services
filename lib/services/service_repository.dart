import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/service.dart';

class ServiceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // This stream will keep your UI updated automatically when data changes in Firestore
  Stream<List<Service>> getServices() {
    return _firestore.collection('services').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Service.fromFirestore(doc)).toList();
    });
  }
}