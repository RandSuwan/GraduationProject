import 'package:project1/screens/cart.dart';

class Order {
  final String id;
  final String productName;
  final String userId;
  final String shippingAddress;
  final String paymentMethod;
  final List<CartItem>
      items; // You might want to define a more specific class for items
  final double totalAmount;
  final String orderStatus;
  final int orderNumber;

  Order(
      {required this.id,
      required this.userId,
      required this.shippingAddress,
      required this.paymentMethod,
      required this.items,
      required this.totalAmount,
      required this.orderStatus,
      required this.orderNumber,
      required this.productName});

  factory Order.fromJson(Map<String, dynamic> json) {
    var orderJson = json['order'] ?? {};
    print("Parsed Order ID: ${json['_id']}");
    print("Parsed User ID: ${json['user_id']}");
    print("Parsed productName: ${json['productName']}");
    print("Parsed shipping address: ${json['shipping_address']}");
    print("Parsed payment method: ${json['payment_method']}");
    print("Parsed items array: ${json['items']}");
    print("Parsed total amount: ${json['total_amount']}");
    print("Parsed order status: ${json['order_status']}");
    print("Parsed Order Number: ${json['order_number']}");

    print('Order JSON: $orderJson');
    return Order(
      id: json['_id'].toString() as String? ??
          'default-id', // Corrected field access
      userId: json['user_id'].toString() as String? ??
          'default-user-id', // Added null check
      shippingAddress: json['shipping_address'].toString() as String? ??
          'default-address', // Added null check
      paymentMethod: json['payment_method'].toString() as String? ??
          'default-payment-method', // Corrected typo and added null check
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => CartItem.fromJson(e))
          .toList(),
      totalAmount: (json['total_amount'] as num?)?.toDouble() ??
          0.0, // Ensured num to double conversion with default

      orderStatus:
          json['order_status'].toString() as String? ?? 'default-status',

      orderNumber: json['order_number'] as int? ?? 0,

      productName: json['productName'].toString(),
    );
  }
}
