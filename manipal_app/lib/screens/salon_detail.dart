import 'package:flutter/material.dart';
import 'package:manipal_app/screens/grooming.dart';
//import 'package:your_app_name/models/salon.dart';

class SalonDetailPage extends StatelessWidget {
  final Salon salon;

  const SalonDetailPage({
    Key? key,
    required this.salon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 44),
        child: ListView(
          children: [
            // Salon Header
            _SalonHeader(salon: salon),

            // Contact Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.phone),
                label: const Text(
                  'Call Salon',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: () {
                  // Implement call functionality
                },
              ),
            ),

            const Divider(height: 12),

            // Salon Details Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _DetailRow(
                    icon: Icons.email,
                    title: 'Email',
                    value: salon.email,
                  ),
                  const SizedBox(height: 12),
                  _DetailRow(
                    icon: Icons.phone,
                    title: 'Phone',
                    value: salon.phone,
                  ),
                  const SizedBox(height: 12),
                  _DetailRow(
                    icon: Icons.location_on,
                    title: 'Address',
                    value:
                        'Latitude: ${salon.latitude?.toStringAsFixed(4)}, Longitude: ${salon.longitude?.toStringAsFixed(4)}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SalonHeader extends StatelessWidget {
  final Salon salon;

  const _SalonHeader({
    Key? key,
    required this.salon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue[100],
            child: Icon(Icons.cut, size: 50, color: Colors.blue[800]),
          ),
          const SizedBox(height: 16),
          Text(
            salon.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                '${salon.latitude?.toStringAsFixed(4)}, ${salon.longitude?.toStringAsFixed(4)}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DetailRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.grey),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}