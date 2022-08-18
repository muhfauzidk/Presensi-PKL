

import 'package:flutter/material.dart';

class AdminPresenceCard extends StatelessWidget {
  final Map<String, dynamic> userData;
  final Map<String, dynamic>? todayPresenceData;
  const AdminPresenceCard({required this.userData, required this.todayPresenceData});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 24, top: 24, right: 24, bottom: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 239, 69, 61),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // job
          Text(
            userData["kategori"],
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
