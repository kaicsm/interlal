import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interlal/app/modules/profile/controllers/profile_controller.dart';
import 'package:interlal/app/routes/app_routes.dart';
import 'package:interlal/app/widgets/action_card_tile.dart';
import 'package:interlal/app/widgets/section_title.dart';
import 'package:logger/logger.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    const String userName = 'Aluno Exemplo';
    const String userClass = '3º Informática';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Configurações',
            onPressed: () {
              Get.toNamed(AppRoutes.settings);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: context.theme.colorScheme.primaryContainer,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: context.theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                userName,
                style: context.theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                userClass,
                style: context.theme.textTheme.bodyLarge?.copyWith(
                  color: context.theme.colorScheme.primary,
                ),
              ),
              // const SizedBox(height: 4.0),
              // Text(
              //   'Time: $userTeam',
              //   style: theme.textTheme.bodyMedium?.copyWith(
              //     color: theme.colorScheme.secondary,
              //   ),
              // ),
            ],
          ),

          const SizedBox(height: 16),
          SectionTitle("Informações"),

          ActionCardTile(
            icon: Icons.edit_outlined,
            title: 'Editar Informações',
            onTap: () {
              Get.snackbar('Ação', 'Abrir edição de perfil');
            },
          ),

          ActionCardTile(
            icon: Icons.shield_outlined,
            title: 'Segurança',
            onTap: () {
              Get.snackbar('Ação', 'Abrir segurança da conta');
            },
          ),

          SectionTitle("Conta"),

          ActionCardTile(
            icon: Icons.logout,
            title: 'Sair da Conta',
            iconColor: context.theme.colorScheme.error,
            textColor: context.theme.colorScheme.error,
            onTap: () => _showLogoutConfirmation(context),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirmar Saída'),
        content: const Text('Tem certeza que deseja sair da sua conta?'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text(
              'Sair',
              style: TextStyle(
                color: context.theme.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Get.back();
              // TODO: Implementar a lógica real de logout aqui
              Logger().i("Logout confirmado!");
            },
          ),
        ],
      ),
    );
  }
}
