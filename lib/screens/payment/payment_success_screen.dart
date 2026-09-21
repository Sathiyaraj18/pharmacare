import 'package:flutter/material.dart';

class PaymentSuccessScreen
    extends StatelessWidget {
  final String orderId;

  final String paymentId;

  final double amount;

  const PaymentSuccessScreen({
    super.key,
    required this.orderId,
    required this.paymentId,
    required this.amount,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints:
          const BoxConstraints(
            maxWidth: 550,
          ),

          child: Card(
            margin:
            const EdgeInsets.all(24),

            child: Padding(
              padding:
              const EdgeInsets.all(40),

              child: Column(
                mainAxisSize:
                MainAxisSize.min,

                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor:
                    Colors.green,

                    child: Icon(
                      Icons.check,
                      color:
                      Colors.white,
                      size: 55,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  const Text(
                    'Payment Successful',
                    style:
                    TextStyle(
                      fontSize: 28,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Text(
                    '₹${amount.toStringAsFixed(2)}',
                    style:
                    const TextStyle(
                      fontSize: 30,
                      fontWeight:
                      FontWeight.bold,
                      color:
                      Color(0xFF00897B),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  _infoRow(
                    'Order ID',
                    orderId,
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  _infoRow(
                    'Payment ID',
                    paymentId,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  SizedBox(
                    width:
                    double.infinity,
                    height: 50,

                    child:
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },

                      child: const Text(
                        'BACK TO ORDERS',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
      String title,
      String value,
      ) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [
        SizedBox(
          width: 100,
          child: Text(
            title,
            style:
            const TextStyle(
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),

        Expanded(
          child: Text(
            value,
            style:
            const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}