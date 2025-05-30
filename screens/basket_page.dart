/*import 'package:flutter/material.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final List<Map<String, dynamic>> basketItems = [
    {'name': 'Islak Mendil', 'count': 1},
    {'name': 'Hijyenik Ped', 'count': 2},
    {'name': 'Tuvalet Kağıdı', 'count': 1},
    {'name': 'Sabun', 'count': 1},
  ];

  void _increaseCount(int index) {
    setState(() {
      basketItems[index]['count'] += 1;
    });
  }

  void _decreaseCount(int index) {
    setState(() {
      if (basketItems[index]['count'] > 0) {
        basketItems[index]['count'] -= 1;
      }
    });
  }

  void _clearBasket() {
    setState(() {
      for (var item in basketItems) {
        item['count'] = 0;
      }
    });
  }

  void _confirmRequest() {
    // Örnek: Talebi onayla
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Talebiniz başarıyla onaylandı!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sepetim")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Ürün listesi başlıkları
            Row(
              children: const [
                Expanded(
                  flex: 3,
                  child: Text(
                    "Ürün Adı",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Adet",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(),

            // Sepet ürünleri
            Expanded(
              child: ListView.builder(
                itemCount: basketItems.length,
                itemBuilder: (context, index) {
                  final item = basketItems[index];
                  return Row(
                    children: [
                      // Ürün Adı
                      Expanded(flex: 3, child: Text(item['name'])),
                      // Adet ve butonlar
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 18),
                              onPressed: () => _decreaseCount(index),
                            ),
                            Text(item['count'].toString()),
                            IconButton(
                              icon: const Icon(Icons.add, size: 18),
                              onPressed: () => _increaseCount(index),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Sepeti Boşalt Butonu
            ElevatedButton(
              onPressed: _clearBasket,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
              ),
              child: const Text("Sepeti Boşalt"),
            ),
            const SizedBox(height: 8),

            // Talebi Onayla Butonu
            ElevatedButton(
              onPressed: _confirmRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text("Talebi Onayla"),
            ),
          ],
        ),
      ),
    );
  }
}
*/
