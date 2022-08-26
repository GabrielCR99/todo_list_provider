import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/auth_provider.dart';
import '../../../core/ui/loader.dart';
import '../../../core/ui/messages.dart';
import '../../../core/ui/theme_extensions.dart';
import '../../../services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});

  final _nameVN = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: context.primaryColor.withAlpha(70)),
            child: Row(
              children: [
                Selector<AuthProvider, String>(
                  selector: (_, authProvider) =>
                      authProvider.user?.photoURL ??
                      'https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png',
                  builder: (_, value, __) => CircleAvatar(
                    backgroundImage: NetworkImage(value),
                    radius: 30,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Selector<AuthProvider, String>(
                      selector: (_, authProvider) =>
                          authProvider.user?.displayName ?? 'Não informado',
                      builder: (_, value, __) => Text(value),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Alterar nome'),
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: TextField(onChanged: (value) => _nameVN.value = value),
                title: const Text('Alterar nome'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () async => _onPressedChangeName(context),
                    child: const Text('Alterar'),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Sair'),
            onTap: () => context.read<AuthProvider>().logout(),
          ),
        ],
      ),
    );
  }

  Future<void> _onPressedChangeName(BuildContext context) async {
    final navigator = Navigator.of(context);

    final nameValue = _nameVN.value;
    if (nameValue.isEmpty) {
      Messages.showError(message: 'Preencha um nome!');
    } else {
      Loader.show();

      await context.read<UserService>().updateDisplayName(name: nameValue);
      Loader.hide();

      navigator.pop();
    }
  }
}
