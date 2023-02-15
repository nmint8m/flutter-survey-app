import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';
import 'package:kayla_flutter_ic/views/home/home_header.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  // TODO: - Network image
  Image get _backgroundImage => Image(
        image: Assets.images.nimbleBackground.image().image,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _backgroundImage.image,
              fit: BoxFit.cover,
            ),
          ),
          child: const SafeArea(child: HomeHeader()),
        ),
      ),
      onWillPop: () async => false,
    );
  }
}