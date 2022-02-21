import 'package:flutter/material.dart';

import '../../../core/ui/theme_extensions.dart';
import 'card_filter.dart';

class HomeFilters extends StatefulWidget {
  const HomeFilters({Key? key}) : super(key: key);

  @override
  State<HomeFilters> createState() => _HomeFiltersState();
}

class _HomeFiltersState extends State<HomeFilters> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FILTROS', style: context.titleStyle),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              CardFilter(),
              CardFilter(),
              CardFilter(),
              CardFilter(),
              CardFilter(),
            ],
          ),
        ),
      ],
    );
  }
}
