import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_shop/features/station/services/queue_service.dart';
import 'package:tuple/tuple.dart';
import '../../../constant/global_var.dart';
import '../../../models/station.dart';
import '../../../providers/user_provider.dart';
import '../../search/screens/search_screen.dart';
import 'package:intl/intl.dart';

class StationScreen extends StatefulWidget {
  static const String routeName = '/station-screen';

  final Station staion;
  const StationScreen({
    Key? key,
    required this.staion,
  }) : super(key: key);

  @override
  State<StationScreen> createState() => _StationScreenState();
}

class _StationScreenState extends State<StationScreen> {
  
  String uservehicle = 'Motorcycle';
  Stopwatch stopwatch = Stopwatch();
  Duration duration = const Duration(seconds: 0);
  late Timer timer;
  bool isRunning = false;
  bool userIsInqueue = false;
  bool userIsFulled = false;
  final StationQueueServices stationQueueServices = StationQueueServices();
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  var vehicles = [
    'Motorcycle',
    'Threeweeler',
    'Car Van',
    'Bus Lorry',
    'Ohter',
  ];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _getQueueCount();
    _getDuration();
    _timer =
        Timer.periodic(const Duration(seconds: 1), (timer) => _getQueueCount());
    _timer =
        Timer.periodic(const Duration(seconds: 2), (timer) => _getDuration());
  }

  int _queueCount = 0;
  int _motorcycleCount = 0;
  int _threeweelerCount = 0;
  int _carCount = 0;
  int _busCount = 0;
  int _otherCount = 0;
  int _averageWaitngTime = 0;
  String finalWaitingTime = "";

 

  void _getQueueCount() async {
    final Tuple6<int, int, int, int, int, int> counts =
        await stationQueueServices.queueLength(
            context: context, station: widget.staion);
    _queueCount = counts.item1;
    _motorcycleCount = counts.item2;
    _threeweelerCount = counts.item3;
    _carCount = counts.item4;
    _busCount = counts.item5;
    _otherCount = counts.item6;

    setState(() {});
  }

