import 'package:flutter/material.dart';
import '../models/service.dart';

class ServiceDetailScreen extends StatelessWidget {
final Service service;

const ServiceDetailScreen({
super.key,
required this.service,
});

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(service.title),
),
body: SingleChildScrollView(
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
Image.network(
service.image,
height: 250,
fit: BoxFit.cover,
),
Padding(
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.end,
children: [
Text(
service.title,
style: const TextStyle(
fontSize: 28,
fontWeight: FontWeight.bold,
),
),
  const SizedBox(height: 10),
  Text(
    service.category,
    style: const TextStyle(fontSize: 18),
  ),
  const SizedBox(height: 10),
  Text(
    service.address,
    style: const TextStyle(fontSize: 16),
  ),
  const SizedBox(height: 20),
  Row(
    children: [
      const Icon(Icons.star, color: Colors.amber),
      const SizedBox(width: 6),
      Text(service.rating.toString()),
    ],
  ),
],
),
),
],
),
),
);
}
}