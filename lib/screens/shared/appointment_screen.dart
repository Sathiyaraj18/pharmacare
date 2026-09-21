import 'package:flutter/material.dart';
import '../../widgets/web_layout.dart';

class AppointmentScreen extends StatefulWidget {
  final String doctor;

  const AppointmentScreen({
    super.key,
    required this.doctor,
  });

  @override
  State<AppointmentScreen> createState() =>
      _AppointmentScreenState();
}

class _AppointmentScreenState
    extends State<AppointmentScreen> {

  String date = "12 Sep 2026";
  String time = "10:00 AM";

  @override
  Widget build(BuildContext context) {
    return WebLayout(
      title: "Request Appointment",
      menu: "mr",
      child: Center(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              Text(
                widget.doctor,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                "Cardiology",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Select Date",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: date,
                items: const [
                  DropdownMenuItem(
                    value: "12 Sep 2026",
                    child: Text("12 Sep 2026"),
                  ),
                  DropdownMenuItem(
                    value: "13 Sep 2026",
                    child: Text("13 Sep 2026"),
                  ),
                  DropdownMenuItem(
                    value: "15 Sep 2026",
                    child: Text("15 Sep 2026"),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    date = value!;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Select Time",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 10,
                children: [
                  timeChip("10:00 AM"),
                  timeChip("10:30 AM"),
                  timeChip("11:00 AM"),
                  timeChip("11:30 AM"),
                ],
              ),

              const SizedBox(height: 25),

              const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Purpose",
                  hintText: "Medicine presentation",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Appointment request sent",
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "SEND APPOINTMENT REQUEST",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget timeChip(String value) {
    return ChoiceChip(
      label: Text(value),
      selected: time == value,
      onSelected: (_) {
        setState(() {
          time = value;
        });
      },
    );
  }
}

