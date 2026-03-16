import 'package:flutter/material.dart';
import '../models/rider_item.dart';
import '../services/database/database_helper.dart';

class RiderProvider with ChangeNotifier {
  List<RiderItem> _items = [];
  List<RiderItem> get items => _items;

  Future<void> fetchItems() async {
    final data = await DatabaseHelper.instance.queryAllItems();
    _items = data.map((item) => RiderItem.fromMap(item)).toList();
    notifyListeners();
  }

  Future<void> addItem(RiderItem item) async {
    await DatabaseHelper.instance.insertItem(item.toMap());
    await fetchItems();
  }

  Future<void> updateItem(RiderItem item) async {
    await DatabaseHelper.instance.updateItem(item.toMap());
    await fetchItems();
  }

  Future<void> deleteItem(int id) async {
    await DatabaseHelper.instance.deleteItem(id);
    await fetchItems();
  }

  List<RiderItem> searchItems(String query) {
    return _items.where((p) => p.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

  Map<String, int> getDashboardStats() {
    int total = _items.length;
    int collected = _items.where((p) => p.status == 'Collected').length;
    int wishlist = _items.where((p) => p.status == 'Wishlist').length;
    return {
      'total': total,
      'collected': collected,
      'wishlist': wishlist,
    };
  }
}