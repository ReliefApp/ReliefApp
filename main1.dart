import 'package:flutter/material.dart';

void main() {
  runApp(ReliefApp());
}

class ReliefApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset _buttonPosition = Offset(300, 500); // İlk konum

  final categories = [
    {
      'title': 'Gıda ve Su',
      'icon': Image.asset("assets/icons/gida.png", width: 100, height: 100),
      'products': [
        {'name': 'Su', 'icon': Image.asset("assets/gida/su.png", width: 170, height: 170), 'count': 0},
        {'name': 'Kuru Gıda', 'icon': Image.asset("assets/gida/kuru.png", width: 170, height: 170), 'count': 0},
      ]
    },
    {
      'title': 'Giyim ve Tekstil',
      'icon': Image.asset("assets/icons/giyim.png", width: 100, height: 100),
      'products': [
        {'name': 'Mont', 'icon': Image.asset("assets/giyim/mont.png", width: 170, height: 170), 'count': 0},
        {'name': 'Pantolon', 'icon': Image.asset("assets/giyim/pantolon.png", width: 170, height: 170), 'count': 0},
      ]
    },
    {
      'title': 'Hijyen ve Sağlık',
      'icon': Image.asset("assets/icons/hijyen.png", width: 100, height: 100),
      'products': [
        {'name': 'Kağıt Havlu', 'icon': Image.asset("assets/hijyen/kagithavlu.png", width: 170, height: 170), 'count': 0},
        {'name': 'Islak Mendil', 'icon': Image.asset("assets/hijyen/islakmendil.png", width: 170, height: 170), 'count': 1},
      ]
    },
    {
      'title': 'Barınma ve Isınma',
      'icon': Image.asset("assets/icons/barinma.png", width: 100, height: 100),
      'products': [
        {'name': 'Battaniye', 'icon': Image.asset("assets/barinma/battaniye.png", width: 170, height: 170), 'count': 0},
        {'name': 'Çadır', 'icon': Image.asset("assets/barinma/cadir.png", width: 170, height: 170), 'count': 0},
      ]
    },
    {
      'title': 'Eğitim ve Kırtasiye',
      'icon': Image.asset("assets/icons/egitim.png", width: 100, height: 100),
      'products': [
        {'name': 'Defter', 'icon': Image.asset("assets/egitim/defter.png", width: 170, height: 170), 'count': 0},
        {'name': 'Kalem', 'icon': Image.asset("assets/egitim/kalem.png", width: 170, height: 170), 'count': 0},
      ]
    },
    {
      'title': 'Bebek ve Çocuk',
      'icon': Image.asset("assets/icons/bebek.png", width: 100, height: 100),
      'products': [
        {'name': 'Bebek Bezi', 'icon': Image.asset("assets/bebek/bezi.png", width: 170, height: 170), 'count': 0},
        {'name': 'Mama', 'icon': Image.asset("assets/bebek/mama.png", width: 170, height: 170), 'count': 0},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Ara...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: categories.map((category) {
                      return CategoryCard(
                        title: category['title'] as String,
                        icon: category['icon'] as Widget,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryDetailPage(
                                title: category['title'] as String,
                                products: category['products'] as List<Map<String, dynamic>>,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: _buttonPosition.dx,
            top: _buttonPosition.dy,
            child: Draggable(
              feedback: ChatButton(),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                setState(() {
                  _buttonPosition = details.offset;
                });
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage()));
                },
                child: ChatButton(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Hesabım'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Taleplerim'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class ChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.chat, color: Colors.white, size: 27),
    );
  }
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sohbet")),
      body: Center(child: Text("Burada bir sohbet arayüzü olacak")),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;

  const CategoryCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: icon,
            ),
          ),
          SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CategoryDetailPage extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> products;

  CategoryDetailPage({required this.title, required this.products});

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    int totalItems = widget.products.fold(0, (sum, item) => sum + (item['count'] as int));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.pink[100],
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(Icons.shopping_basket_outlined, size: 28),
                if (totalItems > 0)
                  CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text('$totalItems', style: TextStyle(fontSize: 10, color: Colors.white)),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: List.generate(widget.products.length, (index) {
          final product = widget.products[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                product['count']++;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 80, height: 80, child: product['icon']),
                        SizedBox(height: 8),
                        Text(product['name'], style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, size: 14, color: Colors.black),
                          if (product['count'] > 0) ...[
                            SizedBox(width: 4),
                            Text('${product['count']}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ]
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Hesabım'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Taleplerim'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
