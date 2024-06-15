import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_sample/flavor.dart';
import 'package:url_launcher_sample/logger.dart';
import 'package:url_launcher_sample/bottom_sheet/select_flavor_bottom_sheet.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Screen());
  }
}

class Screen extends HookWidget {
  const Screen({super.key});

  Future<void> openBrowser(ExternalLinks link) async {
    final url = Uri.parse(link.url);
    logger.d(FlavorConfig.appFlavor);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: link.mode);
      } else {
        logger.d('canLaunchUrlがfalseです');
      }
    } catch (e) {
      logger.e('エラーです', error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentFlavorName = useState(FlavorConfig.name);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '現在のFlavor：${currentFlavorName.value}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap(50),
            ElevatedButton(
              child: const Text('Qiitaを開く'),
              onPressed: () async {
                await openBrowser(ExternalLinks.qiita);
              },
            ),
            const Gap(20),
            ElevatedButton(
              child: const Text('Zennを開く'),
              onPressed: () async {
                await openBrowser(ExternalLinks.zenn);
              },
            ),
            const Gap(20),
            ElevatedButton(
              child: const Text('changeLinkを開く'),
              onPressed: () async {
                await openBrowser(ExternalLinks.changeLink);
              },
            ),
            const Gap(40),
            ElevatedButton(
              child: const Text('Change Flavor'),
              onPressed: () async {
                final result = await showSelectFlavorBottomSheet(context);
                logger.d(result);
                FlavorConfig.appFlavor = result;
                currentFlavorName.value = result.name;
              },
            )
          ],
        ),
      ),
    );
  }
}

enum ExternalLinks {
  qiita._(LaunchMode.externalApplication),
  zenn._(LaunchMode.inAppBrowserView),
  changeLink._(LaunchMode.inAppWebView);

  const ExternalLinks._(this.mode);
  final LaunchMode mode;
}

// enumのフィールドはコンスタントな値（変更不可能な値）のみを持つことができる。
// 動的な値を持たせたい場合は、extensionを使ってメソッドを追加する。
extension ExternalLinksExtension on ExternalLinks {
  String get url {
    switch (this) {
      case ExternalLinks.qiita:
        return 'https://qiita.com/';
      case ExternalLinks.zenn:
        return 'https://zenn.dev/';
      case ExternalLinks.changeLink:
        return _getTermsOfServiceUrl();
    }
  }

  String _getTermsOfServiceUrl() {
    switch (FlavorConfig.appFlavor) {
      case Flavor.dev:
        return 'https://www.apple.com/jp/';
      case Flavor.stg:
        return 'https://developer.android.com/?hl=ja';
      case Flavor.prod:
        return 'https://www.microsoft.com/ja-jp/';
    }
  }
}
