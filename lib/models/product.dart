
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final int price;
  final String category;
  final String? imageUrl;
  final int stock;
  final IconData icon;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl,
    this.stock = 0,
    this.icon = Icons.coffee_rounded,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    int? price,
    String? category,
    String? imageUrl,
    int? stock,
    IconData? icon,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      stock: stock ?? this.stock,
      icon: icon ?? this.icon,
    );
  }
}
