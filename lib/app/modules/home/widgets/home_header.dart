import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/app_auth_provider.dart';
import '../../../core/ui/theme_extensions.dart';

final class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Selector<AppAuthProvider, String>(
        builder: (_, userName, __) => Text(
          'E aí, $userName!',
          style: context.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        selector: (_, authProvider) =>
            authProvider.user?.displayName ?? 'Não informado',
      ),
    );
  }
}
