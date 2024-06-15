// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher_sample/bottom_sheet/action_bottom_sheet.dart';
import 'package:url_launcher_sample/flavor.dart';

Future<Flavor> showSelectFlavorBottomSheet(BuildContext context) async {
  final completer = Completer<Flavor>();

  await showActionBottomSheet(
    context,
    actions: [
      ActionItem(
        icon: Icons.drive_file_rename_outline_outlined,
        text: 'dev',
        onTap: () => completer.complete(Flavor.dev),
      ),
      ActionItem(
        icon: Icons.support_agent,
        text: 'stg',
        onTap: () => completer.complete(Flavor.stg),
      ),
      ActionItem(
        icon: Icons.production_quantity_limits,
        text: 'prod',
        onTap: () => completer.complete(Flavor.prod),
      ),
    ],
  );
  return completer.future;
}
