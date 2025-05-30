import 'package:flutter/material.dart';
import 'account_page.dart';
import 'app_wrapper.dart';
import 'requests_page.dart';
import 'category_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  final Map<String, Color> categoryColors = {
    'Gıda ve Su': const Color.fromARGB(255, 189, 220, 240),
    'Giyim ve Tekstil': const Color.fromARGB(255, 195, 231, 223),
    'Hijyen ve Sağlık': const Color.fromARGB(255, 235, 199, 202),
    'Barınma ve Isınma': const Color.fromARGB(255, 249, 236, 181),
    'Eğitim ve Kırtasiye': const Color.fromARGB(255, 238, 190, 158),
    'Bebek ve Çocuk': const Color.fromARGB(255, 194, 179, 215),
  };

  Widget safeImage(String path, {double? width, double? height}) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.image_not_supported,
          size: width ?? 100,
          color: Colors.grey,
        );
      },
    );
  }

  final List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    categories.addAll([
      {
        'title': 'Gıda ve Su',
        'icon': safeImage("assets/icons/gida.png", width: 100, height: 100),
        'products': [
          {
            'name': 'Su',
            'icon': safeImage("assets/gida/su.png", width: 170, height: 170),
            'count': 0,
          },
          {
            'name': 'Kuru Gıda',
            'icon': safeImage("assets/gida/kuru.png", width: 170, height: 170),
            'count': 0,
          },
        ],
      },
      {
        'title': 'Giyim ve Tekstil',
        'icon': safeImage("assets/icons/giyim.png", width: 100, height: 100),
        'products': [
          {
            'name': 'Mont',
            'icon': safeImage("assets/giyim/mont.png", width: 170, height: 170),
            'count': 0,
          },
          {
            'name': 'Pantolon',
            'icon': safeImage(
              "assets/giyim/pantolon.png",
              width: 170,
              height: 170,
            ),
            'count': 0,
          },
        ],
      },
      {
        'title': 'Hijyen ve Sağlık',
        'icon': safeImage("assets/icons/hijyen.png", width: 100, height: 100),
        'products': [
          {
            'name': 'Kağıt Havlu',
            'icon': safeImage(
              "assets/hijyen/kagithavlu.png",
              width: 170,
              height: 170,
            ),
            'count': 0,
          },
          {
            'name': 'Islak Mendil',
            'icon': safeImage(
              "assets/hijyen/islakmendil.png",
              width: 170,
              height: 170,
            ),
            'count': 0,
          },
        ],
      },
      {
        'title': 'Barınma ve Isınma',
        'icon': safeImage("assets/icons/barinma.png", width: 100, height: 100),
        'products': [
          {
            'name': 'Battaniye',
            'icon': safeImage(
              "assets/barinma/battaniye.png",
              width: 170,
              height: 170,
            ),
            'count': 0,
          },
          {
            'name': 'Çadır',
            'icon': safeImage(
              "assets/barinma/cadir.png",
              width: 170,
              height: 170,
            ),
            'count': 0,
          },
        ],
      },
      {
        'title': 'Eğitim ve Kırtasiye',
        'icon': safeImage("assets/icons/egitim.png", width: 100, height: 100),
        'products': [
          {
            'name': 'Defter',
            'icon': safeImage(
              "assets/egitim/defter.png",
              width: 170,
              height: 170,
            ),
            'count': 0,
          },
          {
            'name': 'Kalem',
            'icon': safeImage(
              "assets/egitim/kalem.png",
              width: 170,
              height: 170,
            ),
            'count': 0,
          },
        ],
      },
      {
        'title': 'Bebek ve Çocuk',
        'icon': safeImage("assets/icons/bebek.png", width: 100, height: 100),
        'products': [
          {
            'name': 'Bebek Bezi',
            'icon': safeImage("assets/bebek/bezi.png", width: 170, height: 170),
            'count': 0,
          },
          {
            'name': 'Mama',
            'icon': safeImage("assets/bebek/mama.png", width: 170, height: 170),
            'count': 0,
          },
        ],
      },
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        return AppWrapper(child: const AccountPage(email: ''));
      case 2:
        return AppWrapper(child: const RequestsPage());
      default:
        return AppWrapper(child: _buildCategoryList());
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
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.shopping_basket_outlined, size: 28),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
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
                          builder: (_) => AppWrapper(
                            child: CategoryDetailPage(
                              title: title,
                              products:
                                  category['products']
                                      as List<Map<String, dynamic>>,
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
      body: Stack(children: [_getCurrentPage()]),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Hesabım'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Taleplerim',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: icon,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
