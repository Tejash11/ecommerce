import 'package:ecommerce/model/product_model.dart';
import 'package:ecommerce/remoteconfig/remote_config.dart';
import 'package:ecommerce/service/product_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _showDiscountedPrice = false;
  bool _isLoading = true;
  String _errorMessage = '';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get showDiscountedPrice => _showDiscountedPrice;

  final ProductService _productService = ProductService();

  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      await setupRemoteConfig();
      final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
      _showDiscountedPrice = shouldShowDiscountedPrice(remoteConfig);

      _products = await _productService.fetchProducts();
      _isLoading = false;  // Data fetched successfully
    } catch (error) {
      _errorMessage = 'Failed to fetch products: $error';
      _isLoading = false;  // Ensure loading state is false even after error
    } finally {
      notifyListeners();  // Notify listeners once loading is done
    }
  }
}

