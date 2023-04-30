import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:window_manager/window_manager.dart';

import '../../bill_page/view/bill_page.dart';
import '../../history_page/view/history_page.dart';
import '../../item_page/view/item_page.dart';

class IndexNotifier extends ValueNotifier<int> {
  IndexNotifier(super.value);

  changePageIndex(int pageIndex) {
    value = pageIndex;
  }
}

// class TimeNotifier extends ValueNotifier<int> {
//   TimeNotifier(super.value);

//   changePageIndex(int pageIndex) {
//     value = DateFormat.jm().format(DateFormat("hh:mm:ss").parse("14:15:00"));
//   }
// }

final streamProvider = StreamProvider.autoDispose<String>(
  ((ref) => Stream.periodic(
        const Duration(milliseconds: 400),
        (counter) => DateFormat("h:mm:s a").format(DateTime.now()),
      )),
);

final indexNotifier = IndexNotifier(0);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ValueListenableBuilder(
      valueListenable: indexNotifier,
      builder: (context, int index, __) {
        return NavigationView(
          appBar: NavigationAppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.white,
            title: () {
              return DragToMoveArea(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Center(
                    child: Consumer(builder: (context, ref, _) {
                      final streamData = ref.watch(streamProvider);
                      return streamData.when(
                        data: (String data) => Text(
                          data,
                          style: FluentTheme.of(context)
                              .typography
                              .title!
                              .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        error: (Object error, StackTrace? stackTrace) =>
                            const Text('Error data'),
                        loading: () => const Center(
                          child: Text('data'),
                        ),
                      );
                    }),
                  ),
                ),
              );
            }(),
            actions: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ToggleSwitch(
                    content: const Text('Dark Mode'),
                    checked: FluentTheme.of(context).brightness.isDark,
                    onChanged: (v) {
                      if (v) {
                        // appTheme.mode = ThemeMode.dark;
                      } else {
                        // appTheme.mode = ThemeMode.light;
                      }
                    },
                  ),
                  const WindowButtons(),
                ],
              ),
            ),
          ),
          pane: NavigationPane(
            header: Container(
              height: kOneLineTileHeight,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DefaultTextStyle(
                style: FluentTheme.of(context).typography.title!,
                child: const Center(child: Text('Foodi Bizz')),
              ),
            ),
            items: [
              PaneItem(
                icon: const Icon(FluentIcons.bill),
                title: const Text('Bill Board'),
              ),
              PaneItem(
                icon: const Icon(FluentIcons.list),
                title: const Text('Item Section'),
              ),
              PaneItem(
                icon: const Icon(FluentIcons.history),
                title: const Text('History'),
              ),
            ],
            footerItems: [
              PaneItem(
                icon: const Icon(FluentIcons.settings),
                title: const Text('Setting'),
              ),
              PaneItem(
                icon: const Icon(FluentIcons.user_window),
                title: const Text('Profile'),
              ),
            ],
            selected: index,
            displayMode:
                width < 1660 ? PaneDisplayMode.compact : PaneDisplayMode.open,
            onChanged: (i) {
              indexNotifier.changePageIndex(i);
            },
            autoSuggestBox: const TextBox(),
          ),
          content: NavigationBody(
            index: index,
            children: const [
              BillPage(),
              ItemPage(),
              HistoryPage(),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('FOODI-BIZZ'),
            content: const Text('Are you sure you want to exit?'),
            actions: [
              FilledButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
    super.onWindowClose();
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
