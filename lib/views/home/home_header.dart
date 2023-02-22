import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';

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
        'Today'.toUpperCase(),
        style: Theme.of(context).textTheme.displayLarge,
      );

  FadeInImage get _profileImage => FadeInImage.assetNetwork(
        placeholder: Assets.images.nimbleLogo.path,
        image: profileImageUrl,
      );

  Widget _profilePictureWidget(BuildContext context) => GestureDetector(
        onTap: () {
          // TODO: - Show the side bar to log out
          // cannot pop as root is Home screen
          context.pop();
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

  @override
  Widget build(BuildContext context) {
    return Padding(
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
