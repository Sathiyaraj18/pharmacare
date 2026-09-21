import 'package:flutter/material.dart';

class BreadcrumbItem {
  final String title;
  final VoidCallback? onTap;

  const BreadcrumbItem({
    required this.title,
    this.onTap,
  });
}

class Breadcrumb extends StatelessWidget {
  final List<BreadcrumbItem> items;

  const Breadcrumb({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(
        items.length,
        (index) {
          final item = items[index];
          final isLast = index == items.length - 1;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (index > 0)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              InkWell(
                onTap: isLast ? null : item.onTap,
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isLast
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isLast
                          ? Colors.black87
                          : Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
