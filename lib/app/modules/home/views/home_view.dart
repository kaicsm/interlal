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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('assets/images/futsal_banner.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.7),
              BlendMode.darken,
            ),
          ),
        ),
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
          // ),
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
      height: 135,
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
    IconData sportIcon = IconHelper.getSportIcon(sport);

    return Card(
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
                  Icon(sportIcon, size: 18, color: colorScheme.primary),
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
    String scoreB, {
    bool highlightWinner = true,
  }) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final scoreAInt = int.tryParse(scoreA) ?? 0;
    final scoreBInt = int.tryParse(scoreB) ?? 0;
    final teamAStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: scoreAInt > scoreBInt ? FontWeight.bold : FontWeight.normal,
      color:
          highlightWinner && scoreAInt > scoreBInt
              ? colorScheme.primary
              : colorScheme.onSurface,
    );
    final teamBStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: scoreBInt > scoreAInt ? FontWeight.bold : FontWeight.normal,
      color:
          highlightWinner && scoreBInt > scoreAInt
              ? colorScheme.primary
              : colorScheme.onSurface,
    );
    final scoreStyle = theme.textTheme.bodyLarge;

    return Card(
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                teamA,
                style: teamAStyle,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text('$scoreA - $scoreB', style: scoreStyle),
                  Text(
                    sport,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                teamB,
                style: teamBStyle,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        onTap: () {
          // TODO: Implementar tela de detalhes
          Get.snackbar('Detalhes', 'Clique para ver mais detalhes');
        },
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context) {
    final theme = context.theme;
    return Card(
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
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Publicado: 1h atrás', // TODO: Usar data real
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
