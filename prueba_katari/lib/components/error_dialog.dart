import 'package:material_ui/material_ui.dart';

/// Popup reutilizable para mostrar mensajes de error.
///
/// Uso:
/// ```dart
/// await ErrorDialog.show(context, message: 'Algo salió mal');
/// ```
class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.message,
    this.title = 'Error',
    this.buttonText = 'Aceptar',
  });

  final String title;
  final String message;
  final String buttonText;

  static Future<void> show(
    BuildContext context, {
    required String message,
    String title = 'Error',
    String buttonText = 'Aceptar',
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => ErrorDialog(
        title: title,
        message: message,
        buttonText: buttonText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AlertDialog(
      icon: Icon(Icons.error_outline, color: colors.error, size: 48),
      title: Text(title, textAlign: TextAlign.center),
      content: Text(message, textAlign: TextAlign.center),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(buttonText),
        ),
      ],
    );
  }
}