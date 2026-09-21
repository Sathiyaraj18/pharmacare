import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../widgets/web_layout.dart';
import '../../widgets/breadcrumb.dart';
import 'medicines_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() =>
      _OrdersScreenState();
}

class _OrdersScreenState
    extends State<OrdersScreen> {
  String selectedFilter = "All Orders";
  String searchText = "";

  final List<Map<String, dynamic>> orders = [
    {
      "id": "PC-102451",
      "date": "16 Sep 2026",
      "medicine": "Slew 2 mg",
      "stockist": "VV Pharma",
      "quantity": 2,
      "amount": "₹420.00",
      "status": "Delivered",
      "paymentStatus": "Paid",
      "delivery": "Delivered on 15 Sep 2026",
    },
    {
      "id": "PC-102188",
      "date": "13 Sep 2026",
      "medicine": "CardioSafe 10 mg",
      "stockist": "Premier Pharma",
      "quantity": 3,
      "amount": "₹750.00",
      "status": "Delivered",
      "paymentStatus": "Paid",
      "delivery": "Delivered on 14 Sep 2026",
    },
    {
      "id": "PC-101947",
      "date": "10 Sep 2026",
      "medicine": "Diabetix 500 mg",
      "stockist": "Krishna Pharma",
      "quantity": 5,
      "amount": "₹1,150.00",
      "status": "Processing",
      "paymentStatus": "Paid",
      "delivery": "Expected delivery 18 Sep 2026",
    },
    {
      "id": "PC-101725",
      "date": "07 Sep 2026",
      "medicine": "HeartCare 20 mg",
      "stockist": "ABC Pharma",
      "quantity": 2,
      "amount": "₹540.00",
      "status": "Shipped",
      "paymentStatus": "Paid",
      "delivery": "Expected delivery 17 Sep 2026",
    },
    {
      "id": "PC-101492",
      "date": "03 Sep 2026",
      "medicine": "NeuroCare 25 mg",
      "stockist": "Premier Pharma",
      "quantity": 1,
      "amount": "₹280.00",
      "status": "Cancelled",
      "paymentStatus": "Refunded",
      "delivery": "Order cancelled",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final String query =
    searchText.trim().toLowerCase();

    final List<Map<String, dynamic>>
    filteredOrders = orders.where((order) {
      final bool matchesSearch =
          order["id"]
              .toString()
              .toLowerCase()
              .contains(query) ||
              order["medicine"]
                  .toString()
                  .toLowerCase()
                  .contains(query) ||
              order["stockist"]
                  .toString()
                  .toLowerCase()
                  .contains(query);

      final bool matchesFilter =
          selectedFilter == "All Orders" ||
              order["status"] == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();

    return WebLayout(
      title: "My Orders",
      menu: "doctor",
      breadcrumbItems: const [
        BreadcrumbItem(title: "Dashboard"),
        BreadcrumbItem(title: "My Orders"),
      ],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const Breadcrumb(
              items: [
                BreadcrumbItem(
                  title: "Dashboard",
                ),
                BreadcrumbItem(
                  title: "My Orders",
                ),
              ],
            ),

            const SizedBox(height: 24),

            _pageHeader(),

            const SizedBox(height: 28),

            _summaryCards(),

            const SizedBox(height: 30),

            _searchAndFilter(),

            const SizedBox(height: 22),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Recent Orders",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "${filteredOrders.length} orders",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            if (filteredOrders.isEmpty)
              _emptyOrders()
            else
              ...filteredOrders.map(
                    (order) => _orderCard(order),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PAGE HEADER
  // ============================================================

  Widget _pageHeader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmall =
            constraints.maxWidth < 700;

        if (isSmall) {
          return Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Text(
                "My Orders",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                "View and manage all your medicine orders.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 18),
              _continueShoppingButton(),
            ],
          );
        }

        return Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Orders",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    "View and manage all your medicine orders.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            _continueShoppingButton(),
          ],
        );
      },
    );
  }

  Widget _continueShoppingButton() {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
            const MedicinesScreen(),
          ),
        );
      },
      icon: const Icon(
        Icons.shopping_bag_outlined,
      ),
      label: const Text(
        "Continue Shopping",
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(180, 48),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  // ============================================================
  // SUMMARY
  // ============================================================

  Widget _summaryCards() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _summaryCard(
          title: "Total Orders",
          value: "${orders.length}",
          icon: Icons.shopping_bag_outlined,
          iconBackground:
          const Color(0xffE8F3FF),
          iconColor:
          const Color(0xff1976D2),
        ),
        _summaryCard(
          title: "Processing",
          value:
          "${_countStatus("Processing")}",
          icon: Icons.pending_actions_outlined,
          iconBackground:
          const Color(0xfffff3cd),
          iconColor: Colors.orange,
        ),
        _summaryCard(
          title: "Shipped",
          value:
          "${_countStatus("Shipped")}",
          icon: Icons.local_shipping_outlined,
          iconBackground:
          const Color(0xffE8F1FF),
          iconColor: Colors.blue,
        ),
        _summaryCard(
          title: "Delivered",
          value:
          "${_countStatus("Delivered")}",
          icon: Icons.check_circle_outline,
          iconBackground:
          const Color(0xffEAF8EF),
          iconColor: Colors.green,
        ),
      ],
    );
  }

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconBackground,
    required Color iconColor,
  }) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius:
              BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _countStatus(String status) {
    return orders
        .where(
          (order) => order["status"] == status,
    )
        .length;
  }

  // ============================================================
  // SEARCH + FILTER
  // ============================================================

  Widget _searchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isSmall =
              constraints.maxWidth < 750;

          if (isSmall) {
            return Column(
              children: [
                _searchField(),
                const SizedBox(height: 14),
                _filterDropdown(),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                child: _searchField(),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 200,
                child: _filterDropdown(),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _searchField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
      decoration: InputDecoration(
        hintText:
        "Search order, medicine or stockist...",
        prefixIcon: const Icon(
          Icons.search,
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _filterDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedFilter,
      decoration: InputDecoration(
        labelText: "Order Status",
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: const [
        DropdownMenuItem(
          value: "All Orders",
          child: Text("All Orders"),
        ),
        DropdownMenuItem(
          value: "Processing",
          child: Text("Processing"),
        ),
        DropdownMenuItem(
          value: "Shipped",
          child: Text("Shipped"),
        ),
        DropdownMenuItem(
          value: "Delivered",
          child: Text("Delivered"),
        ),
        DropdownMenuItem(
          value: "Cancelled",
          child: Text("Cancelled"),
        ),
      ],
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          selectedFilter = value;
        });
      },
    );
  }

  // ============================================================
  // ORDER CARD
  // ============================================================

  Widget _orderCard(
      Map<String, dynamic> order,
      ) {
    final String status =
    order["status"].toString();

    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
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
            color:
            Colors.black.withOpacity(0.025),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isSmall =
              constraints.maxWidth < 750;

          if (isSmall) {
            return Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                _orderTopRow(order),
                const SizedBox(height: 18),
                _orderMedicineInfo(order),
                const SizedBox(height: 18),
                _orderBottomRow(order),
              ],
            );
          }

          return Column(
            children: [
              _orderTopRow(order),
              const SizedBox(height: 20),
              _orderMedicineInfo(order),
              const SizedBox(height: 20),
              _orderBottomRow(order),
            ],
          );
        },
      ),
    );
  }

  Widget _orderTopRow(
      Map<String, dynamic> order,
      ) {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: AppColors.lightTeal,
            borderRadius:
            BorderRadius.circular(13),
          ),
          child: Icon(
            Icons.receipt_long_outlined,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                order["id"].toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                order["date"].toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        _statusBadge(
          order["status"].toString(),
        ),
      ],
    );
  }

  Widget _orderMedicineInfo(
      Map<String, dynamic> order,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius:
        BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.medication_outlined,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  order["medicine"].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Stockist: ${order["stockist"]}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Quantity: ${order["quantity"]}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Text(
            order["amount"].toString(),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderBottomRow(
      Map<String, dynamic> order,
      ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isSmall =
            constraints.maxWidth < 600;

        if (isSmall) {
          return Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              _paymentStatus(order),
              const SizedBox(height: 10),
              Text(
                order["delivery"].toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _showOrderDetails(order);
                  },
                  child: const Text(
                    "View Details",
                  ),
                ),
              ),
            ],
          );
        }

        return Row(
          children: [
            _paymentStatus(order),

            const SizedBox(width: 20),

            Expanded(
              child: Text(
                order["delivery"].toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),

            OutlinedButton(
              onPressed: () {
                _showOrderDetails(order);
              },
              child: const Text(
                "View Details",
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _paymentStatus(
      Map<String, dynamic> order,
      ) {
    final String payment =
    order["paymentStatus"].toString();

    final bool paid =
        payment == "Paid";

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          paid
              ? Icons.verified_outlined
              : Icons.info_outline,
          size: 17,
          color:
          paid ? Colors.green : Colors.orange,
        ),
        const SizedBox(width: 6),
        Text(
          "Payment: $payment",
          style: TextStyle(
            color:
            paid ? Colors.green : Colors.orange,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // STATUS BADGE
  // ============================================================

  Widget _statusBadge(String status) {
    Color color;
    Color background;

    switch (status) {
      case "Delivered":
        color = Colors.green;
        background = Colors.green.shade50;
        break;

      case "Processing":
        color = Colors.orange;
        background = Colors.orange.shade50;
        break;

      case "Shipped":
        color = Colors.blue;
        background = Colors.blue.shade50;
        break;

      case "Cancelled":
        color = Colors.red;
        background = Colors.red.shade50;
        break;

      default:
        color = Colors.grey;
        background = Colors.grey.shade100;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius:
        BorderRadius.circular(30),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // ORDER DETAILS
  // ============================================================

  void _showOrderDetails(
      Map<String, dynamic> order,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(22),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 550,
            ),
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Order Details",
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                    ],
                  ),

                  const Divider(),

                  const SizedBox(height: 15),

                  _detailRow(
                    "Order ID",
                    order["id"].toString(),
                  ),

                  _detailRow(
                    "Date",
                    order["date"].toString(),
                  ),

                  _detailRow(
                    "Medicine",
                    order["medicine"].toString(),
                  ),

                  _detailRow(
                    "Stockist",
                    order["stockist"].toString(),
                  ),

                  _detailRow(
                    "Quantity",
                    order["quantity"].toString(),
                  ),

                  _detailRow(
                    "Amount",
                    order["amount"].toString(),
                  ),

                  _detailRow(
                    "Payment",
                    order["paymentStatus"]
                        .toString(),
                  ),

                  _detailRow(
                    "Status",
                    order["status"].toString(),
                  ),

                  _detailRow(
                    "Delivery",
                    order["delivery"].toString(),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        AppColors.primary,
                        foregroundColor:
                        Colors.white,
                      ),
                      child: const Text(
                        "Close",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY ORDERS
  // ============================================================

  Widget _emptyOrders() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 70,
        horizontal: 20,
      ),
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
              color: AppColors.lightTeal,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.receipt_long_outlined,
              color: AppColors.primary,
              size: 45,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "No orders found",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Try another search or browse medicines.",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 22),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const MedicinesScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.medication_outlined,
            ),
            label: const Text(
              "Browse Medicines",
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor:
              AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}