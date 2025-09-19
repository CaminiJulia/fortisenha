import 'package:flutter/material.dart';
import '../widgets/forti_logo.dart';
import '../widgets/forti_text_field.dart';
import '../widgets/forti_button.dart';
import '../services/firebase_auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  String? _emailValidator(String? v) {
    if (v == null || v.isEmpty) return 'Informe seu e-mail';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v);
    return ok ? null : 'E-mail inválido';
  }

  String? _passValidator(String? v) {
    if (v == null || v.isEmpty) return 'Informe sua senha';
    if (v.length < 6) return 'Mínimo de 6 caracteres';
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await FirebaseAuthService.signIn(
        email: _email.text.trim(),
        password: _password.text,
      );
      if (!mounted) return;

      // (opcional) Criar item de teste no Firestore
      // await VaultService.addItem(
      //   title: 'Netflix',
      //   username: 'julia',
      //   url: 'https://netflix.com',
      //   note: 'Plano padrão',
      //   secretPlaintext: 'senha123',
      // );

      // 🚀 Navegar para a Home
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 8),
                        const Center(child: FortiLogo(size: 26)),
                        const SizedBox(height: 18),
                        const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 18),
                        FortiTextField(
                          controller: _email,
                          label: 'E-mail',
                          hint: 'voce@exemplo.com',
                          keyboardType: TextInputType.emailAddress,
                          validator: _emailValidator,
                        ),
                        const SizedBox(height: 12),
                        FortiTextField(
                          controller: _password,
                          label: 'Senha',
                          isPassword: true,
                          validator: _passValidator,
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/forgot'),
                            child: const Text('Esqueceu a senha?'),
                          ),
                        ),
                        const SizedBox(height: 6),
                        FortiButton(
                          label: 'Entrar',
                          onPressed: _submit,
                          loading: _loading,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Não tem conta? '),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/signup'),
                              child: const Text('Criar conta'),
                            ),
                          ],
                        ),
                      ],
                    ),
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
