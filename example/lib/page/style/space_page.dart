import 'package:easy_refresh_space/easy_refresh_space.dart';
import 'package:example/widget/skeleton_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';

class SpacePage extends StatefulWidget {
  const SpacePage({Key? key}) : super(key: key);

  @override
  State<SpacePage> createState() => _SpacePageState();
}

class _SpacePageState extends State<SpacePage> {
  int _count = 10;
  late EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyRefresh(
        controller: _controller,
        header: SpaceHeader(
          position: IndicatorPosition.locator,
        ),
        footer: SpaceFooter(
          position: IndicatorPosition.locator,
        ),
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 4));
          setState(() {
            _count = 10;
          });
          _controller.finishRefresh();
          _controller.resetFooter();
        },
        onLoad: () async {
          await Future.delayed(const Duration(seconds: 4));
          setState(() {
            _count += 5;
          });
          _controller.finishLoad(_count >= 20
              ? IndicatorResult.noMore
              : IndicatorResult.succeeded);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Star track'.tr),
              pinned: true,
            ),
            const HeaderLocator.sliver(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const SkeletonItem();
                },
                childCount: _count,
              ),
            ),
            const FooterLocator.sliver(),
          ],
        ),
      ),
    );
  }
}