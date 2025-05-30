import 'package:flutter/material.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Geçici örnek talepler listesi (Firebase'den çekilecek verilerle değiştirilebilir)
    final List<Map<String, dynamic>> sampleRequests = [
      {
        'title': 'Gıda Yardımı',
        'description': '2 koli kuru gıda ve içme suyu talebi',
        'status': 'Beklemede',
      },
      {
        'title': 'Isınma',
        'description': '1 adet battaniye ve 1 çadır talebi',
        'status': 'Onaylandı',
      },
      {
        'title': 'Hijyen Ürünleri',
        'description': 'Sabun, şampuan, ped, ıslak mendil',
        'status': 'Teslim Edildi',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Taleplerim')),
      body: sampleRequests.isEmpty
          ? const Center(
              child: Text(
                "Henüz bir yardım talebiniz bulunmamaktadır.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sampleRequests.length,
              itemBuilder: (context, index) {
                final request = sampleRequests[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.request_page_outlined,
                      color: Colors.teal,
                    ),
                    title: Text(request['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(request['description']),
                        const SizedBox(height: 4),
                        Text(
                          "Durum: ${request['status']}",
                          style: TextStyle(
                            color: request['status'] == 'Teslim Edildi'
                                ? Colors.green
                                : request['status'] == 'Onaylandı'
                                ? Colors.orange
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
