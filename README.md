# 🏍️ Kamen Rider Inventory App

โปรเจกต์สอบปฏิบัติปลายภาค 2/68
รายวิชา: ENGSE608 Mobile Devices Application Design and Development

## 👨‍💻 ข้อมูลผู้จัดทำ
- **ชื่อ-สกุล:** ตรีรัตน์ วงศ์สิทธิ์ (Trirat Wongsit)
- **รหัสนักศึกษา:** 67543210028-6
- **เลขที่:** 2

---

## 📱 รายละเอียดฟังก์ชัน (Features)

แอปพลิเคชันสำหรับจัดการคลังของสะสม Kamen Rider โดยมีฟังก์ชันการทำงานครบถ้วนตามข้อกำหนด ดังนี้:

### ฟังก์ชันบังคับ (Core Features)
- **Dashboard:** หน้าสรุปผลข้อมูล แสดงจำนวนไอเทมทั้งหมด, จำนวนที่เก็บสะสมแล้ว และรายการที่อยากได้ (Wishlist)
- **CRUD Operations:** สามารถ เพิ่ม (Add), แสดงผล (Read), แก้ไข (Update) และลบ (Delete) ข้อมูลของสะสมได้
- **Search:** ค้นหาและกรองข้อมูลของสะสมจากชื่อไอเทมได้
- **State Management:** ใช้ `Provider` ในการเชื่อมการทำงานระหว่าง UI และฐานข้อมูล
- **Local Database:** เก็บข้อมูลจริงในเครื่องด้วย SQLite
- **Validation:** มีการตรวจสอบข้อมูลในฟอร์ม ป้องกันการบันทึกข้อมูลหากกรอกไม่ครบถ้วน
- **Notifications:** มี SnackBar แจ้งเตือนเมื่อทำการเพิ่ม, แก้ไข หรือลบข้อมูลสำเร็จ

### ฟังก์ชันเสริม (Extra Features)
- **เรียงลำดับข้อมูล:** สามารถกดเรียงลำดับชื่อไอเทมจาก A-Z หรือ Z-A ได้ที่หน้ารายการ
- **สถิติแบบกราฟง่ายๆ:** แสดงแถบความคืบหน้า (Progress Bar) สัดส่วนของสะสมในหน้า Dashboard
- **Dismissible:** สามารถปัดรายการไปทางซ้ายเพื่อลบข้อมูลได้
- **Dialog ยืนยัน:** มีหน้าต่าง Pop-up ขึ้นมาถามยืนยันก่อนทำการลบข้อมูลทุกครั้ง
- **Dropdown:** ใช้สำหรับเลือก ยุค (Era), ประเภท (Type) และ สถานะ (Status)
- **DatePicker:** มีปุ่มปฏิทินสำหรับเลือกวันที่อัปเดตข้อมูลในหน้าฟอร์ม

---

## 🗄️ โครงสร้างฐานข้อมูล (Database Structure)

ใช้ SQLite (sqflite) โดยมีการออกแบบโครงสร้าง 2 ตาราง ดังนี้:

**1. ตาราง `eras` (ตารางรอง - ข้อมูลยุค)**
| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | INTEGER | Primary Key (Auto Increment) |
| `name` | TEXT | ชื่อยุค (เช่น Showa, Heisei, Reiwa) |

**2. ตาราง `items` (ตารางหลัก - ข้อมูลของสะสม)**
| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | INTEGER | Primary Key (Auto Increment) |
| `name` | TEXT | ชื่อของสะสม (เช่น V1 Typhoon) |
| `era` | TEXT | ยุคของ Rider |
| `type` | TEXT | ประเภทของสะสม (เช่น Belt, Figure) |
| `status` | TEXT | สถานะ (Collected, Wishlist) |

---

## 📦 Package ที่ใช้ (Dependencies)

- `flutter`: SDK
- `provider`: ^6.1.5+1 (สำหรับจัดการ State ภายในแอป)
- `sqflite`: ^2.4.2 (สำหรับจัดการ Local Database)
- `path`: ^1.9.1 (สำหรับจัดการ Path ของไฟล์ Database)

---

## 🚀 วิธีรันโปรเจกต์ (How to Run)

1. Clone repository นี้ลงมาที่เครื่อง
2. เปิด Terminal แล้วเข้าไปที่โฟลเดอร์โปรเจกต์
3. รันคำสั่งเพื่อดาวน์โหลดแพ็กเกจที่จำเป็น:
   ```bash
   flutter pub get