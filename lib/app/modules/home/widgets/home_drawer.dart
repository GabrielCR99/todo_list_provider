import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/auth_provider.dart';
import '../../../core/ui/loader.dart';
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
              builder: (_) => ScaffoldMessenger(
                child: Builder(
                  builder: (context) => Scaffold(
                    backgroundColor: Colors.transparent,
                    body: AlertDialog(
                      content: TextField(
                        onChanged: (value) => _nameVN.value = value,
                      ),
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
                          onPressed: () => _onPressedChangeName(context),
                          child: const Text('Alterar'),
                        ),
                      ],
                    ),
                  ),
                ),
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
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final nameValue = _nameVN.value;
    if (nameValue.isEmpty) {
      FocusScope.of(context).unfocus();
      // * Specific use case of ScaffoldMessenger to show SnackBar because the overlay
      // * is not the same as the Scaffold, so the SnackBar is behind the AlertDialog.
      // * To fix this, we create a new ScaffoldMessenger inside showDialog and display it.
      scaffoldMessenger.showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xffFA5456),
          elevation: 2,
          behavior: SnackBarBehavior.floating,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          content: Row(
            children: [
              const Icon(
                Icons.report,
                size: 20,
                color: Colors.black45,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Preencha um nome!',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              InkWell(
                onTap: scaffoldMessenger.hideCurrentSnackBar,
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
        ),
      );
    } else {
      Loader.show();

      await context.read<UserService>().updateDisplayName(name: nameValue);
      Loader.hide();

      navigator.pop();
    }
  }
}
