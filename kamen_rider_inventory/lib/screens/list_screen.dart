import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/rider_item.dart';
import '../providers/rider_provider.dart';
import 'form_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  String searchQuery = '';
  bool isAscending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการของสะสม'),
        actions: [
          IconButton(
            icon: Icon(isAscending ? Icons.sort_by_alpha : Icons.sort),
            tooltip: 'เรียงลำดับ A-Z / Z-A',
            onPressed: () {
              setState(() {
                isAscending = !isAscending;
              });
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'ค้นหาชื่อไอเทม...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          Expanded(
            child: Consumer<RiderProvider>(
              builder: (context, provider, child) {
                List<RiderItem> items = searchQuery.isEmpty 
                  ? List.from(provider.items) 
                  : List.from(provider.searchItems(searchQuery));
                
                items.sort((a, b) => isAscending 
                  ? a.name.compareTo(b.name) 
                  : b.name.compareTo(a.name));

                if (items.isEmpty) return const Center(child: Text('ไม่มีข้อมูล'));

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      child: Dismissible(
                        key: Key(item.id.toString()),
                        background: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFD32F2F),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.centerRight, 
                          padding: const EdgeInsets.only(right: 20), 
                          child: const Icon(Icons.delete, color: Colors.white, size: 30)
                        ),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('ยืนยันการลบ', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFD32F2F))),
                              content: const Text('ต้องการลบรายการนี้ใช่หรือไม่?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('ยกเลิก', style: TextStyle(color: Colors.grey))),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD32F2F)),
                                  onPressed: () => Navigator.of(context).pop(true), 
                                  child: const Text('ลบ')
                                ),
                              ],
                            ),
                          );
                        },
                        onDismissed: (direction) {
                          provider.deleteItem(item.id!);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ลบข้อมูลสำเร็จ'), backgroundColor: Color(0xFF006442)));
                        },
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: CircleAvatar(
                            backgroundColor: item.status == 'Collected' ? const Color(0xFF006442) : const Color(0xFFD32F2F),
                            child: Icon(item.status == 'Collected' ? Icons.check : Icons.favorite, color: Colors.white),
                          ),
                          title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('ยุค: ${item.era} | ประเภท: ${item.type}'),
                          ),
                          trailing: const Icon(Icons.edit_note),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FormScreen(item: item))),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FormScreen())),
        child: const Icon(Icons.add),
      ),
    );
  }
}