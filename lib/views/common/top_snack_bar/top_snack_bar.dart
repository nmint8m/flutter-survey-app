import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';

class TopSnackbar extends StatelessWidget {
  final String title;
  final String message;

  const TopSnackbar({
    super.key,
    required this.title,
    required this.message,
  });

  Widget get _bellImage => SizedBox(
        width: 23,
        height: 23,
        child: Image(
          image: Assets.images.icBell.image().image,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      color: Colors.black87,
      child: SafeArea(
        top: true,
        left: true,
        right: true,
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bellImage,
            const SizedBox(width: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width - 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
