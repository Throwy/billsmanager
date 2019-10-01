import 'package:billsmanager/store/AppState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_alert/flutter_alert_material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class ThemeSettingsPage extends StatelessWidget {
  final TextStyle _headerStyle = new TextStyle().copyWith(fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme"),
      ),
      body: ScopedModelDescendant<AppState>(
        builder: (context, child, model) {
          return ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "Dark Mode",
                      style: _headerStyle,
                    ),
                    subtitle: Text("Set the brightness of the app."),
                    trailing: Switch(
                      activeColor: model.themeState.accentColor,
                      value: model.themeState.brightness == Brightness.dark
                          ? true
                          : false,
                      onChanged: (val) {
                        if (val) {
                          model.themeState.changeBrightness(Brightness.dark);
                        } else {
                          model.themeState.changeBrightness(Brightness.light);
                        }
                      },
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      "Primary Color",
                      style: _headerStyle,
                    ),
                    subtitle: Text("Set the primary color of the app."),
                    trailing: CircleColor(
                      color: model.themeState.primaryColor,
                      circleSize: 50.0,
                      onColorChoose: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Primary Color"),
                              content: MaterialColorPicker(
                                selectedColor: model.themeState.primaryColor,
                                shrinkWrap: true,
                                allowShades: false,
                                onMainColorChange: (swatch) {
                                  model.themeState.changePrimaryColor(swatch);
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      "Accent Color",
                      style: _headerStyle,
                    ),
                    subtitle: Text("Set the accent color of the app."),
                    trailing: CircleColor(
                      color: model.themeState.accentColor,
                      circleSize: 50.0,
                      onColorChoose: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Accent Color"),
                                content: MaterialColorPicker(
                                  selectedColor: model.themeState.accentColor,
                                  shrinkWrap: true,
                                  onlyShadeSelection: true,
                                  allowShades: true,
                                  onColorChange: (color) {
                                    model.themeState.changeAccentColor(color);
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  Divider(),
                  InkWell(
                    child: ListTile(
                      title: Text(
                        "Reset",
                        style: _headerStyle,
                      ),
                      subtitle:
                          Text("Reset app theme settings to their defaults."),
                    ),
                    onTap: () {
                      showMaterialAlert(
                        context: context,
                        barrierDismissible: true,
                        title: "Reset app to default theme?",
                        actions: [
                          AlertAction(
                            text: "CANCEL",
                            automaticallyPopNavigation: true,
                            onPressed: () {},
                          ),
                          AlertAction(
                            text: "RESET",
                            automaticallyPopNavigation: true,
                            onPressed: () {
                              model.themeState.resetToDefault();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  Divider(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
