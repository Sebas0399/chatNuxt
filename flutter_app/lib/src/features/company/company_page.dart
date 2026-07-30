import 'package:flutter/material.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Company settings migration target',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
