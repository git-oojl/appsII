import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _clickCounter = 0;

  void _incrementCounter() {
    setState(() {
      _clickCounter++;
    });
  }

  void _decrementCounter() {
    if (_clickCounter == 0) return;

    setState(() {
      _clickCounter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _clickCounter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final clickLabel = _clickCounter == 1 ? 'Click' : 'Clicks';

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Pantalla del contador')),
        actions: [
          IconButton(
            tooltip: 'Reiniciar contador',
            onPressed: _resetCounter,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_clickCounter',
              key: const ValueKey('valor-contador'),
              style: const TextStyle(
                fontSize: 160,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(clickLabel, style: const TextStyle(fontSize: 25)),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'decrementar',
            tooltip: 'Decrementar',
            shape: const StadiumBorder(),
            onPressed: _clickCounter > 0 ? _decrementCounter : null,
            child: const Icon(Icons.exposure_minus_1),
          ),
          const SizedBox(height: 15),
          FloatingActionButton(
            heroTag: 'incrementar',
            tooltip: 'Incrementar',
            shape: const StadiumBorder(),
            onPressed: _incrementCounter,
            child: const Icon(Icons.plus_one),
          ),
        ],
      ),
    );
  }
}
