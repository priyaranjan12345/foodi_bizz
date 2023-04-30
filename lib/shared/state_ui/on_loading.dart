import 'package:fluent_ui/fluent_ui.dart';
import 'package:lottie/lottie.dart';

class OnLoadingWidget extends StatelessWidget {
  const OnLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lotties/loading.json',
            width: 200,
            height: 200,
          ),
          const Text('Loading Please Wait ...', style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),),
        ],
      ),
    );
  }
}
