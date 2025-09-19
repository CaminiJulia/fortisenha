import 'package:flutter/material.dart';
import '../widgets/forti_logo.dart';
import '../services/firebase_auth_service.dart';
import '../services/vault_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _addDialog(BuildContext context) async {
    final title = TextEditingController();
    final username = TextEditingController();
    final url = TextEditingController();
    final note = TextEditingController();
    final secret = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Novo item do cofre'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: title, decoration: const InputDecoration(labelText: 'Título')),
              TextField(controller: username, decoration: const InputDecoration(labelText: 'Usuário')),
              TextField(controller: url, decoration: const InputDecoration(labelText: 'URL')),
              TextField(controller: note, decoration: const InputDecoration(labelText: 'Nota')),
              TextField(controller: secret, decoration: const InputDecoration(labelText: 'Senha/segredo')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () async {
              await VaultService.addItem(
                title: title.text,
                username: username.text,
                url: url.text,
                note: note.text,
                secretPlaintext: secret.text, // TESTE (sem criptografia)
              );
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FortiLogo(size: 20),
        actions: [
          IconButton(
            tooltip: 'Sair',
            onPressed: () async {
              await FirebaseAuthService.signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: VaultService.watchItems(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snap.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('Seu cofre está vazio. Toque no + para adicionar.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final it = items[i];
              return ListTile(
                tileColor: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                title: Text(it['title'] ?? ''),
                subtitle: Text(it['username'] ?? ''),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: () => VaultService.deleteItem(it['id'] as String),
                ),
                onTap: () {
                  // aqui você pode abrir uma tela de detalhes/editar
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addDialog(context),
        label: const Text('Adicionar'),
        icon: const Icon(Icons.add_rounded),
      ),
    );
  }
}
