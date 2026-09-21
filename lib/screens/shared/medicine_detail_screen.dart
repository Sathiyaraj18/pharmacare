import 'package:flutter/material.dart';
import 'cart_screen.dart';
import '../../widgets/web_layout.dart';

class MedicineDetailScreen extends StatefulWidget {
  final String medicine;
  final String molecule;

  const MedicineDetailScreen({
    super.key,
    required this.medicine,
    required this.molecule,
  });

  @override
  State<MedicineDetailScreen> createState() =>
      _MedicineDetailScreenState();
}

class _MedicineDetailScreenState
    extends State<MedicineDetailScreen> {

  String strength = "2 mg";
  String stockist = "VV Pharma";
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: "Medicine Details",
      menu: "doctor",
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 900,
          ),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                widget.medicine,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Molecule: ${widget.molecule}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Available Strengths",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Wrap(
                spacing: 12,
                children: [
                  strengthButton("1 mg"),
                  strengthButton("2 mg"),
                  strengthButton("5 mg"),
                  strengthButton("10 mg"),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Select Stockist / Delivery Partner",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              stockistTile("VV Pharma"),
              stockistTile("Krishna Pharma"),
              stockistTile("Meenakshi Distributors"),
              stockistTile("Premier Pharma"),

              const SizedBox(height: 25),

              Row(
                children: [

                  const Text(
                    "Quantity",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 20),

                  IconButton(
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                    ),
                  ),

                  Text(
                    "$quantity",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const CartScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                  ),
                  label: const Text(
                    "ADD TO CART",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget strengthButton(String value) {
    bool selected = strength == value;

    return ChoiceChip(
      label: Text(value),
      selected: selected,
      onSelected: (_) {
        setState(() {
          strength = value;
        });
      },
    );
  }

  Widget stockistTile(String name) {
    return Card(
      child: RadioListTile<String>(
        value: name,
        groupValue: stockist,
        onChanged: (value) {
          setState(() {
            stockist = value!;
          });
        },
        title: Text(name),
        subtitle: const Text(
          "✓ Available • Delivery Tomorrow",
        ),
      ),
    );
  }
}

