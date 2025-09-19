// lib/screens/signup_screen.dart
import 'package:flutter/material.dart';
import '../widgets/forti_text_field.dart';
import '../widgets/forti_button.dart';
import '../widgets/forti_logo.dart';
import '../services/firebase_auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _pass.dispose();
    _confirm.dispose();
    super.dispose();
  }

  String? _req(String? v, String msg) => (v == null || v.isEmpty) ? msg : null;

  String? _emailValidator(String? v) {
    if (v == null || v.isEmpty) return 'Informe seu e-mail';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v);
    return ok ? null : 'E-mail inválido';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await FirebaseAuthService.signUp(
        name: _name.text.trim(),
        email: _email.text.trim(),
        password: _pass.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro criado (simulado)')),
      );
      Navigator.pop(context); // volta ao login
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const FortiLogo(size: 20)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Criar conta',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 18),

                      FortiTextField(
                        controller: _name,
                        label: 'Nome',
                        hint: 'Seu nome',
                        validator: (v) => _req(v, 'Informe seu nome'),
                      ),
                      const SizedBox(height: 12),

                      FortiTextField(
                        controller: _email,
                        label: 'E-mail',
                        keyboardType: TextInputType.emailAddress,
                        validator: _emailValidator,
                      ),
                      const SizedBox(height: 12),

                      FortiTextField(
                        controller: _pass,
                        label: 'Senha',
                        isPassword: true,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Informe uma senha';
                          if (v.length < 6) return 'Mínimo de 6 caracteres';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      FortiTextField(
                        controller: _confirm,
                        label: 'Confirmar senha',
                        isPassword: true,
                        validator: (v) => v == _pass.text ? null : 'As senhas não coincidem',
                      ),
                      const SizedBox(height: 16),

                      FortiButton(
                        label: 'Criar conta',
                        onPressed: _submit,
                        loading: _loading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
