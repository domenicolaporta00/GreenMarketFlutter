import 'package:flutter/material.dart';

class ListaSpesaCard extends StatefulWidget {
  const ListaSpesaCard({super.key});

  @override
  State<ListaSpesaCard> createState() => _ListaSpesaCardState();
}

class _ListaSpesaCardState extends State<ListaSpesaCard> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card(
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Center(
          child: Text(
            'Lista Spesa',
            style: theme.textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
