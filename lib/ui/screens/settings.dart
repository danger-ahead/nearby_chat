import 'package:flutter/material.dart';
import 'package:nearby_chat/nearbychat_theme.dart';
import 'package:nearby_chat/ui/base_view.dart';
import 'package:nearby_chat/ui/components/input_field.dart';
import 'package:nearby_chat/viewmodels/settings_viewmodel.dart';
import 'package:simple_chips_input/select_chips_input.dart';

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
                    SelectChipsInput(
                      onlyOneChipSelectable: true,
                      chipsText: const [
                        'System',
                        'Light',
                        'Dark',
                      ],
                      preSelectedChips: [_model.theme ?? 0],
                      widgetContainerDecoration: const BoxDecoration(
                        color: NearbyChatTheme.secondaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                      selectedChipDecoration: const BoxDecoration(
                          color: NearbyChatTheme.primaryColorDark),
                      unselectedChipDecoration:
                          const BoxDecoration(color: NearbyChatTheme.lightGrey),
                      prefixIcons: const [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.phone_android,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.sunny,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.nightlight,
                            color: Colors.white,
                          ),
                        ),
                      ],
                      wrapCrossAlignment: WrapCrossAlignment.center,
                      wrapAlignment: WrapAlignment.center,
                      wrapRunAlignment: WrapAlignment.center,
                      onTap: (data, index) {
                        _model.setTheme(index);
                      },
                    )
                  ],
                ),
              )),
    );
  }
}
