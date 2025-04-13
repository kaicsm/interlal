import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interlal/app/core/controllers/theme_controller.dart';
import 'package:interlal/app/modules/settings/controllers/settings_controller.dart';
import 'package:interlal/app/widgets/action_card_tile.dart';
import 'package:interlal/app/widgets/section_title.dart';

class SettingsView extends GetView<SettingsController> {
  SettingsView({super.key});

  final ThemeController _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SectionTitle('Aparência'),
          Card(
            child: Obx(
              () => ListTile(
                leading: Icon(
                  _getThemeIcon(_themeController.themeMode),
                  color: context.theme.colorScheme.primary,
                ),
                title: const Text('Tema'),
                subtitle: Text(_getThemeName(_themeController.themeMode)),
                trailing: PopupMenuButton<ThemeMode>(
                  icon: const Icon(Icons.arrow_drop_down),
                  onSelected: (ThemeMode value) {
                    _themeController.setThemeMode(value);
                  },
                  itemBuilder:
                      (BuildContext context) => <PopupMenuEntry<ThemeMode>>[
                        PopupMenuItem<ThemeMode>(
                          value: ThemeMode.light,
                          child: Row(
                            children: [
                              Icon(
                                Icons.wb_sunny_outlined,
                                color: context.theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              const Text('Claro'),
                            ],
                          ),
                        ),
                        PopupMenuItem<ThemeMode>(
                          value: ThemeMode.dark,
                          child: Row(
                            children: [
                              Icon(
                                Icons.nightlight_outlined,
                                color: context.theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              const Text('Escuro'),
                            ],
                          ),
                        ),
                        PopupMenuItem<ThemeMode>(
                          value: ThemeMode.system,
                          child: Row(
                            children: [
                              Icon(
                                Icons.settings_suggest_outlined,
                                color: context.theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              const Text('Padrão do Sistema'),
                            ],
                          ),
                        ),
                      ],
                ),
              ),
            ),
          ),

          SectionTitle('Notificações'),

          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Notificações Gerais'),
                  secondary: const Icon(Icons.notifications_active_outlined),
                  value: true, // TODO: Usar um controller de configurações
                  onChanged: (bool value) {
                    // TODO: Lógica para ativar/desativar
                    Get.snackbar('Configuração', 'Notificações Gerais: $value');
                  },
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                ),
                SwitchListTile(
                  title: const Text('Jogos da minha turma'),
                  secondary: const Icon(Icons.group_outlined),
                  value: false, // TODO: Usar um controller de configurações
                  onChanged: (bool value) {
                    // TODO: Lógica para ativar/desativar
                    Get.snackbar(
                      'Configuração',
                      'Notificações da Turma: $value',
                    );
                  },
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                ),
              ],
            ),
          ),

          SectionTitle('Informações'),

          Column(
            children: [
              ActionCardTile(
                icon: Icons.info_outline,
                title: 'Sobre o Interlal',
                trailing: const Icon(Icons.chevron_right, size: 20),
                onTap: () {
                  Get.dialog(
                    AlertDialog(
                      title: const Text('Sobre o Interlal'),
                      content: const Text(
                        'Aplicativo para acompanhamento dos jogos interclasse.\nVersão 1.0.0',
                      ),
                      actions: [
                        TextButton(
                          onPressed: Get.back,
                          child: const Text('Fechar'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ActionCardTile(
                icon: Icons.help_outline,
                title: 'Ajuda e Suporte',
                trailing: const Icon(Icons.chevron_right, size: 20),
                onTap: () {
                  Get.snackbar('Ação', 'Abrir central de ajuda');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getThemeIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return Icons.wb_sunny_outlined;
      case ThemeMode.dark:
        return Icons.nightlight_outlined;
      case ThemeMode.system:
        return Icons.settings_suggest_outlined;
    }
  }

  String _getThemeName(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'Claro';
      case ThemeMode.dark:
        return 'Escuro';
      case ThemeMode.system:
        return 'Padrão do Sistema';
    }
  }
}
