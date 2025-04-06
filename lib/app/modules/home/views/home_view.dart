import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interlal/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

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
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHighlightCard(context),

          const SizedBox(height: 24.0),

          _buildSectionTitle(context, 'Próximos Jogos'),
          const SizedBox(height: 12.0),
          _buildHorizontalGameList(context),

          const SizedBox(height: 24.0),

          _buildSectionTitle(context, 'Resultados Recentes'),
          const SizedBox(height: 12.0),
          _buildResultItem(
            context,
            'Futsal M.',
            '3º Info',
            '2',
            '3º Edif',
            '1',
          ),
          _buildResultItem(context, 'Vôlei F.', '1º Agro', '2', '1º Info', '0'),
          _buildResultItem(
            context,
            'Basquete M.',
            '2º Info',
            '35',
            '2º Edif',
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

          const SizedBox(height: 24.0),

          _buildSectionTitle(context, 'Avisos Importantes'),
          const SizedBox(height: 12.0),
          _buildNewsCard(context),

          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildHighlightCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Card(
      elevation: 3.0,
      color: colorScheme.primaryContainer.withValues(alpha: 0.8),
      // child: Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10.0),
      //     image: DecorationImage(
      //       image: AssetImage('assets/images/sports_banner.png'),
      //       fit: BoxFit.cover,
      //       colorFilter: ColorFilter.mode(
      //         Colors.black.withOpacity(0.4),
      //         BlendMode.darken,
      //       ),
      //     ),
      //   ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HOJE ÀS 15:00 - QUADRA PRINCIPAL',
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
              '3º Informática vs 3º Edificações',
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
              style: ElevatedButton.styleFrom(),
            ),
          ],
        ),
        // ),
      ),
    );
  }

  Widget _buildHorizontalGameList(BuildContext context) {
    // TODO: Substituir por dados reais
    final games = [
      {
        'sport': 'Vôlei F.',
        'teamA': '1º Info',
        'teamB': '1º Edif',
        'time': '14:00',
      },
      {
        'sport': 'Basquete M.',
        'teamA': '2º Agro',
        'teamB': '2º Info',
        'time': '16:00',
      },
      {
        'sport': 'Futsal F.',
        'teamA': '3º Edif',
        'teamB': '3º Agro',
        'time': '17:00',
      },
    ];

    return SizedBox(
      height: 130,
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    IconData sportIcon = _getSportIcon(sport);

    return Card(
      elevation: 1.5,
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
              // const SizedBox(height: 8),
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final scoreAInt = int.tryParse(scoreA) ?? 0;
    final scoreBInt = int.tryParse(scoreB) ?? 0;
    final teamAStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight:
          highlightWinner && scoreAInt > scoreBInt ? FontWeight.bold : null,
      color:
          highlightWinner && scoreAInt > scoreBInt
              ? colorScheme.onPrimaryFixedVariant
              : null,
    );
    final teamBStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight:
          highlightWinner && scoreBInt > scoreAInt ? FontWeight.bold : null,
      color:
          highlightWinner && scoreBInt > scoreAInt
              ? colorScheme.onPrimaryFixedVariant
              : null,
    );
    final scoreStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
    );

    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(teamA, style: teamAStyle, textAlign: TextAlign.start),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(scoreA, style: scoreStyle),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('-', style: theme.textTheme.bodyLarge),
                  ),
                  Text(scoreB, style: scoreStyle),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(teamB, style: teamBStyle, textAlign: TextAlign.end),
            ),
            const SizedBox(width: 10),
            Icon(_getSportIcon(sport), size: 20, color: colorScheme.secondary),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tabela de Jogos Atualizada!',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Confira os horários e locais atualizados para as quartas de final na seção "Jogos". Não perca!',
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

  IconData _getSportIcon(String sport) {
    if (sport.toLowerCase().contains('futsal')) return Icons.sports_soccer;
    if (sport.toLowerCase().contains('vôlei')) return Icons.sports_volleyball;
    if (sport.toLowerCase().contains('basquete')) {
      return Icons.sports_basketball;
    }
    if (sport.toLowerCase().contains('handebol')) return Icons.sports_handball;
    return Icons.sports;
  }
}
