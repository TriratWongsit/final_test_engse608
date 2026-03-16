import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/rider_provider.dart';
import 'list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kamen Rider V1 Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Consumer<RiderProvider>(
        builder: (context, provider, child) {
          final stats = provider.getDashboardStats();
          int total = stats['total'] ?? 0;
          int collected = stats['collected'] ?? 0;
          double progress = total == 0 ? 0.0 : collected / total;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF006442), Color(0xFF1B835B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))
                    ]
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.sports_motorsports, color: Colors.white, size: 48),
                      SizedBox(width: 16),
                      Text(
                        'สรุปข้อมูลคลังสะสม',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    leading: const CircleAvatar(backgroundColor: Colors.grey, child: Icon(Icons.inventory_2, color: Colors.white)),
                    title: const Text('ไอเทมทั้งหมด (Total)', style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('$total', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ),
                Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    leading: const CircleAvatar(backgroundColor: Color(0xFF006442), child: Icon(Icons.check_circle, color: Colors.white)),
                    title: const Text('เก็บแล้ว (Collected)', style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('$collected', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF006442))),
                  ),
                ),
                Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    leading: const CircleAvatar(backgroundColor: Color(0xFFD32F2F), child: Icon(Icons.favorite, color: Colors.white)),
                    title: const Text('อยากได้ (Wishlist)', style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('${stats['wishlist']}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFD32F2F))),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('สัดส่วนการเก็บสะสม', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 20,
                    backgroundColor: const Color(0xFFD32F2F), 
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF006442)), 
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('เก็บแล้ว', style: TextStyle(color: Color(0xFF006442), fontWeight: FontWeight.bold)),
                    Text('ยังไม่มี', style: TextStyle(color: Color(0xFFD32F2F), fontWeight: FontWeight.bold)),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.list_alt, size: 28),
                    label: const Text('จัดการข้อมูลของสะสม', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ListScreen())),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}