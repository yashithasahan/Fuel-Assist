import 'package:flutter/material.dart';
import 'package:speed_shop/features/owner/screens/add_station_screen.dart';
import 'package:speed_shop/features/owner/services/owner_services.dart';
import 'package:speed_shop/models/station.dart';
import '../../../common/widgets/loader.dart';
import '../../../constant/global_var.dart';
import 'dash_screen.dart';

class GasStationScreen extends StatefulWidget {
  const GasStationScreen({super.key});

  @override
  State<GasStationScreen> createState() => _GasStationScreenState();
}

class _GasStationScreenState extends State<GasStationScreen>
    with WidgetsBindingObserver {
  List<Station>? stations = [];
  final OwnerServices ownerServices = OwnerServices();
      



  @override
  void initState() {
    
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      fetchAllStations();
    }
  }


  fetchAllStations() async {
    stations = await ownerServices.fetchAllStations(context);
    setState(() {});
  }

  void navigateToAddStation() {
    Navigator.pushNamed(context, AddStationScreen.routeName);
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    fetchAllStations();
    return stations == null
        ? const LoaderBar()
        : Scaffold(
            appBar: AppBar(
                title: const Center(child: Text("Manage your Stations")),
                elevation: 6,
                flexibleSpace: Container(
                  decoration:
                      const BoxDecoration(gradient: GlobalVar.appBarGradient),
                )),
            body: GridView.builder(
              itemCount: stations?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 0),
              itemBuilder: (context, index) {
                final station = stations![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OwnerDashScreen.routeName,
                      arguments: station,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 8,
                        child: SizedBox(
                          height: 122,
                          child: Column(
                            children: [
                              Container(
                                color: Colors.orange,
                                height: 20,
                                child: Center(
                                    child: Text(
                                  station.name,
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(station.city),
                                  Text(station.district),
                                  Text("Reg - ${station.regId}")
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      
                    ],
                  ),
                );
              },
            ),
            
            floatingActionButton: FloatingActionButton(
              onPressed: navigateToAddStation,
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              splashColor: Colors.red,
              child: const Icon(Icons.add),
            
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
                
          );
  }
}
