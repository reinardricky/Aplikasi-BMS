import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'dart:math' as math;
import 'dart:async';

class MainScreen extends StatefulWidget {
  final BluetoothDevice server;

  const MainScreen({Key? key, required this.server}) : super(key: key);

  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  var connection; //BluetoothConnection

  String _messageBuffer = '';

  late int percentage1 = 0;
  late int percentage2 = 0;
  late int percentage3 = 0;
  late int percentage4 = 0;
  late double value1 = 0.00;
  late double value2 = 0.00;
  late double value3 = 0.00;
  late double value4 = 0.00;

  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;

  bool isConnecting = true;
  bool isDisconnecting = false;

  @override
  void initState() {
    chartData = getChartData();
    Timer.periodic(const Duration(seconds: 60), updateDataSource);
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection.input.listen(_onDataReceived).onDone(() {
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected()) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const twoPi = 3.14 * 2;
    const size = 130.0;
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: (isConnecting
                  ? const Text('Berusaha koneksi dengan divais......')
                  : isConnected()
                      ? const Text('Terkoneksi dengan divais')
                      : const Text('Terputus dengan divais')),
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.battery_charging_full_sharp)),
                  Tab(icon: Icon(Icons.stacked_line_chart))
                ],
              ),
            ),
            body: SafeArea(
              child: TabBarView(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 20, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Baterai 1',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                              width: size,
                              height: size,
                              child: Stack(children: [
                                ShaderMask(
                                    shaderCallback: (rect) {
                                      return SweepGradient(
                                          startAngle: 0.0,
                                          endAngle: twoPi,
                                          stops: [value1, value1],
                                          center: Alignment.center,
                                          colors: [
                                            Colors.blue,
                                            Colors.black.withAlpha(55)
                                          ]).createShader(rect);
                                    },
                                    child: Container(
                                      width: size,
                                      height: size,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: Image.asset(
                                                    "assets/images/radial_scale.png")
                                                .image),
                                      ),
                                    )),
                                Center(
                                  child: Container(
                                      width: size - 40,
                                      height: size - 40,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Center(
                                          child: Text(
                                        "$percentage1 %",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ))),
                                )
                              ])),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Baterai 2',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                              width: size,
                              height: size,
                              child: Stack(children: [
                                ShaderMask(
                                    shaderCallback: (rect) {
                                      return SweepGradient(
                                          startAngle: 0.0,
                                          endAngle: twoPi,
                                          stops: [value2, value2],
                                          center: Alignment.center,
                                          colors: [
                                            Colors.blue,
                                            Colors.black.withAlpha(55)
                                          ]).createShader(rect);
                                    },
                                    child: Container(
                                      width: size,
                                      height: size,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: Image.asset(
                                                    "assets/images/radial_scale.png")
                                                .image),
                                      ),
                                    )),
                                Center(
                                  child: Container(
                                      width: size - 40,
                                      height: size - 40,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Center(
                                          child: Text(
                                        "$percentage2 %",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ))),
                                )
                              ])),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Baterai 3',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                              width: size,
                              height: size,
                              child: Stack(children: [
                                ShaderMask(
                                    shaderCallback: (rect) {
                                      return SweepGradient(
                                          startAngle: 0.0,
                                          endAngle: twoPi,
                                          stops: [value3, value3],
                                          center: Alignment.center,
                                          colors: [
                                            Colors.blue,
                                            Colors.black.withAlpha(55)
                                          ]).createShader(rect);
                                    },
                                    child: Container(
                                      width: size,
                                      height: size,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: Image.asset(
                                                    "assets/images/radial_scale.png")
                                                .image),
                                      ),
                                    )),
                                Center(
                                  child: Container(
                                      width: size - 40,
                                      height: size - 40,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Center(
                                          child: Text(
                                        "$percentage3 %",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ))),
                                )
                              ])),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Baterai 4',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                              width: size,
                              height: size,
                              child: Stack(children: [
                                ShaderMask(
                                    shaderCallback: (rect) {
                                      return SweepGradient(
                                          startAngle: 0,
                                          endAngle: twoPi,
                                          stops: [value4, value4],
                                          center: Alignment.center,
                                          colors: [
                                            Colors.blue,
                                            Colors.black.withAlpha(55)
                                          ]).createShader(rect);
                                    },
                                    child: Container(
                                      width: size,
                                      height: size,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: Image.asset(
                                                    "assets/images/radial_scale.png")
                                                .image),
                                      ),
                                    )),
                                Center(
                                  child: Container(
                                      width: size - 40,
                                      height: size - 40,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Center(
                                          child: Text(
                                        "$percentage4 %",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ))),
                                )
                              ])),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 20, 0),
                  child: Column(children: [
                    SizedBox(
                        height: 300,
                        child: SfCartesianChart(
                          series: <LineSeries<LiveData, int>>[
                            LineSeries<LiveData, int>(
                                onRendererCreated:
                                    (ChartSeriesController controller) {
                                  _chartSeriesController = controller;
                                },
                                name: 'Baterai 1',
                                dataSource: chartData,
                                color: const Color.fromRGBO(192, 108, 132, 1),
                                xValueMapper: (LiveData sales, _) => sales.time,
                                yValueMapper: (LiveData sales, _) =>
                                    sales.chart1,
                                markerSettings:
                                    const MarkerSettings(isVisible: true,height: 4,width: 4,borderWidth: 1.5)),
                            LineSeries<LiveData, int>(
                                onRendererCreated:
                                    (ChartSeriesController controller) {
                                  _chartSeriesController = controller;
                                },
                                name: 'Baterai 2',
                                dataSource: chartData,
                                color: const Color.fromRGBO(108, 132, 192, 1.0),
                                xValueMapper: (LiveData sales, _) => sales.time,
                                yValueMapper: (LiveData sales, _) =>
                                    sales.chart2,
                                markerSettings:
                                    const MarkerSettings(isVisible: true,height: 4,width: 4,borderWidth: 1.5)),
                            LineSeries<LiveData, int>(
                                onRendererCreated:
                                    (ChartSeriesController controller) {
                                  _chartSeriesController = controller;
                                },
                                name: 'Baterai 3',
                                dataSource: chartData,
                                color: const Color.fromRGBO(219, 206, 69, 1.0),
                                xValueMapper: (LiveData sales, _) => sales.time,
                                yValueMapper: (LiveData sales, _) =>
                                    sales.chart3,
                                markerSettings:
                                    const MarkerSettings(isVisible: true,height: 4,width: 4,borderWidth: 1.5)),
                            LineSeries<LiveData, int>(
                                onRendererCreated:
                                    (ChartSeriesController controller) {
                                  _chartSeriesController = controller;
                                },
                                name: 'Baterai 4',
                                dataSource: chartData,
                                color: const Color.fromRGBO(81, 239, 15, 1.0),
                                xValueMapper: (LiveData sales, _) => sales.time,
                                yValueMapper: (LiveData sales, _) =>
                                    sales.chart4,
                                markerSettings: const MarkerSettings(isVisible: true,height: 4,width: 4,borderWidth: 1.5))
                          ],
                          primaryXAxis: NumericAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              // autoScrollingDelta: 3,
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              // interval: 1,
                              title: AxisTitle(text: 'Time (Minutes)')),
                          primaryYAxis: NumericAxis(
                              labelFormat: '{value}%',
                              maximum: 100,
                              minimum: 0,
                              axisLine: const AxisLine(width: 0),
                              majorTickLines: const MajorTickLines(size: 0),
                              title: AxisTitle(text: 'State of Charge')),
                          legend: Legend(
                              isVisible: true,
                              toggleSeriesVisibility: true,
                              position: LegendPosition.bottom,
                              overflowMode: LegendItemOverflowMode.wrap),
                        )),
                  ]),
                )
              ]),
            )));
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    for (var byte in data) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    }
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    var bat = dataString.split(";");
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        percentage1 = int.parse(bat[0]);
        percentage2 = int.parse(bat[1]);
        percentage3 = int.parse(bat[2]);
        percentage4 = int.parse(bat[3]);
        value1 = (double.parse(bat[0])) / 100;
        value2 = (double.parse(bat[1])) / 100;
        value3 = (double.parse(bat[2])) / 100;
        value4 = (double.parse(bat[3])) / 100;
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  bool isConnected() {
    return connection != null && connection.isConnected;
  }

  int time = 0;

  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, percentage1,percentage2,percentage3,percentage4));
    // chartData.add(LiveData(
    //     time++,
    //     (math.Random().nextInt(60) + 30),
    //     (math.Random().nextInt(60) + 30),
    //     (math.Random().nextInt(60) + 30),
    //     (math.Random().nextInt(60) + 30)));
    // chartData.removeAt(0);
    _chartSeriesController.updateDataSource(addedDataIndex: chartData.length);
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      // LiveData(0, 0, 0, 0, 0),
    ];
  }
}

class LiveData {
  LiveData(this.time, this.chart1, this.chart2, this.chart3, this.chart4);

  final int time;
  final num chart1;
  final num chart2;
  final num chart3;
  final num chart4;
}
