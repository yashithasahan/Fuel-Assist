import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';
import 'package:speed_shop/common/widgets/custom_button.dart';
import 'package:speed_shop/features/owner/services/owner_services.dart';
import 'package:speed_shop/models/station.dart';
import '../../../constant/global_var.dart';
import '../../../providers/user_provider.dart';

class OwnerDashScreen extends StatefulWidget {
  static const String routeName = '/dash-screen';
  final Station station;

  const OwnerDashScreen({
    Key? key,
    required this.station,
  }) : super(key: key);

  @override
  State<OwnerDashScreen> createState() => _OwnerDashScreenState();
}

class _OwnerDashScreenState extends State<OwnerDashScreen> {
  //Time picker for petrol update
  DateTime dateTimePetrol = DateTime.now();

  Future pickDateTime() async {
    DateTime? datePetrol = await pickDate();
    if (datePetrol == null) return;

    TimeOfDay? timePetrol = await pickTime();
    if (timePetrol == null) return;

    final dateTimePetrol = DateTime(
      datePetrol.year,
      datePetrol.month,
      datePetrol.day,
      timePetrol.hour,
      timePetrol.minute,
    );
    setState(() => this.dateTimePetrol = dateTimePetrol);
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2050),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: dateTimePetrol.hour, minute: dateTimePetrol.minute),
      );

//clock end

//Time picker for diesel update

  DateTime dateTimeDiesel = DateTime.now();

  Future pickDateTimeDiesel() async {
    DateTime? dateDiesel = await pickDateDiesel();
    if (dateDiesel == null) return;

    TimeOfDay? timeDiesel = await pickTimeDiesel();
    if (timeDiesel == null) return;

    final dateTimeDiesel = DateTime(
      dateDiesel.year,
      dateDiesel.month,
      dateDiesel.day,
      timeDiesel.hour,
      timeDiesel.minute,
    );
    setState(() => this.dateTimeDiesel = dateTimeDiesel);
  }

  Future<DateTime?> pickDateDiesel() => showDatePicker(
        context: context,
        initialDate: dateTimeDiesel,
        firstDate: DateTime(2020),
        lastDate: DateTime(2050),
      );

  Future<TimeOfDay?> pickTimeDiesel() => showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: dateTimeDiesel.hour, minute: dateTimeDiesel.minute),
      );

//clock end

  final OwnerServices ownerServices = OwnerServices();
  final TextEditingController petrolArrivalController = TextEditingController();
  late String date;
  bool petorlStaute = true;
  bool diesellStaute = true;
  late Timer _timer;
  late bool petrolget;
  late bool deisleget;







  void updatePetrolStatus() {
    ownerServices.updateStationPetrolAvailability(
        context: context, 
        id: widget.station.id, 
        petrolStauts: petorlStaute, 
        petrolDate: dateTimePetrol.microsecondsSinceEpoch);
  }

  void updateDieselStatus() {
    ownerServices.updateStationDieselAvailability(
      context: context,
      id: widget.station.id,
      dieselStauts: diesellStaute,
      dieselDate: dateTimeDiesel.microsecondsSinceEpoch,
    );
  }


void getDieselStatus() {
    deisleget = widget.station.isDieselAvailable;
  }

  void getPetrolStatus() {
    petrolget = widget.station.isPetrolAvailable;
  }

  @override
  void initState() {
    super.initState();
    getDieselStatus();
    getPetrolStatus();
  }

  @override
  Widget build(BuildContext context) {
//clock
    final hoursPetrol = dateTimePetrol.hour.toString().padLeft(2, '0');
    final minutesPetrol = dateTimePetrol.minute.toString().padLeft(2, '0');
    final hoursDiesel = dateTimeDiesel.hour.toString().padLeft(2, '0');
    final minutesDiesel = dateTimeDiesel.minute.toString().padLeft(2, '0');
//clocke end
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
        appBar: AppBar(
          title: Text("Manage ${widget.station.name} Station"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: GlobalVar.appBarGradient),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.station.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 80, 80, 80)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 8,
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Color.fromARGB(161, 255, 140, 0)),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(" Set Petrol Availability"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  LiteRollingSwitch(
                                    value: true,
                                    textOn: "Available",
                                    textOff: "Unavailable",
                                    textSize: 13,
                                    colorOn: Colors.greenAccent,
                                    colorOff: Colors.redAccent,
                                    iconOn: Icons.oil_barrel,
                                    iconOff: Icons.stop_circle_outlined,
                                    onChanged: (bool possiton) {
                                      petorlStaute = possiton;
                                    },
                                    onDoubleTap: () {},
                                    onSwipe: () {},
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  const Text("Current Status"),
                                  Text(petrolget
                                      ? "available"
                                      : "not available"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                  child: Text(
                                      '${dateTimePetrol.year}/${dateTimePetrol.month}/${dateTimePetrol.day} $hoursPetrol:$minutesPetrol'),
                                  onPressed: () async {
                                    final datePetrol = await pickDateTime();
                                    if (datePetrol == null) return;
                                    setState(() => dateTimePetrol = datePetrol);
                                  }),
                              const Text("Select the update time"),
                              Text(
                                "last update : ${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.fromMicrosecondsSinceEpoch(widget.station.petrolDate))} ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 146, 146, 146)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 8,
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Color.fromARGB(161, 255, 140, 0)),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Set Diesel Availability"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  LiteRollingSwitch(
                                    value: true,
                                    textOn: "Available",
                                    textOff: "Unavailable",
                                    textSize: 13,
                                    colorOn: Colors.greenAccent,
                                    colorOff: Colors.redAccent,
                                    iconOn: Icons.oil_barrel,
                                    iconOff: Icons.stop_circle_outlined,
                                    onChanged: (bool possiton) {
                                      diesellStaute = possiton;
                                    },
                                    onDoubleTap: () {},
                                    onSwipe: () {},
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  const Text("Current Status"),
                                  Text(deisleget
                                      ? "available"
                                      : "not available"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ElevatedButton(
                                  child: Text(
                                      '${dateTimeDiesel.year}/${dateTimeDiesel.month}/${dateTimeDiesel.day} $hoursDiesel:$minutesDiesel'),
                                  onPressed: () async {
                                    final dateDiesel =
                                        await pickDateTimeDiesel();
                                    if (dateDiesel == null) return;
                                    setState(() => dateTimeDiesel = dateDiesel);
                                  }),
                              const Text("Select the update time"),
                              Text(
                                "last update : ${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.fromMicrosecondsSinceEpoch(widget.station.dieslDate))} ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 146, 146, 146)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    text: "Update",
                    onTap: () {
                      updateDieselStatus();
                      updatePetrolStatus();
                    })
              ],
            ),
          ),
        ));
  }
}
