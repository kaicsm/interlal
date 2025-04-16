import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interlal/app/modules/home/controllers/home_controller.dart';
import 'package:interlal/app/utils/icon_helper.dart';
import 'package:interlal/app/widgets/section_title.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interlal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            tooltip: 'Notificações',
            onPressed: () {
              Get.snackbar('Notificações', 'Nenhuma notificação nova.');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHighlightCard(context),

          SectionTitle('Próximos Jogos'),

          _buildHorizontalGameList(context),

          SectionTitle('Resultados Recentes'),

          _buildResultItem(
            context,
            'Futsal M.',
            '3º LOG A',
            '2',
            '3º LOG B',
            '1',
          ),
          _buildResultItem(
            context,
            'Vôlei F.',
            '1º LOG A',
            '2',
            '1º TDS A',
            '0',
          ),
          _buildResultItem(
            context,
            'Basquete M.',
            '2º TDS A',
            '35',
            '2º LOG B',
            '42',
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextButton(
                onPressed: () {
                  // TODO: Navegar para a tela de resultados completos
                  Get.snackbar('Ação', 'Ver todos os resultados');
                },
                child: const Text('Ver Todos os Resultados'),
              ),
            ),
          ),

          SectionTitle('Avisos Importantes'),

          _buildNewsCard(context),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildHighlightCard(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HOJE ÀS 15:00 - QUADRA',
              style: theme.textTheme.labelMedium?.copyWith(
                color: colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Final Futsal Masculino',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '3º TDS A vs 3º LOG A',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onPrimaryContainer.withValues(alpha: 0.9),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: () {
                Get.snackbar('Ação', 'Ver detalhes do jogo');
              },
              icon: const Icon(Icons.info_outline, size: 18),
              label: const Text('Mais Detalhes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalGameList(BuildContext context) {
    // TODO: Substituir por dados reais
    final games = [
      {
        'sport': 'Vôlei F.',
        'teamA': '1º LOG A',
        'teamB': '1º TDS A',
        'time': '14:00',
      },
      {
        'sport': 'Basquete M.',
        'teamA': '2º LOG B',
        'teamB': '2º TDS B',
        'time': '16:00',
      },
      {
        'sport': 'Futsal F.',
        'teamA': '3º LOG A',
        'teamB': '3º LOG B',
        'time': '17:00',
      },
    ];

    return SizedBox(
      height: 145,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: games.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12.0),
        itemBuilder: (context, index) {
          final game = games[index];
          return _buildGameCard(
            context: context,
            sport: game['sport']!,
            teamA: game['teamA']!,
            teamB: game['teamB']!,
            time: game['time']!,
          );
        },
      ),
    );
  }

  Widget _buildGameCard({
    required BuildContext context,
    required String sport,
    required String teamA,
    required String teamB,
    required String time,
  }) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          Get.snackbar('Jogo', '$sport: $teamA vs $teamB');
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      IconHelper.getSportIcon(sport),
                      size: 16,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      sport,
                      style: theme.textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                teamA,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'vs',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.outline,
                ),
              ),
              Text(
                teamB,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              // const SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  time,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultItem(
    BuildContext context,
    String sport,
    String teamA,
    String scoreA,
    String teamB,
    String scoreB,
  ) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final int scoreAInt = int.tryParse(scoreA) ?? 0;
    final int scoreBInt = int.tryParse(scoreB) ?? 0;
    final bool isTeamAWinner = scoreAInt > scoreBInt;
    final bool isTeamBWinner = scoreBInt > scoreAInt;
    final bool isDraw = scoreAInt == scoreBInt;

    return Card(
      elevation: 1,
      child: InkWell(
        onTap: () {
          Get.snackbar('Detalhes', 'Clique para ver mais detalhes');
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      IconHelper.getSportIcon(sport),
                      size: 16,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    sport,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      teamA,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight:
                            isTeamAWinner ? FontWeight.bold : FontWeight.normal,
                        color: isTeamAWinner ? colorScheme.primary : null,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isDraw
                              ? colorScheme.surfaceContainerHighest
                              : (isTeamAWinner || isTeamBWinner)
                              ? colorScheme.primaryContainer
                              : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$scoreA - $scoreB',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            isDraw
                                ? colorScheme.onSurfaceVariant
                                : (isTeamAWinner || isTeamBWinner)
                                ? colorScheme.onPrimaryContainer
                                : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      teamB,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight:
                            isTeamBWinner ? FontWeight.bold : FontWeight.normal,
                        color: isTeamBWinner ? colorScheme.primary : null,
                      ),
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 1,
      child: InkWell(
        onTap: () {
          Get.snackbar('Aviso', 'Ver detalhes do aviso');
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Goleada do artilheiro do 2º TDS A',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Guilherme do 2º TDS A marca no futsal 3 gols contra o 1º LOG B!',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: colorScheme.outline,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Publicado: 1h atrás',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Get.snackbar('Ação', 'Ver mais notícias');
                    },
                    child: const Text('Ver Mais'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
