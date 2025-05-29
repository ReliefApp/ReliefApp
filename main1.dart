import 'package:flutter/material.dart';

void main() {
  runApp(ReliefApp());
}

class ReliefApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppWrapper(child: HomePage()),
    );
  }
}

// APP WRAPPER — Chat butonunu her sayfaya ekler
class AppWrapper extends StatefulWidget {
  final Widget child;

  const AppWrapper({required this.child});

  @override
  _AppWrapperState createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  Offset _buttonPosition = Offset(15, 70);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ChatPage()),
                );
              },
              child: ChatButton(),
            ),
          ),
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Başlangıç Ana Sayfa

  final Map<String, Color> categoryColors = {
    'Gıda ve Su': Color.fromARGB(255, 189, 220, 240),
    'Giyim ve Tekstil': Color.fromARGB(255, 195, 231, 223),
    'Hijyen ve Sağlık': Color.fromARGB(255, 235, 199, 202),
    'Barınma ve Isınma': Color.fromARGB(255, 249, 236, 181),
    'Eğitim ve Kırtasiye': Color.fromARGB(255, 238, 190, 158),
    'Bebek ve Çocuk': Color.fromARGB(255, 194, 179, 215),
  };

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
        {'name': 'Hijyenik Ped', 'icon': Image.asset("assets/gida/su.png", width: 170, height: 170), 'count': 0},
        {'name': 'Ağız Bakım', 'icon': Image.asset("assets/gida/su.png", width: 170, height: 170), 'count': 0},
        {'name': 'Tuvalet Kağıdı', 'icon': Image.asset("assets/gida/su.png", width: 170, height: 170), 'count': 0},
        {'name': 'Dezenfektan', 'icon': Image.asset("assets/gida/su.png", width: 170, height: 170), 'count': 0},
        {'name': 'Maske', 'icon': Image.asset("assets/gida/su.png", width: 170, height: 170), 'count': 0},
        {'name': 'Sabun', 'icon': Image.asset("assets/gida/su.png", width: 170, height: 170), 'count': 0},
        {'name': 'Şampuan', 'icon': Image.asset("assets/gida/su.png", width: 170, height: 170), 'count': 0},
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getCurrentPage() {
    if (_selectedIndex == 0) {
      return AccountPage();
    } else if (_selectedIndex == 2) {
      return RequestsPage();
    } else {
      // Ana Sayfa (kategori listesi)
      return _buildCategoryList();
    }
  }

  Widget _buildCategoryList() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Ara...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.shopping_basket_outlined, size: 28),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: categories.map((category) {
                  final title = category['title'] as String;
                  final color = categoryColors[title] ?? Colors.grey.shade200;
                  return CategoryCard(
                    title: title,
                    icon: category['icon'] as Widget,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppWrapper(
                            child: CategoryDetailPage(
                              title: title,
                              products: category['products'] as List<Map<String, dynamic>>,
                              backgroundColor: color,
                            ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _getCurrentPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Hesabım'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Taleplerim'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hesabım'),
      ),
      body: Center(
        child: Text(
          'Hesabım sayfası içeriği buraya gelecek',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class RequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taleplerim'),
      ),
      body: Center(
        child: Text(
          'Taleplerim sayfası içeriği buraya gelecek',
          style: TextStyle(fontSize: 18),
        ),
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
  final Color backgroundColor; // Yeni eklendi

  CategoryDetailPage({
    required this.title,
    required this.products,
    required this.backgroundColor,
  });

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  void initState() {
    super.initState();
    // Ürünlere plusCount ekleyelim, başlangıç 0
    for (var product in widget.products) {
      product.putIfAbsent('plusCount', () => 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalItems = widget.products.fold(0, (sum, item) => sum + (item['count'] as int));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Arama ve sepet kısmı aynı kalabilir
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Ara...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Stack(
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Center(
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: EdgeInsets.all(16),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: List.generate(widget.products.length, (index) {
                  final product = widget.products[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        product['count'] += 1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.backgroundColor, // Burada kategori rengi kullanılıyor
                        borderRadius: BorderRadius.circular(16),
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
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  product['plusCount'] == 0 ? '+' : '+${product['plusCount']}',
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
