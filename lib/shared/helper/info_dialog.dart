import 'package:fluent_ui/fluent_ui.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({super.key, this.title = '', this.message = ''});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        Center(
          child: FilledButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
