import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:MamaCare/auth/models/user_model.dart';
import 'package:MamaCare/auth/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;

  const ProfileScreen({super.key, required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController? _passwordController;
  File? _profileImage;
  bool _isLoading = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _passwordController = TextEditingController();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Anda harus login kembali.")),
      );
      return;
    }

    final response = await AuthService().updateUserProfile(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController?.text.isNotEmpty == true
          ? _passwordController!.text
          : null, // Kirim password jika diisi
      profilePicture: _profileImage,
      token: token,
    );

    setState(() {
      _isLoading = false;
    });

    if (response['status'] == 'success') {
      // Perbarui gambar profil dan tampilkan pesan berhasil
      setState(() {
        widget.user.profilePicture = response['data']['profilePicture'] ?? '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );

      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = widget.user.profilePicture.isNotEmpty
        ? NetworkImage(widget.user.profilePicture)
        : const AssetImage('assets/img/LogoMamaCare.png') as ImageProvider;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pink.shade100,
        title: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.person),
              backgroundColor: Colors.grey.shade100,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Fredoka'),
                ),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                height: 150,
                padding: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.pink.shade100,
                ),
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : profileImage,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          labelText: 'Nama',
                          labelStyle: TextStyle(
                              fontFamily: 'Fredoka',
                              color: Colors.grey.shade800)),
                      style: TextStyle(fontFamily: 'Fredoka'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontFamily: 'Fredoka',
                              color: Colors.grey.shade800)),
                      style: TextStyle(fontFamily: 'Fredoka'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Email tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          labelText:
                              'Password (kosongkan jika tidak ingin mengubah)',
                          labelStyle: TextStyle(
                              fontFamily: 'Fredoka',
                              fontSize: 14,
                              color: Colors.grey.shade800)),
                      obscureText: true, // Menyembunyikan input password
                    ),
                    const SizedBox(height: 20),
                    _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: _updateProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink.shade200,
                              foregroundColor: Colors.white,
                              textStyle: TextStyle(
                                fontFamily: 'Fredoka',
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            child: const Text('Simpan Perubahan'),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
