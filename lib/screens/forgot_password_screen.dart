// lib/screens/forgot_password_screen.dart
import 'package:flutter/material.dart';
import '../widgets/forti_text_field.dart';
import '../widgets/forti_button.dart';
import '../widgets/forti_logo.dart';
import '../services/firebase_auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  String? _emailValidator(String? v) {
    if (v == null || v.isEmpty) return 'Informe seu e-mail';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v);
    return ok ? null : 'E-mail inválido';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await FirebaseAuthService.resetPassword(email: _email.text.trim());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Se existir, um link de redefinição foi enviado ao seu e-mail.'),
        ),
      );
      Navigator.pop(context); // volta para o login
    } catch (e) {
      if (!mounted) return;
      // Mostra a mensagem de erro vinda do Firebase (ex.: auth/invalid-email)
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
            constraints: const BoxConstraints(maxWidth: 480),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Recuperar senha',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Informe seu e-mail para receber o link de redefinição.',
                      ),
                      const SizedBox(height: 14),
                      FortiTextField(
                        controller: _email,
                        label: 'E-mail',
                        keyboardType: TextInputType.emailAddress,
                        validator: _emailValidator,
                      ),
                      const SizedBox(height: 16),
                      FortiButton(
                        label: 'Enviar link',
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
