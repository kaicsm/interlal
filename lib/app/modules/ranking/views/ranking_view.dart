import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interlal/app/modules/ranking/controllers/ranking_controller.dart';
import 'package:interlal/app/utils/icon_helper.dart';
import 'package:interlal/app/widgets/empty_state_widget.dart';

class RankingView extends GetView<RankingController> {
  const RankingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking'),
        bottom: _RankingSelectorsAppBarBottom(
          controller: controller,
          colorScheme: colorScheme,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [Expanded(child: Obx(() => _buildRankingContent(context)))],
      ),
    );
  }

  Widget _buildRankingContent(BuildContext context) {
    final String selectedRankingType = controller.selectedRanking.value;
    final bool showTeams = selectedRankingType == 'Times';
    final bool showPlayers = selectedRankingType == 'Jogadores';

    final List<Map<String, dynamic>> teams = controller.topTeams;
    final List<Map<String, dynamic>> players = controller.topPlayers;

    if (teams.isEmpty && players.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.sentiment_dissatisfied_outlined,
        message: "Nenhum ranking disponível",
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        if (showTeams)
          if (teams.isNotEmpty) ...[
            _buildRankingCard(
              items: teams,
              itemBuilder:
                  (item) => _buildTeamRankItem(
                    context,
                    item['pos'],
                    item['name'],
                    item['points'],
                  ),
            ),
          ] else
            EmptyStateWidget(
              icon: Icons.find_in_page_outlined,
              message: "Ranking de times vazio",
            ),

        if (showPlayers)
          if (players.isNotEmpty) ...[
            _buildRankingCard(
              items: players,
              itemBuilder:
                  (item) => _buildPlayerRankItem(
                    context,
                    item['pos'],
                    item['name'],
                    item['team'],
                    item['score'],
                  ),
            ),
          ] else
            EmptyStateWidget(
              icon: Icons.find_in_page_outlined,
              message: "Ranking de jogadores vazio",
            ),
      ],
    );
  }

  Widget _buildRankingCard({
    required List<Map<String, dynamic>> items,
    required Widget Function(Map<String, dynamic>) itemBuilder,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(items[index]);
      },
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildTeamRankItem(
    BuildContext context,
    int position,
    String teamName,
    int points,
  ) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 15,
          backgroundColor:
              position <= 3
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceContainerHighest,
          child: Text(
            position.toString(),
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color:
                  position <= 3
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        title: Text(teamName, style: theme.textTheme.bodyLarge),
        trailing: Text(
          '$points pts',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        dense: true,
      ),
    );
  }

  Widget _buildPlayerRankItem(
    BuildContext context,
    int position,
    String playerName,
    String teamName,
    int score,
  ) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;

    String scoreLabel = 'Gols';
    if (controller.selectedSport.value.toLowerCase().contains('basquete')) {
      scoreLabel = 'Pts';
    }
    if (controller.selectedSport.value.toLowerCase().contains('vôlei')) {
      scoreLabel = 'Pts';
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 15,
          backgroundColor:
              position <= 3
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceContainerHighest,
          child: Text(
            position.toString(),
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color:
                  position <= 3
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        title: Text(playerName, style: theme.textTheme.bodyLarge),
        subtitle: Text(
          teamName,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.outline,
          ),
        ),
        trailing: Text(
          '$score $scoreLabel',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        dense: true,
      ),
    );
  }
}

class _RankingSelectorsAppBarBottom extends StatelessWidget
    implements PreferredSizeWidget {
  final RankingController controller;
  final ColorScheme colorScheme;

  const _RankingSelectorsAppBarBottom({
    required this.controller,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSportSelector(),
        _buildRankingSelector(),
        SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildSportSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Obx(
          () => Wrap(
            spacing: 8.0,
            children:
                controller.sports.map((sport) {
                  final bool isSelected =
                      controller.selectedSport.value == sport;
                  return FilterChip(
                    label: Text(sport),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        controller.changeSport(sport);
                      }
                    },
                    avatar: Icon(
                      IconHelper.getSportIcon(sport),
                      size: 18,
                      color:
                          isSelected
                              ? colorScheme.onSecondaryContainer
                              : colorScheme.primary,
                    ),

                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildRankingSelector() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 6.0),
      child: Obx(
        () => Wrap(
          alignment: WrapAlignment.center,
          spacing: 12.0,
          children:
              controller.rankings.map((ranking) {
                final bool isSelected =
                    controller.selectedRanking.value == ranking;
                return FilterChip(
                  label: Text(ranking),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      controller.changeRanking(ranking);
                    }
                  },
                  avatar: Icon(
                    IconHelper.getRankingTypeIcon(ranking),
                    size: 18,
                    color:
                        isSelected
                            ? colorScheme.onSecondaryContainer
                            : colorScheme.primary,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                );
              }).toList(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(87.0);
  }
}
