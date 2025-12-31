import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../l10n/localizations.dart';
import '../providers/locale_provider.dart';
import 'car_list_screen.dart';

class WelcomeLoginScreen extends ConsumerStatefulWidget {
  const WelcomeLoginScreen({super.key});
  static const routeName = '/';

  @override
  ConsumerState<WelcomeLoginScreen> createState() => _WelcomeLoginScreenState();
}

class _WelcomeLoginScreenState extends ConsumerState<WelcomeLoginScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _continue() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authNameProvider.notifier).state = _nameController.text.trim();
      Navigator.pushReplacementNamed(context, CarListScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2C7BE5), Color(0xFF5AC8FA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              margin: const EdgeInsets.all(24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: size.width > 500 ? 420 : size.width - 48,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.directions_car_filled,
                        size: 64,
                        color: Color(0xFF2C7BE5),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        t.appTitle,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.tagline,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: t.yourName,
                            prefixIcon: const Icon(Icons.person),
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _continue,
                          icon: const Icon(Icons.login),
                          label: Text(t.continueLabel),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          ref.read(authNameProvider.notifier).state = 'Guest';
                          Navigator.pushReplacementNamed(
                            context,
                            CarListScreen.routeName,
                          );
                        },
                        child: Text(t.continueGuest),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.language, size: 16),
                          const SizedBox(width: 6),
                          DropdownButton<Locale>(
                            value: Localizations.localeOf(context),
                            items: const [
                              DropdownMenuItem(
                                value: Locale('en'),
                                child: Text('English'),
                              ),
                              DropdownMenuItem(
                                value: Locale('hi'),
                                child: Text('हिंदी'),
                              ),
                            ],
                            onChanged: (l) {
                              if (l != null) {
                                ref.read(localeProvider.notifier).state = l;
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
