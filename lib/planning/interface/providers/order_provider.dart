import 'package:ecoguardian/planning/domain/dto/order_request.dto.dart';
import 'package:ecoguardian/planning/infrastructure/services/order.service.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  Future<void> createOrder(OrderRequestDto order) async {
    final orderService = OrderService();
    await orderService.createOrder(order);
  }
}

