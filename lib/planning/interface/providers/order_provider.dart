import 'package:ecoguardian/monitoring/infrastructure/services/plant.service.dart';
import 'package:ecoguardian/planning/domain/dto/order_request.dto.dart';
import 'package:ecoguardian/planning/infrastructure/services/device.service.dart';
import 'package:ecoguardian/planning/infrastructure/services/order.service.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {

  List<OrderRequestDto> _orders = [];
  OrderService orderService = OrderService(resourcePath: "orders");
  bool _isLoading = false;

  Future<void> createOrder(OrderRequestDto orderDto) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await orderService.createOrder(orderDto);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      throw Exception("Error creating order: $e");
    }
  }

  Future<void> getOrdersByConsumerId(int consumerId) async {
    try {
      _orders = await orderService.getOrdersByConsumerId(consumerId);
      notifyListeners();
    } catch (e) {
      throw Exception("No orders available: $e");
    }
  }
}

