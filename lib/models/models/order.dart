import 'package:intl/intl.dart';

enum OrderStatus { pending, paid, printing, shipped, delivered, cancelled }

class Order {
  final int id;
  final int userId;
  final int productId;
  final String productName;
  final String color;
  final String size;
  final int quantity;
  final double totalPrice;
  final String paymentMethod;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? paymentProof;
  final String? deliveryAddress;

  Order({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.color,
    required this.size,
    required this.quantity,
    required this.totalPrice,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.paymentProof,
    this.deliveryAddress,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      color: json['color'],
      size: json['size'],
      quantity: json['quantity'],
      totalPrice: json['total_price'].toDouble(),
      paymentMethod: json['payment_method'],
      status: _parseStatus(json['status']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      paymentProof: json['payment_proof'],
      deliveryAddress: json['delivery_address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'product_name': productName,
      'color': color,
      'size': size,
      'quantity': quantity,
      'total_price': totalPrice,
      'payment_method': paymentMethod,
      'status': status.toString().split('.').last,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'payment_proof': paymentProof,
      'delivery_address': deliveryAddress,
    };
  }

  static OrderStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return OrderStatus.pending;
      case 'paid':
        return OrderStatus.paid;
      case 'printing':
        return OrderStatus.printing;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }

  String getFormattedStatus() {
    switch (status) {
      case OrderStatus.pending:
        return '🟡 Ожидает оплаты';
      case OrderStatus.paid:
        return '💰 Оплачен';
      case OrderStatus.printing:
        return '🖨️ Печатается';
      case OrderStatus.shipped:
        return '🚚 Отправлен';
      case OrderStatus.delivered:
        return '✅ Доставлен';
      case OrderStatus.cancelled:
        return '❌ Отменен';
    }
  }

  String getFormattedDate() {
    return DateFormat('dd.MM.yyyy HH:mm').format(createdAt);
  }
}
