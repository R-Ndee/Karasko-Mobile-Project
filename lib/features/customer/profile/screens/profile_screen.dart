import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Variabel state untuk menyimpan nama
  String _userName = "Trituwat";
  
  // Controller untuk menangani input teks saat mengedit nama
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = _userName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // Fungsi untuk memunculkan Dialog (Popup) Edit Nama
  void _showEditNameDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            "Edit Nama", 
            style: TextStyle(color: Color(0xFF032217), fontWeight: FontWeight.bold)
          ),
          content: TextField(
            controller: _nameController,
            cursorColor: const Color(0xFF032217),
            decoration: const InputDecoration(
              hintText: "Masukkan nama baru",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF032217), width: 2),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF032217),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                setState(() {
                  _userName = _nameController.text;
                });
                Navigator.pop(context);
              },
              child: const Text("Simpan", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // Widget Helper untuk Kolom Statistik (Orders, Reviews, Favourites)
  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF032217),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
      ],
    );
  }

  // Widget Helper untuk List Menu dengan Subtitle
  Widget _buildMenuItem({required IconData icon, required String title, required String subtitle, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: Icon(icon, color: const Color(0xFF032217), size: 26),
      title: Text(
        title,
        style: const TextStyle(color: Color(0xFF032217), fontWeight: FontWeight.w600, fontSize: 15),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER STACK (Cover Photo + Avatar overlapping)
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Cover Photo (sementara pakai Container warna aksen cokelat kopi)
                Container(
                  height: 160,
                  width: double.infinity,
                  color: const Color(0xFF8B5A2B).withOpacity(0.8), // Ganti image jika ada
                ),
                // Tombol Back & Settings di atas cover
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.arrow_back, color: Colors.white),
                        const Icon(Icons.settings, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                // Avatar (posisi menabrak garis bawah cover)
                Positioned(
                  bottom: -40,
                  left: 24,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFFAFAFA), width: 4),
                        ),
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xFF81A291),
                          child: Icon(Icons.person, size: 40, color: Colors.white),
                        ),
                      ),
                      // Tombol Kamera untuk Edit
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showEditNameDialog, // Memicu popup edit nama
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF032217),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            // Jarak agar teks tidak tertutup avatar
            const SizedBox(height: 50),

            // INFO PENGGUNA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _userName,
                    style: const TextStyle(
                      color: Color(0xFF032217),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "@${_userName.toLowerCase().replaceAll(' ', '')}", // Username otomatis dari nama
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Good coffee, better days ☕", // Bio
                    style: TextStyle(color: Color(0xFF032217), fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ROW STATISTIK
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatColumn("12", "Orders"),
                  _buildStatColumn("5", "Reviews"),
                  _buildStatColumn("3", "Favourites"),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // MEMBER CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF81A291).withOpacity(0.15), // Hijau muda transparan
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Color(0xFF032217), size: 20),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Member Since", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        SizedBox(height: 2),
                        Text(
                          "Jun 2025",
                          style: TextStyle(color: Color(0xFF032217), fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Divider(color: Color(0xFFE0E0E0), thickness: 1, height: 32),

            // MENU LIST
            _buildMenuItem(
              icon: Icons.receipt_long,
              title: "My Orders",
              subtitle: "Track your orders & history",
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.star_border,
              title: "My Reviews",
              subtitle: "Your feedback matters",
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.location_on_outlined,
              title: "Saved Addresses",
              subtitle: "Manage your delivery addresses",
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.credit_card,
              title: "Payment Methods",
              subtitle: "Cards, e-wallets, and more",
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.settings_outlined,
              title: "Settings",
              subtitle: "App preferences & account",
              onTap: () {},
            ),
            const SizedBox(height: 32), // Spasi bawah agar tidak tertutup navigation bar
          ],
        ),
      ),
    );
  }
}