void _getDuration() async {
    final int average = await stationQueueServices.queueDuration(
        context: context, station: widget.staion);
    _averageWaitngTime = average;
    Duration duration = Duration(seconds: _averageWaitngTime);
    String formattedDuration =
        "${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toStringAsFixed(0).padLeft(2, '0')}";
    finalWaitingTime = formattedDuration;
    // int minutes = _averageWaitngTime ~/ 60;
    // int remaingSeconds = _averageWaitngTime % 60;
    // int hours = minutes~/60;
    // int remainMinutes = minutes%60;
    // final formatter = new DateFormat('HH:mm:ss');
  }

  @override
  void dispose() {
    _timer.cancel();
    _getDuration();
    _getQueueCount();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int durationInSeconds;
    final user = Provider.of<UserProvider>(context).user;
    DateTime dateTimepetrol =
        DateTime.fromMicrosecondsSinceEpoch(widget.staion.petrolDate);
    String dateTimeStringPetrol =
        DateFormat("yyyy-MM-dd HH:mm").format(dateTimepetrol);
    DateTime dateTimeDiesel =
        DateTime.fromMicrosecondsSinceEpoch(widget.staion.dieslDate);
    String dateTimeStringDieslDate =
        DateFormat("yyyy-MM-dd HH:mm").format(dateTimeDiesel);
      
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: GlobalVar.appBarGradient,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Center(
                    child: Text(
                      "Fuel Assist",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(9),
                      elevation: 12,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                          hintText: "Staion name, City, Province ...",
                          hintStyle: const TextStyle(fontSize: 14),
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                left: 6,
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.orange,
                                size: 20,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: GlobalVar.appBarGradient),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              elevation: 8,
              child: Container(
                height: 120,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: PageView(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.staion.name,
                                        style: const TextStyle(
                                            color: Colors.orange,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        height: 2,
                                        width: double.infinity,
                                        color: Colors.orange,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      DefaultTextStyle(
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget.staion
                                                            .isPetrolAvailable
                                                        ? "Petrol available"
                                                        : "Petrol not available",
                                                    style: widget.staion
                                                            .isPetrolAvailable
                                                        ? const TextStyle(
                                                            color: Colors.green)
                                                        : const TextStyle(
                                                            color: Colors.red),
                                                  ),
                                                  Text(
                                                    widget.staion
                                                            .isDieselAvailable
                                                        ? "Diesel available"
                                                        : "Diesel not available",
                                                    style: widget.staion
                                                            .isDieselAvailable
                                                        ? const TextStyle(
                                                            color: Colors.green)
                                                        : const TextStyle(
                                                            color: Colors.red),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "From $dateTimeStringPetrol",
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                    "From $dateTimeStringDieslDate",
                                                    style: const TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${widget.staion.city}, ",
                                          ),
                                          Text(
                                            widget.staion.district,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.arrow_right_outlined,
                                        color: Colors.orange,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.staion.description),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 8,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Select your vehicle type"),
                      DropdownButton(
                        focusColor: Colors.red,
                        value: uservehicle,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: vehicles.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            uservehicle = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 40, color: Colors.orange),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  userIsInqueue = true;
                                  userIsFulled = false;
                                });
                                stationQueueServices.queueUpdate(
                                  context: context,
                                  station: widget.staion,
                                  isInQueue: userIsInqueue,
                                  isFuelled: userIsFulled,
                                  duration: 0,
                                  userID: user.id,
                                  vehicle: uservehicle,
                                );

                                if (!isRunning) {
                                  setState(() {
                                    isRunning = true;
                                  });

                                  stopwatch.start();

                                  timer = Timer.periodic(
                                      const Duration(milliseconds: 100),
                                      (timer) {
                                    setState(() {
                                      duration = stopwatch.elapsed;
                                    });
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                'In Queue',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(width: 6),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  userIsInqueue = false;
                                  userIsFulled = true;
                                });
                                durationInSeconds = stopwatch.elapsed.inSeconds;
                                stationQueueServices.queueUpdate(
                                  context: context,
                                  station: widget.staion,
                                  isInQueue: userIsInqueue,
                                  isFuelled: userIsFulled,
                                  duration: durationInSeconds.toInt(),
                                  userID: user.id,
                                  vehicle: uservehicle,
                                );

                                if (isRunning) {
                                  setState(() {
                                    isRunning = false;
                                  });

                                  stopwatch.stop();
                                  timer.cancel();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              child: const Text('Fueled',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          const SizedBox(width: 6),
                          ElevatedButton(
                              onPressed: () {
                                userIsInqueue = false;
                                userIsFulled = false;
                                stationQueueServices.queueUpdate(
                                  context: context,
                                  station: widget.staion,
                                  isInQueue: userIsInqueue,
                                  isFuelled: userIsFulled,
                                  duration: 0,
                                  userID: user.id,
                                  vehicle: uservehicle,
                                );
                                setState(() {
                                  isRunning = false;
                                  duration = const Duration(seconds: 0);
                                  timer.cancel();
                                  stopwatch.reset();
                                });
                              },
                              autofocus: true,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: const Text("Leave",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Current Queue  ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            _queueCount.toString(),
                            style: const TextStyle(fontSize: 40),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DefaultTextStyle(
                        style:
                            const TextStyle(color: Colors.orange, fontSize: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  "assets/vehicle/bike.png",
                                  width: 45,
                                  height: 45,
                                ),
                                Text(
                                  _motorcycleCount.toString(),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/vehicle/threeweel.png",
                                  width: 45,
                                  height: 45,
                                ),
                                Text(
                                  _threeweelerCount.toString(),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/vehicle/car.png",
                                  width: 45,
                                  height: 45,
                                ),
                                Text(
                                  _carCount.toString(),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/vehicle/bus.png",
                                  width: 45,
                                  height: 45,
                                ),
                                Text(
                                  _busCount.toString(),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  "assets/vehicle/other.png",
                                  width: 45,
                                  height: 45,
                                ),
                                Text(
                                  _otherCount.toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 8,
              child: Container(
                  height: 120,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text("Estimated Waiting Time on ${widget.staion.name}"),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        finalWaitingTime,
                        style: const TextStyle(fontSize: 40),
                      ),
                    ],
                  )),
            )
          ],
        ),
      )),
    );
  }
}

/* 




*/
