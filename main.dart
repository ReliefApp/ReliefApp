import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RegisterPage(),
  ));
}

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();

  String selectedRole = ''; // "depremzede" veya "yardimsever"

  Widget roleButton(String text, String value) {
    final isSelected = selectedRole == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal[100] : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }

  Widget inputField(String label, TextEditingController controller, {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        label: Center(child: Text(label, textAlign: TextAlign.center)),
        border: OutlineInputBorder(),
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(              
              children: [
                SizedBox(height: 16),
                CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color.fromARGB(255, 161, 215, 202),
                  child: Image.asset("assets/images/logo.png", width: 30, height: 30,)
                ),
                SizedBox(height: 12),
                Text(
                  'ReliefApp',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'HESAP OLUŞTURUN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.info_outline, size: 28),
                SizedBox(height: 24),

                inputField("Ad Soyad", _nameController),
                SizedBox(height: 12),
                inputField("Kullanıcı adı", _usernameController),
                SizedBox(height: 12),
                inputField("E-Mail / Telefon Numarası", _emailController),
                SizedBox(height: 12),
                inputField("Şifre belirleyin", _passwordController, obscure: true),
                SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "*Şifreniz en az bir büyük harf ve rakam içermelidir.",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "*Şifreniz en az 8 karakterden oluşmalıdır.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                inputField("Şifrenizi doğrulayın", _confirmPasswordController, obscure: true),
                SizedBox(height: 12),
                inputField("Adres Bilgileri", _addressController),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    roleButton("Depremzede", "depremzede"),
                    roleButton("Yardımsever", "yardimsever"),
                  ],
                ),
                SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    // Kayıt işlemi
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.teal[300],
                  ),
                  child: Text('Kayıt Ol'),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // Girişe yönlendirme
                  },
                  child: Text(
                    'Zaten hesabınız var mı?',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
