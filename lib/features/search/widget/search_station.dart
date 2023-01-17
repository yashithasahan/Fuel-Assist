import 'package:flutter/material.dart';
import 'package:speed_shop/features/station/screens/station_screen.dart';

import '../../../models/station.dart';

class SearchStation extends StatelessWidget {
  final Station station;
  Color petrolColor = Colors.grey;
  Color dieselColor = Colors.grey;

  SearchStation({
    Key? key,
    required this.station,
  }) : super(key: key);

  
  upPetrolColor() {
    if (station.isPetrolAvailable == true) {
      petrolColor = Colors.green;
    } else {
      petrolColor = Colors.red;
    }
    if (station.isDieselAvailable == true) {
      dieselColor = Colors.green;
    } else {
      dieselColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    upPetrolColor();
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          StationScreen.routeName,
          arguments: station,
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 6,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          station.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${station.city}, ${station.district}",
                          style: const TextStyle(
                              color: Color.fromRGBO(117, 117, 117, 1)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("Petrol"),
                            const SizedBox(
                              width: 8,
                            ),
                            CircleAvatar(
                              backgroundColor: petrolColor,
                              radius: 5,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text("Diesel"),
                            const SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              backgroundColor: dieselColor,
                              radius: 5,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
