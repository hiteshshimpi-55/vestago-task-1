import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeliveryPartnerCard extends StatelessWidget {
  const DeliveryPartnerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _profile(),
                _liveStatus(),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _vehicleProfile(),
                const Icon(
                  Icons.call,
                  ),
              ],
            ),
        ]),
      ),
    );
  }

  Widget _liveStatus(){
    return Container(
      height: 30,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Text(
          "Live",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold)
          ),
      ),
    );
  }

  Widget _profile(){
    return  const SizedBox(
      child: Row(
        children: <Widget>[
          Icon(Icons.account_box_rounded),
          SizedBox(width: 10),
          Text(
            "Ram Kadam",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
          )
      ],
      ),
    );
  }

  Widget _vehicleProfile(){
    return  const SizedBox(
      child: Row(
        children: <Widget>[
          Icon(Icons.fire_truck),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "MH 15 FB 2844",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black
                ),
              ),
              Text(
                "TATA ACE",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black
                ),
              ),
            ],
          )
      ],
      ),
    );
  }
}