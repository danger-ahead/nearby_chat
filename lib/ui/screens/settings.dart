import 'package:flutter/material.dart';
import 'package:nearby_chat/nearbychat_theme.dart';
import 'package:nearby_chat/ui/base_view.dart';
import 'package:nearby_chat/ui/components/input_field.dart';
import 'package:nearby_chat/viewmodels/settings_viewmodel.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late SettingsViewModel _model;

  late final TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _updateUsername() async {
    final name = _usernameController.text;
    if (name.isNotEmpty) {
      _model.setUsername(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BaseView<SettingsViewModel>(
          onModelReady: (model) => {
                _model = model,
                _usernameController.text = _model.username ?? ''
              },
          builder: (context, model, child) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    const Text('Username'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: InputField(
                        textController: _usernameController,
                        actionIcon: Icons.check,
                        action: _updateUsername,
                        hintText: 'Update Username',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: Text('Theme'),
                    ),
                    Row(
                      children: [
                        ThemeSwitchButton(model: _model, theme: 'system'),
                        ThemeSwitchButton(model: _model, theme: 'dark'),
                        ThemeSwitchButton(model: _model, theme: 'light'),
                      ],
                    )
                  ],
                ),
              )),
    );
  }
}

class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({
    super.key,
    required SettingsViewModel model,
    required this.theme,
  }) : _model = model;

  final SettingsViewModel _model;
  final String theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          style: ButtonStyle(
            side: MaterialStateBorderSide.resolveWith(
              (states) => const BorderSide(
                color: NearbyChatTheme.primaryColorDark,
              ),
            ),
            backgroundColor: MaterialStateProperty.all(_model.theme == theme
                ? NearbyChatTheme.primaryColorDark
                : NearbyChatTheme.secondaryColor),
          ),
          onPressed: () => _model.setTheme(theme),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    theme.toUpperCase(),
                    textScaleFactor: 0.9,
                  ),
                  theme == 'system'
                      ? const Icon(Icons.phone_android, size: 18)
                      : theme == 'light'
                          ? const Icon(Icons.wb_sunny, size: 18)
                          : const Icon(Icons.nightlight_round, size: 18),
                ],
              )),
        ),
      ),
    );
  }
}
