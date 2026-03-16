import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/rider_item.dart';
import '../providers/rider_provider.dart';

class FormScreen extends StatefulWidget {
  final RiderItem? item;

  const FormScreen({super.key, this.item});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String era = 'Showa';
  String type = 'Belt';
  String status = 'Wishlist';
  DateTime selectedDate = DateTime.now(); 

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      name = widget.item!.name;
      era = widget.item!.era;
      type = widget.item!.type;
      status = widget.item!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item == null ? 'เพิ่มของสะสมใหม่' : 'แก้ไขข้อมูล')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(
                  labelText: 'ชื่อไอเทม (เช่น V1 Typhoon)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'กรุณาระบุชื่อไอเทม' : null,
                onSaved: (value) => name = value!.trim(),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: era,
                decoration: InputDecoration(
                  labelText: 'ยุค (Era)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: ['Showa', 'Heisei', 'Reiwa'].map((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                onChanged: (newValue) => setState(() => era = newValue!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: type,
                decoration: InputDecoration(
                  labelText: 'ประเภท (Type)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: ['Belt', 'Figure', 'Card', 'Weapon'].map((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                onChanged: (newValue) => setState(() => type = newValue!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: status,
                decoration: InputDecoration(
                  labelText: 'สถานะ (Status)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: ['Collected', 'Wishlist'].map((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                onChanged: (newValue) => setState(() => status = newValue!),
              ),
              const SizedBox(height: 16),
              
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  title: Text('วันที่อัปเดต: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.calendar_month, color: Color(0xFF006442)),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Color(0xFF006442), 
                              onPrimary: Colors.white,
                              onSurface: Colors.black,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                ),
              ),

              const SizedBox(height: 32),
              SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save, size: 28),
                  label: const Text('บันทึกข้อมูล', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final newItem = RiderItem(id: widget.item?.id, name: name, era: era, type: type, status: status);
                      final provider = Provider.of<RiderProvider>(context, listen: false);

                      if (widget.item == null) {
                        provider.addItem(newItem);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('บันทึกข้อมูลสำเร็จ!'), backgroundColor: Color(0xFF006442)));
                      } else {
                        provider.updateItem(newItem);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('อัปเดตข้อมูลสำเร็จ!'), backgroundColor: Color(0xFF006442)));
                      }
                      Navigator.pop(context);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}