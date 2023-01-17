import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_shop/common/widgets/custom_button.dart';
import 'package:speed_shop/common/widgets/custom_textfield_inapp.dart';
import 'package:speed_shop/features/owner/services/owner_services.dart';
import '../../../constant/global_var.dart';
import '../../../providers/user_provider.dart';

class AddStationScreen extends StatefulWidget {
  static const String routeName = '/add-station';

  const AddStationScreen({super.key});

  @override
  State<AddStationScreen> createState() => _AddStationScreenState();
}

class _AddStationScreenState extends State<AddStationScreen> {
  final TextEditingController stationNameController = TextEditingController();
  final TextEditingController stationCityController = TextEditingController();

  final TextEditingController stationDescriptionController =
      TextEditingController();
  final TextEditingController stationIdController = TextEditingController();
  final OwnerServices ownerServices = OwnerServices();
  String district = 'Ampara';
  final _addStationFormKey = GlobalKey<FormState>();
  String currentID = '';

  @override
  void dispose() {
    super.dispose();
    stationNameController.dispose();
    stationCityController.dispose();

    stationDescriptionController.dispose();
    stationIdController.dispose();
  }

  List<String> districts = [
    'Ampara',
    'Anuradhapura',
    "Badulla",
    "Batticaloa",
    "Colombo",
    "Galle",
    "Gampaha",
    "Hambantota",
    "Jaffna",
    "Kalutara",
    "Kandy",
    "Kegalle",
    "Kilinochchi",
    "Kurunegala",
    "Mannar",
    "Matale",
    "Matara",
    "Moneragala",
    "Mullaitivu",
    "Nuwara Eliya",
    "Polonnaruwa",
    "Puttalam",
    "Ratnapura",
    "Trincomalee",
    "Vavuniya",
  ];
  void addStation() {
    //if (_addStationFormKey.currentState!.validate()) {
    ownerServices.addStation(
        context: context,
        name: stationNameController.text,
        city: stationCityController.text,
        district: district,
        description: stationDescriptionController.text,
        regId: int.parse(stationIdController.text),
        userId: currentID, isDieselAvailable: false, isPetrolAvailable:false);

    // }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    currentID = user.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Gas Station"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: GlobalVar.appBarGradient),
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _addStationFormKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              
              CustomTextFieldIn(
                  controller: stationNameController,
                  hintText: "Satation Name",
                  userIcon: const Icon(Icons.local_gas_station)),
              const SizedBox(
                height: 10,
              ),
              const Text("Select a district"),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  value: district,
                  items: districts.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newDistrict) {
                    setState(() {
                      district = newDistrict!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFieldIn(
                  controller: stationCityController,
                  hintText: "City",
                  userIcon: const Icon(Icons.location_city)),
              const SizedBox(
                height: 10,
              ),
              CustomTextFieldIn(
                  controller: stationDescriptionController,
                  hintText: "Descrtiption",
                  userIcon: const Icon(Icons.text_fields),
                  maxLines: 5),
              const SizedBox(
                height: 10,
              ),
              CustomTextFieldIn(
                  controller: stationIdController,
                  hintText: "Station Register Number",
                  userIcon: const Icon(Icons.document_scanner_sharp)),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                text: "Save",
                onTap: addStation,
              )
            ],
          ),
        ),
      )),
    );
  }
}
