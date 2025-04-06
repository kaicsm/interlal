import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interlal/app/routes/app_routes.dart';
import 'package:logger/logger.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    const String userName = 'Aluno Exemplo';
    const String userEmail = 'aluno.exemplo@escola.com';
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
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                userName,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                userClass,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                userEmail,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.secondary,
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
          const SizedBox(height: 24.0),
          const Divider(),
          const SizedBox(height: 16.0),

          _buildSectionTitle(context, "Minha Conta"),
          const SizedBox(height: 8.0),
          _buildProfileOption(
            context: context,
            icon: Icons.edit_outlined,
            title: 'Editar Informações',
            onTap: () {
              Get.snackbar('Ação', 'Abrir edição de perfil');
            },
          ),
          _buildProfileOption(
            context: context,
            icon: Icons.shield_outlined,
            title: 'Segurança',
            onTap: () {
              Get.snackbar('Ação', 'Abrir segurança da conta');
            },
          ),

          const SizedBox(height: 16.0),
          const Divider(),
          const SizedBox(height: 16.0),

          _buildProfileOption(
            context: context,
            icon: Icons.logout,
            title: 'Sair da Conta',
            iconColor: colorScheme.error,
            textColor: colorScheme.error,
            onTap: () => _showLogoutConfirmation(context, colorScheme),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    final ThemeData theme = Theme.of(context);
    final Color finalIconColor = iconColor ?? theme.colorScheme.primary;
    final Color finalTextColor = textColor ?? theme.textTheme.bodyLarge!.color!;

    return ListTile(
      leading: Icon(icon, color: finalIconColor),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(color: finalTextColor),
      ),
      trailing: Icon(
        Icons.chevron_right,
        size: 20,
        color: theme.colorScheme.outline,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      hoverColor: theme.colorScheme.primary.withValues(alpha: 0.05),
      splashColor: theme.colorScheme.primary.withValues(alpha: 0.1),
    );
  }

  void _showLogoutConfirmation(BuildContext context, ColorScheme colorScheme) {
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
                color: colorScheme.error,
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
