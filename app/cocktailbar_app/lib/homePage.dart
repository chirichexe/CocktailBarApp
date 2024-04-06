import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Benvenuto!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: const Text('Vai alla Seconda Pagina'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/third');
              },
              child: const Text('Vai alla Terza Pagina'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/fourth');
              },
              child: const Text('Vai alla Quarta Pagina'),
            ),
          ],
        ),
      ),
    );
  }
}

