import 'package:flutter/material.dart';
import 'package:postman_app/base/data/helper/constants.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            Icons.sort,
            size: 32,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Available  Trips Near You",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        actions: [
          GestureDetector(
            // onTap: () => con.logOut(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.notifications,
                size: 26,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: [
          const Text(
            'Trips in your zone',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 20,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.pushNamed(context, "/TripDetailsPage"),
                  splashColor: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: greyColor,
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        const Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.orangeAccent,
                                    size: 15,
                                  ),
                                  Text(
                                    'Starting city',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Text(
                                'New York',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: greenColor),
                              ),
                              Text(
                                'Jan 29, 13:09',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        const Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.blue,
                                    size: 15,
                                  ),
                                  Text(
                                    'Desination city',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Text(
                                'Toronto',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: greenColor),
                              ),
                              Text(
                                'Jan 29, 13:09',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Airplane',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: blackColor),
                              ),
                              Image.asset("assets/icons/airplane.png",
                                  height: 30)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
