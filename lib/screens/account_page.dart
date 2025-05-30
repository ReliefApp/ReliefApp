import 'package:flutter/material.dart';
import 'login_page.dart';

class AccountPage extends StatefulWidget {
  final String email; // 🔹 Login/Register'dan alınan e-posta
  const AccountPage({super.key, required this.email});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _newEmailController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  String? email;

  @override
  void initState() {
    super.initState();
    email = widget.email; // 🔹 Email RegisterPage'den geliyor
  }

  void _updateProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profil bilgileri güncellendi (ön yüz).")),
    );
  }

  void _updatePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Şifre güncellendi (ön yüz).")),
    );
  }

  void _updateEmail() {
    setState(() {
      email = _newEmailController.text.trim();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("E-posta güncellendi (ön yüz).")),
    );
  }

  void _signOut(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hesabım"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
            tooltip: "Çıkış Yap",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Profil Bilgileri",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text("E-posta: ${email ?? ''}"),
            const Divider(height: 32),

            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Ad Soyad"),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: "Adres"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _updateProfile,
              child: const Text("Profil Bilgilerini Güncelle"),
            ),

            const Divider(height: 40),
            const Text(
              "Şifre Güncelle",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Mevcut Şifre"),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Yeni Şifre"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _updatePassword,
              child: const Text("Şifreyi Güncelle"),
            ),

            const Divider(height: 40),
            const Text(
              "E-posta Güncelle",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _newEmailController,
              decoration: const InputDecoration(labelText: "Yeni E-posta"),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _updateEmail,
              child: const Text("E-posta Güncelle"),
            ),
          ],
        ),
      ),
    );
  }
}
