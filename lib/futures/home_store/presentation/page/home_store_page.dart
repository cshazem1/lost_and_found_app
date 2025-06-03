import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../widgets/home_store_body.dart';

class HomeStorePage extends StatelessWidget {
  const HomeStorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(S.current.store),
      ),
      body: const HomeStoreBody(),
    );
  }
}
