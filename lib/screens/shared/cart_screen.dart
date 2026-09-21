import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../theme/app_colors.dart';
import '../../widgets/web_layout.dart';
import '../../widgets/breadcrumb.dart';
import '../payment/payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // ============================================================
  // SAMPLE CART DATA
  // ============================================================

  final List<Map<String, dynamic>> cartItems = [
    {
      "name": "Slew 2 mg",
      "molecule": "Example Molecule A",
      "company": "ABC Pharmaceuticals",
      "stockist": "VV Pharma",
      "price": 450.0,
      "quantity": 2,
    },
    {
      "name": "CardioSafe 10 mg",
      "molecule": "Example Molecule B",
      "company": "ABC Pharmaceuticals",
      "stockist": "Premier Pharma",
      "price": 620.0,
      "quantity": 1,
    },
    {
      "name": "Diabetix 500 mg",
      "molecule": "Example Molecule C",
      "company": "ABC Pharmaceuticals",
      "stockist": "Krishna Pharma",
      "price": 380.0,
      "quantity": 3,
    },
  ];

  // ============================================================
  // CALCULATIONS
  // ============================================================

  double get subtotal {
    double total = 0;

    for (final item in cartItems) {
      total +=
          (item["price"] as double) *
              (item["quantity"] as int);
    }

    return total;
  }

  double get deliveryCharge {
    if (subtotal >= 2000) {
      return 0;
    }

    return 80;
  }

  double get total {
    return subtotal + deliveryCharge;
  }

  int get totalItems {
    int count = 0;

    for (final item in cartItems) {
      count += item["quantity"] as int;
    }

    return count;
  }

  // ============================================================
  // INCREASE QUANTITY
  // ============================================================

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index]["quantity"] =
          (cartItems[index]["quantity"] as int) + 1;
    });
  }

  // ============================================================
  // DECREASE QUANTITY
  // ============================================================

  void decreaseQuantity(int index) {
    final int quantity =
    cartItems[index]["quantity"] as int;

    if (quantity <= 1) {
      return;
    }

    setState(() {
      cartItems[index]["quantity"] =
          quantity - 1;
    });
  }

  // ============================================================
  // REMOVE ITEM
  // ============================================================

  void removeItem(int index) {
    final String medicineName =
    cartItems[index]["name"].toString();

    setState(() {
      cartItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$medicineName removed from cart",
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ============================================================
  // PAYMENT
  // ============================================================

  Future<void> openPayment() async {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Your cart is empty",
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );

      return;
    }

    final User? user =
        FirebaseAuth.instance.currentUser;

    final String customerName =
    user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!.trim()
        : "Doctor";

    final String customerEmail =
        user?.email?.trim() ?? "";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentScreen(
          amount: total,
          customerName: customerName,
          customerEmail: customerEmail,
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: "My Cart",
      menu: "doctor",
      breadcrumbItems: const [
        BreadcrumbItem(
          title: "Dashboard",
        ),
        BreadcrumbItem(
          title: "My Cart",
        ),
      ],
      child: LayoutBuilder(
        builder: (
            context,
            constraints,
            ) {
          final bool isMobile =
              constraints.maxWidth < 750;

          return SingleChildScrollView(
            padding: EdgeInsets.all(
              isMobile ? 16 : 28,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints:
                const BoxConstraints(
                  maxWidth: 1250,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // ==========================================
                    // HEADER
                    // ==========================================

                    _buildPageHeader(
                      isMobile,
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    // ==========================================
                    // EMPTY CART
                    // ==========================================

                    if (cartItems.isEmpty)
                      _buildEmptyCart()

                    // ==========================================
                    // CART CONTENT
                    // ==========================================

                    else
                      isMobile
                          ? Column(
                        children: [
                          _buildCartItems(),
                          const SizedBox(
                            height: 20,
                          ),
                          _buildOrderSummary(),
                        ],
                      )
                          : Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 7,
                            child:
                            _buildCartItems(),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            flex: 4,
                            child:
                            _buildOrderSummary(),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // PAGE HEADER
  // ============================================================

  Widget _buildPageHeader(
      bool isMobile,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        const Text(
          "Review Your Cart",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          "$totalItems medicine items selected",
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CART ITEMS
  // ============================================================

  Widget _buildCartItems() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.035,
            ),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          // ================================================
          // SECTION HEADER
          // ================================================

          Row(
            children: [
              const Expanded(
                child: Text(
                  "Selected Medicines",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color:
                  AppColors.lightTeal,
                  borderRadius:
                  BorderRadius.circular(
                    20,
                  ),
                ),
                child: Text(
                  "$totalItems items",
                  style: const TextStyle(
                    color:
                    AppColors.primary,
                    fontSize: 12,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          // ================================================
          // MEDICINE LIST
          // ================================================

          ListView.separated(
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            itemCount:
            cartItems.length,
            separatorBuilder:
                (_, __) =>
            const SizedBox(
              height: 14,
            ),
            itemBuilder:
                (context, index) {
              return _buildMedicineCard(
                index,
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MEDICINE CARD
  // ============================================================

  Widget _buildMedicineCard(
      int index,
      ) {
    final Map<String, dynamic> item =
    cartItems[index];

    final double price =
    item["price"] as double;

    final int quantity =
    item["quantity"] as int;

    final double itemTotal =
        price * quantity;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xffFAFCFB),
        borderRadius:
        BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              // ==========================================
              // MEDICINE ICON
              // ==========================================

              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color:
                  AppColors.lightTeal,
                  borderRadius:
                  BorderRadius.circular(
                    15,
                  ),
                ),
                child: const Icon(
                  Icons.medication_outlined,
                  color:
                  AppColors.primary,
                  size: 31,
                ),
              ),

              const SizedBox(
                width: 15,
              ),

              // ==========================================
              // MEDICINE INFORMATION
              // ==========================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["name"]
                          .toString(),
                      style:
                      const TextStyle(
                        fontSize: 17,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    Text(
                      item["molecule"]
                          .toString(),
                      style:
                      const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(
                      height: 7,
                    ),

                    Text(
                      item["company"]
                          .toString(),
                      style:
                      const TextStyle(
                        fontSize: 13,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),

                    const SizedBox(
                      height: 7,
                    ),

                    Row(
                      children: [
                        const Icon(
                          Icons.store_outlined,
                          size: 16,
                          color:
                          AppColors.primary,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          item["stockist"]
                              .toString(),
                          style:
                          const TextStyle(
                            color:
                            AppColors.primary,
                            fontSize: 13,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              // ==========================================
              // PRICE
              // ==========================================

              Column(
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  Text(
                    "₹${itemTotal.toStringAsFixed(2)}",
                    style:
                    const TextStyle(
                      color:
                      AppColors.primary,
                      fontSize: 17,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 4,
                  ),

                  Text(
                    "₹${price.toStringAsFixed(2)} / item",
                    style:
                    const TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(
            height: 17,
          ),

          const Divider(
            height: 1,
          ),

          const SizedBox(
            height: 15,
          ),

          // ================================================
          // QUANTITY + REMOVE
          // ================================================

          Row(
            children: [
              _buildQuantityControl(
                index,
                quantity,
              ),

              const Spacer(),

              TextButton.icon(
                onPressed: () {
                  removeItem(index);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 18,
                ),
                label: const Text(
                  "Remove",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // QUANTITY CONTROL
  // ============================================================

  Widget _buildQuantityControl(
      int index,
      int quantity,
      ) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(11),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Row(
        mainAxisSize:
        MainAxisSize.min,
        children: [
          IconButton(
            onPressed: quantity > 1
                ? () {
              decreaseQuantity(
                index,
              );
            }
                : null,
            icon: const Icon(
              Icons.remove,
              size: 17,
            ),
            color:
            AppColors.primary,
            padding:
            const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            constraints:
            const BoxConstraints(),
          ),

          Container(
            constraints:
            const BoxConstraints(
              minWidth: 30,
            ),
            alignment:
            Alignment.center,
            child: Text(
              quantity.toString(),
              style:
              const TextStyle(
                fontWeight:
                FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),

          IconButton(
            onPressed: () {
              increaseQuantity(index);
            },
            icon: const Icon(
              Icons.add,
              size: 17,
            ),
            color:
            AppColors.primary,
            padding:
            const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            constraints:
            const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ORDER SUMMARY
  // ============================================================

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.035,
            ),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          const Text(
            "Order Summary",
            style: TextStyle(
              fontSize: 20,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 24,
          ),

          // ================================================
          // ITEMS
          // ================================================

          _summaryRow(
            "Items",
            "$totalItems",
          ),

          const SizedBox(
            height: 16,
          ),

          _summaryRow(
            "Subtotal",
            "₹${subtotal.toStringAsFixed(2)}",
          ),

          const SizedBox(
            height: 16,
          ),

          _summaryRow(
            "Delivery",
            deliveryCharge == 0
                ? "FREE"
                : "₹${deliveryCharge.toStringAsFixed(2)}",
            valueColor:
            Colors.green,
          ),

          const SizedBox(
            height: 20,
          ),

          Divider(
            color: Colors.grey.shade300,
          ),

          const SizedBox(
            height: 20,
          ),

          // ================================================
          // TOTAL
          // ================================================

          Row(
            children: [
              const Expanded(
                child: Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "₹${total.toStringAsFixed(2)}",
                style: const TextStyle(
                  color:
                  AppColors.primary,
                  fontSize: 23,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 22,
          ),

          // ================================================
          // FREE DELIVERY MESSAGE
          // ================================================

          if (deliveryCharge == 0)
            Container(
              width: double.infinity,
              padding:
              const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color:
                const Color(0xffEDF9F0),
                borderRadius:
                BorderRadius.circular(
                  12,
                ),
              ),
              child: const Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 19,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      "You have unlocked free delivery.",
                      style: TextStyle(
                        color:
                        Colors.green,
                        fontSize: 12,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(
            height: 18,
          ),

          // ================================================
          // PAYMENT BUTTON
          // ================================================

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: openPayment,
              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                AppColors.primary,
                foregroundColor:
                Colors.white,
                elevation: 0,
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    13,
                  ),
                ),
              ),
              child: const Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons
                        .credit_card_outlined,
                    size: 20,
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Text(
                    "Proceed to Payment",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 13,
          ),

          // ================================================
          // SECURE CHECKOUT
          // ================================================

          const Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 14,
                color: Colors.grey,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Secure checkout",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SUMMARY ROW
  // ============================================================

  Widget _summaryRow(
      String title,
      String value, {
        Color valueColor =
            Colors.black87,
      }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 14,
            fontWeight:
            FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // EMPTY CART
  // ============================================================

  Widget _buildEmptyCart() {
    return Center(
      child: Container(
        constraints:
        const BoxConstraints(
          maxWidth: 550,
        ),
        padding:
        const EdgeInsets.all(45),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(22),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color:
                AppColors.lightTeal,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons
                    .shopping_cart_outlined,
                color:
                AppColors.primary,
                size: 42,
              ),
            ),

            const SizedBox(
              height: 22,
            ),

            const Text(
              "Your Cart is Empty",
              style: TextStyle(
                fontSize: 23,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            const Text(
              "Add medicines to your cart to continue with your order.",
              textAlign:
              TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                height: 1.5,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                AppColors.primary,
                foregroundColor:
                Colors.white,
                elevation: 0,
                padding:
                const EdgeInsets
                    .symmetric(
                  horizontal: 28,
                  vertical: 15,
                ),
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    12,
                  ),
                ),
              ),
              child: const Text(
                "Continue Shopping",
              ),
            ),
          ],
        ),
      ),
    );
  }
}