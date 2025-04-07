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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildThemeRadioTile(
                      ThemeMode.light,
                      'Claro',
                      Icons.wb_sunny_outlined,
                    ),
                    _buildThemeRadioTile(
                      ThemeMode.dark,
                      'Escuro',
                      Icons.nightlight_outlined,
                    ),
                    _buildThemeRadioTile(
                      ThemeMode.system,
                      'Padrão do Sistema',
                      Icons.settings_suggest_outlined,
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
                  // TODO: Mostrar um AboutDialog ou navegar para tela de sobre
                  Get.dialog(
                    AlertDialog(
                      title: const Text('Sobre o Interlal'),
                      content: const Text(
                        'Aplicativo para acompanhamento dos jogos interclasse.\nVersão 1.0.0',
                      ), // Exemplo
                      actions: [
                        TextButton(
                          onPressed: Get.back,
                          child: const Text('Fechar'),
                        ),
                      ],
                    ),
                  );
                },
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
              ),
              ActionCardTile(
                icon: Icons.help_outline,
                title: 'Ajuda e Suporte',
                trailing: const Icon(Icons.chevron_right, size: 20),
                onTap: () {
                  // TODO: Navegar para tela de ajuda ou abrir link
                  Get.snackbar('Ação', 'Abrir central de ajuda');
                },
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeRadioTile(ThemeMode value, String title, IconData icon) {
    return RadioListTile<ThemeMode>(
      title: Text(title),
      secondary: Icon(icon, color: Get.theme.colorScheme.primary),
      value: value,
      groupValue: _themeController.themeMode,
      onChanged: (ThemeMode? newValue) {
        if (newValue != null) {
          _themeController.setThemeMode(newValue);
        }
      },
      activeColor: Get.theme.colorScheme.primary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
    );
  }
}
