import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;

  final _formKey = GlobalKey<FormState>();

  // Text field controllers for the form
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  // Kaydedilmiş veriler
  String savedFirstName = 'Mary';
  String savedLastName = 'Jones';
  String savedEmail = 'maryjones@gmail.com';
  String savedAddress = '123 Main Street, Waterloo';

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  // Controller'ları sıfırlamak için
  void _initializeControllers() {
    _firstNameController = TextEditingController(text: savedFirstName);
    _lastNameController = TextEditingController(text: savedLastName);
    _emailController = TextEditingController(text: savedEmail);
    _addressController = TextEditingController(text: savedAddress);
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // Alanları kaydet
  void _saveFields() {
    savedFirstName = _firstNameController.text;
    savedLastName = _lastNameController.text;
    savedEmail = _emailController.text;
    savedAddress = _addressController.text;
  }

  // Profil bilgilerini düzenleyen form
  Widget _buildEditForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          const Text(
            'Edit Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // First Name
          TextFormField(
            controller: _firstNameController,
            decoration: const InputDecoration(
              labelText: 'First Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          // Last Name
          TextFormField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              labelText: 'Last Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          // Email
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          // Address
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 40),

          // Save and Cancel buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _saveFields();
                      _isEditing = false; // Edit modundan çık
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile Updated')),
                    );
                  }
                },
                child: const Text('Save'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isEditing = false; // Düzenlemeyi iptal et
                    _initializeControllers(); // İptal edildiğinde eski değerleri geri yükle
                  });
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Profil bilgilerini görüntüleyen yapı
  Widget _buildProfileInfo() {
    return ListView(
      children: [
        const Text(
          'Profile Information',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        _buildProfileInfoRow('First Name', savedFirstName),
        const SizedBox(height: 20),

        _buildProfileInfoRow('Last Name', savedLastName),
        const SizedBox(height: 20),

        _buildProfileInfoRow('Email', savedEmail),
        const SizedBox(height: 20),

        _buildProfileInfoRow('Address', savedAddress),
        const SizedBox(height: 40),

        // Edit Profile butonu
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isEditing = true; // Edit moduna geç
            });
          },
          child: const Text('Edit Profile'),
        ),
      ],
    );
  }

  // Bilgileri görüntüleyen satır
  Widget _buildProfileInfoRow(String title, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title:',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          info,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isEditing ? _buildEditForm() : _buildProfileInfo(),
      ),
    );
  }
}
