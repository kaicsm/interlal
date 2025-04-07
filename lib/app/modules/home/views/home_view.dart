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
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final scoreAInt = int.tryParse(scoreA) ?? 0;
    final scoreBInt = int.tryParse(scoreB) ?? 0;
    final teamAStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight:
          highlightWinner && scoreAInt > scoreBInt ? FontWeight.bold : null,
      color:
          highlightWinner && scoreAInt > scoreBInt
              ? colorScheme.onSurfaceVariant
              : colorScheme.onSurface,
    );
    final teamBStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight:
          highlightWinner && scoreBInt > scoreAInt ? FontWeight.bold : null,
      color:
          highlightWinner && scoreBInt > scoreAInt
              ? colorScheme.onSurfaceVariant
              : colorScheme.onSurface,
    );
    final scoreStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: colorScheme.primary,
    );

    return Card(
      child: ListTile(
        leading: Icon(
          IconHelper.getSportIcon(sport),
          size: 24,
          color: colorScheme.secondary,
        ),
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
              child: Text('$scoreA - $scoreB', style: scoreStyle),
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
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
}
