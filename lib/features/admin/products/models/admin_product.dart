import 'package:flutter/material.dart';

class AdminProduct {
  final String name;
  final String category;
  final int price;
  final int stock;
  final String description;
  final IconData icon;

  const AdminProduct({
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    this.description = '',
    required this.icon,
  });

  AdminProduct copyWith({
    String? name,
    String? category,
    int? price,
    int? stock,
    String? description,
    IconData? icon,
  }) {
    return AdminProduct(
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }
}