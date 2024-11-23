import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umpdsesi2/presentation/utils/Translation.dart';
import '../../entities/cat_data.dart';
import '../../gen/assets.gen.dart';
import 'home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'home_viewmodel.dart';

class HomeScreen extends GetView<HomeViewModel> {
  const HomeScreen({super.key});

  // Change this value to `true` for SliverList or `false` for LazyList
  static const bool useSliverList = true;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: useSliverList
          ? null // No app bar when using SliverList
          : AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(Translation.titleKey.tr),
      ),
      body: useSliverList
          ? _buildSliverList(context)
          : _buildLazyList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.fetchCatFacts, // Fetch new cat facts
        tooltip: 'Fetch Cat Facts',
        child: const Icon(Icons.refresh),
      ),
    ));
  }

  Widget _buildSliverList(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Assets.lib.assets.kitty.image(fit: BoxFit.cover),
            title: Text(Translation.titleKey.tr),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final catFact = controller.state.catFacts[index];
              return _buildCatFactTile(catFact, index);
            },
            childCount: controller.state.catFacts.length,
          ),
        ),
      ],
    );
  }

  Widget _buildLazyList(BuildContext context) {
    return ListView.builder(
      itemCount: controller.state.catFacts.length,
      itemBuilder: (context, index) {
        final catFact = controller.state.catFacts[index];
        return _buildCatFactTile(catFact, index);
      },
    );
  }

  Widget _buildCatFactTile(CatData catFact, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(catFact.imageUrl.toString()),
          backgroundColor: Colors.grey[200],
        ),
        title: Text(catFact.data.first), // Display the cat fact
        subtitle: Text(Translation.subtitleKey.tr),
        trailing: const Icon(Icons.pets),
      ),
    );
  }
}