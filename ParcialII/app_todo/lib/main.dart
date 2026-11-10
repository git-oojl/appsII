import 'package:flutter/material.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'To Do List',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF78A9F5)),
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
    ),
    home: const TodoPage(),
  );
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _newTaskController = TextEditingController();
  final List<String> _tasks = [
    'tarea5',
    'tarea1',
    'tarea4',
    'tarea2',
    'tarea3',
  ];

  @override
  void dispose() {
    _newTaskController.dispose();
    super.dispose();
  }

  void _addTask() {
    final task = _newTaskController.text.trim();
    if (task.isEmpty) {
      _showMessage('Escribe una tarea antes de agregarla.');
      return;
    }
    if (_isDuplicate(task)) {
      _showMessage('Esa tarea ya está en la lista.');
      return;
    }
    setState(() {
      _tasks.add(task);
      _newTaskController.clear();
    });
  }

  bool _isDuplicate(String task, {int? exceptIndex}) =>
      _tasks.asMap().entries.any(
        (entry) =>
            entry.key != exceptIndex &&
            entry.value.toLowerCase() == task.toLowerCase(),
      );

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _editTask(int index) async {
    final controller = TextEditingController(text: _tasks[index]);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar tarea'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Ingresa la tarea'),
          onSubmitted: (value) => Navigator.pop(context, value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    controller.dispose();
    final updatedTask = result?.trim();
    if (updatedTask == null || !mounted) return;
    if (updatedTask.isEmpty) {
      _showMessage('El nombre de la tarea no puede estar vacío.');
      return;
    }
    if (_isDuplicate(updatedTask, exceptIndex: index)) {
      _showMessage('Esa tarea ya está en la lista.');
      return;
    }
    setState(() => _tasks[index] = updatedTask);
  }

  void _deleteTask(int index) {
    final removedTask = _tasks[index];
    setState(() => _tasks.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"$removedTask" eliminada'),
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: () => setState(() => _tasks.insert(index, removedTask)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('To Do List'),
      centerTitle: true,
      elevation: 2,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
    ),
    body: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _newTaskController,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _addTask(),
                      decoration: const InputDecoration(
                        hintText: 'Ingresa una tarea...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: FilledButton(
                      onPressed: _addTask,
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: const Color(0xFF78A9F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Icon(Icons.add, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                itemCount: _tasks.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) => Dismissible(
                  key: ValueKey('${_tasks[index]}-$index'),
                  direction: DismissDirection.horizontal,
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      await _editTask(index);
                      return false;
                    }
                    return true;
                  },
                  onDismissed: (_) => _deleteTask(index),
                  background: const _SwipeBackground(
                    color: Color(0xFF4E8DF4),
                    icon: Icons.edit_outlined,
                    label: 'Editar',
                    alignment: Alignment.centerLeft,
                  ),
                  secondaryBackground: const _SwipeBackground(
                    color: Color(0xFFE35D5B),
                    icon: Icons.delete_outline,
                    label: 'Borrar',
                    alignment: Alignment.centerRight,
                  ),
                  child: SizedBox(
                    height: 43,
                    child: Row(
                      children: [
                        Expanded(child: Text(_tasks[index])),
                        const Icon(Icons.drag_handle, color: Color(0xFFB3B3B3)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _SwipeBackground extends StatelessWidget {
  const _SwipeBackground({
    required this.color,
    required this.icon,
    required this.label,
    required this.alignment,
  });

  final Color color;
  final IconData icon;
  final String label;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) => Container(
    alignment: alignment,
    color: color,
    padding: const EdgeInsets.symmetric(horizontal: 22),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    ),
  );
}
