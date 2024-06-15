// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_sample/bottom_sheet/select_flavor_bottom_sheet.dart';
import 'package:url_launcher_sample/external_links.dart';
import 'package:url_launcher_sample/flavor.dart';
import 'package:url_launcher_sample/logger.dart';

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

  /// 引数のリンクによって開くWebサイト、ブラウザのモードを切り替える
  /// ただ、切り替えるのはあくまでExternalLinksで切り替えるようにし
  /// このメソッド内では指定されたものを使うだけにする
  Future<void> openBrowser(ExternalLinks link) async {
    final url = Uri.parse(link.url);
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
              onPressed: () => openBrowser(ExternalLinks.qiita),
            ),
            const Gap(20),
            ElevatedButton(
              child: const Text('Zennを開く'),
              onPressed: () => openBrowser(ExternalLinks.zenn),
            ),
            const Gap(20),
            ElevatedButton(
              child: const Text('changeLinkを開く'),
              onPressed: () => openBrowser(ExternalLinks.changeLink),
            ),
            const Gap(40),
            ElevatedButton(
              child: const Text('Change Flavor'),
              onPressed: () async {
                final result = await showSelectFlavorBottomSheet(context);
                FlavorConfig.appFlavor = result;
                currentFlavorName.value = result.name;
              },
            ),
          ],
        ),
      ),
    );
  }
}
