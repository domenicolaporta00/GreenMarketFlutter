import 'package:flutter/material.dart';

class ProfiloCard extends StatefulWidget {
  const ProfiloCard({super.key});

  @override
  State<ProfiloCard> createState() => _ProfiloCardState();
}

class _ProfiloCardState extends State<ProfiloCard> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Center(
          child: Text(
            'Profilo',
            style: theme.textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
