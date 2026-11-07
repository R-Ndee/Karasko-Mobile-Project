import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F7),

      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.95),
        elevation: 1,
        shadowColor: const Color(0xFF032217).withOpacity(0.2),
        titleSpacing: 16,
        title: Row(
          children: [
            const Icon(Icons.coffee_maker, color: Color(0xFF032217), size: 28),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Karasko",
                      style: TextStyle(
                        color: Color(0xFF032217),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8EAD7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "MANADO",
                        style: TextStyle(
                          color: Color(0xFF022115),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Icon(Icons.circle, color: Color(0xFF68DBA9), size: 6),
                    SizedBox(width: 4),
                    Text(
                      "Buka • Kedai Terpilih",
                      style: TextStyle(color: Color(0xFF424844), fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            width: 80,
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEC),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: const Row(
              children: [
                Icon(Icons.storefront, color: Color(0xFF845326), size: 18),
                SizedBox(width: 4),
                Text("Admin", style: TextStyle(color: Color(0xFF1A1C1B), fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          const SizedBox(width: 16), 
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreetingCard(),
          const SizedBox(height: 20),
          _buildActiveOrderWidget(),
          const SizedBox(height: 20),
          const Text(
            "Pilihan Menu",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF032217)),
          ),
          const SizedBox(height: 12),
          // TODO: Filter kategori dan grid menu
          ],
        ),
      ),
    );
  }

  Widget _buildGreetingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF032217),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selamat Pagi, Trituwat",
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5),
          ),
          SizedBox(height: 8),
          Text(
            "Awali harimu dengan racikan kopi artisanal terbaik langsung dari pemanggang pilihan.",
            style: TextStyle(color: Color(0xFF81A291), fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActiveOrderWidget() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFDCC2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.coffee_maker, color: Color(0xFF2E1500), size: 20),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("SEDANG DI SEDUH • #NG-8492", style: TextStyle(fontSize: 10, color: Color(0xFF845326), fontWeight: FontWeight.bold)),
                  SizedBox(height: 2),
                  Text("1x Flat White Oatmilk", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1A1C1B))),
                ],
              ),
            ],
          ),
          const Icon(Icons.arrow_forward, color: Color(0xFF032217), size: 18),
        ],
      )
    );
  }
}
