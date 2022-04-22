import 'package:flutter/material.dart';
import 'package:mobileapp/Screens/main_screen.dart';
import 'package:mobileapp/Variables/change_theme_button.dart';
// import 'package:mobileapp/Variables/custom_theme.dart';
// import 'package:provider/provider.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:mobileapp/Screens/DiscoveryPage.dart';

import 'dart:async';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  // const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  // String _address = "...";
  // String _name = "...";

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      // if (await FlutterBluetoothSerial.instance.isEnabled) {
      //   return false;
      // }
      await Future.delayed(const Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          // _address = address.toString();
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        // _name = name.toString();
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Monitoring BMS Bluetooth',
          style: TextStyle(
            fontSize:20,
          ),),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Mode Gelap',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    )),
                ChangeThemeButtonWidget(),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Divider(),
          // ListTile(title: const Text('General')),
          SwitchListTile(
            title: const Text('Nyalakan Bluetooth'),
            value: _bluetoothState.isEnabled,
            onChanged: (bool value) {
              // Do the request and update with the true value then
              future() async {
                // async lambda seems to not working
                if (value) {
                  await FlutterBluetoothSerial.instance.requestEnable();
                } else {
                  await FlutterBluetoothSerial.instance.requestDisable();
                }
              }

              future().then((_) {
                setState(() {});
              });
            },
          ),
          const SizedBox(height: 24),
          ListTile(
            title: ElevatedButton(
                child:
                const Text('Koneksi dengan ESP32'),
                onPressed: () async {
                  final BluetoothDevice selectedDevice =
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const DiscoveryPage();
                      },
                    ),
                  );

                  _startBMS(context, selectedDevice);
                }),
          ),
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 16, 5),
            child: Text('Oleh:'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 5, 16, 5),
            child: Text('Pascalis Reinard Rickyputra'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(40, 5, 16, 5),
            child: Text('1806233833'),
          ),
        ],
      ),
    );
  }
  void _startBMS(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MainScreen(server: server);
        },
      ),
    );
  }
}
