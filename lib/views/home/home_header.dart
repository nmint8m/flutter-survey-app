import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';
import 'package:kayla_flutter_ic/utils/route_paths.dart';
import 'package:kayla_flutter_ic/views/home/home_view.dart';

class HomeHeader extends StatelessWidget {
  final String profileImageUrl;

  const HomeHeader({
    super.key,
    required this.profileImageUrl,
  });

  String get _dateText {
    final today = DateTime.now();
    return '${DateFormat.EEEE().format(today)}, ${DateFormat.MMMMd().format(today)}';
  }

  Widget _dateWidget(BuildContext context) => Text(
        _dateText.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium,
      );

  Widget _todayWidget(BuildContext context) => Text(
        AppLocalizations.of(context).homeToday.toUpperCase(),
        style: Theme.of(context).textTheme.displayLarge,
      );

  FadeInImage get _profileImage => FadeInImage.assetNetwork(
        placeholder: Assets.images.nimbleLogo.path,
        image: profileImageUrl,
      );

  Widget _profilePictureWidget(BuildContext context) => Consumer(
        builder: (_, ref, __) {
          return GestureDetector(
            onTap: () {
              ref.read(homeViewModelProvider.notifier).logOut();
              context.goNamed(RoutePath.login.name);
            },
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: _profileImage.image,
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _dateWidget(context),
              const SizedBox(height: 4),
              _todayWidget(context),
            ],
          ),
          _profilePictureWidget(context),
        ],
      ),
    );
  }
}
