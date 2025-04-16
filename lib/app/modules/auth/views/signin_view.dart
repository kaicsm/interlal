import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interlal/app/modules/auth/controllers/auth_controller.dart';
import 'package:interlal/app/routes/app_routes.dart';

class SigninView extends GetView<AuthController> {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(title: const Text('Entrar')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 32.0,
            ),
            child: Form(
              key: controller.signinFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Icon(
                      Icons.sports_soccer,
                      size: 60,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bem-vindo ao Interlal',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  TextFormField(
                    controller: controller.emailController,
                    validator: controller.validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'seuemail@exemplo.com',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Obx(
                    () => TextFormField(
                      controller: controller.passwordController,
                      validator: controller.validatePassword,
                      obscureText: controller.isPasswordObscured.value,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: theme.colorScheme.primary,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordObscured.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: theme.colorScheme.secondary,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                      onFieldSubmitted: (_) {
                        if (!controller.isLoading.value) {
                          FocusScope.of(context).unfocus();
                          controller.signIn();
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(0, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () => _showPasswordResetDialog(context),
                      child: Text(
                        'Esqueceu sua senha?',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Obx(() {
                    if (controller.errorMessage.value != null) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          controller.errorMessage.value!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  const SizedBox(height: 8.0),
                  Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed:
                          controller.isLoading.value
                              ? null
                              : () {
                                FocusScope.of(context).unfocus();
                                controller.signIn();
                              },
                      child:
                          controller.isLoading.value
                              ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.colorScheme.onPrimary,
                                  ),
                                ),
                              )
                              : const Text('ENTRAR'),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  TextButton(
                    onPressed:
                        controller.isLoading.value
                            ? null
                            : () {
                              controller.clearFormFieldsAndError();
                              Get.toNamed(AppRoutes.signup);
                            },
                    child: const Text('Não tem uma conta? Cadastre-se'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showPasswordResetDialog(BuildContext context) {
    final theme = context.theme;
    controller.resetEmailController.text = controller.emailController.text;

    Get.dialog(
      AlertDialog(
        title: const Text('Redefinir Senha'),
        content: Form(
          key: controller.resetPasswordFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Digite seu email para enviarmos um link de redefinição.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: controller.resetEmailController,
                validator: controller.validateEmail,
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'seuemail@exemplo.com',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Get.back(),
          ),
          Obx(
            () => ElevatedButton(
              onPressed:
                  controller.isLoading.value
                      ? null
                      : controller.sendPasswordReset,
              child:
                  controller.isLoading.value
                      ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : const Text('Enviar Email'),
            ),
          ),
        ],
      ),
      barrierDismissible: !controller.isLoading.value,
    );
  }
}
