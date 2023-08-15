import 'package:flutter/material.dart';


class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _currentPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Updated password: $_newPassword');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Contraseña Actual'),
                onChanged: (value) {
                  _currentPassword = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese su contraseña actual.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Contraseña Nueva'),
                onChanged: (value) {
                  _newPassword = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingrese la nueva contraseña.';
                  }else if (value.length < 7) {
                    return 'Ingresar contraseña mayor a 7 caracteres.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Confirmar contraseña nueva'),
                onChanged: (value) {
                  _confirmPassword = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, confirmar la nueva contraseña.';
                  }
                  if (value != _newPassword) {
                    return 'Contraseñas no coinciden.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                '*La contraseña debe tener al menos 7 caracteres.',
                style: TextStyle(color: Color.fromARGB(255, 26, 155, 28)),
              ),
              SizedBox(height: 50),            
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Cambiar Contraseña'),
                 style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all<Size>(const Size(250, 50)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 56, 114, 58)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
