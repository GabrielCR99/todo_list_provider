import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/auth_provider.dart';
import '../../../core/ui/theme_extensions.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Selector<AuthProvider, String>(
        builder: (context, value, _) => Text(
          'E aí, $value!',
          style: context.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        selector: (_, authProvider) =>
            authProvider.user?.displayName ?? 'Não informado',
      ),
    );
  }
}
