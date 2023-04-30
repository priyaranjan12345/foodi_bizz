import 'package:fluent_ui/fluent_ui.dart';
import 'package:lottie/lottie.dart';

class OnEmptyWidget extends StatelessWidget {
  const OnEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset(
            'assets/lotties/empty.json',
            width: 200,
            height: 200,
          ),
        ),
        const Text(
          'There is no food items',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
