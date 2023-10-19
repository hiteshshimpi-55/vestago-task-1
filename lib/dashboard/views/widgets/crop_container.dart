import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vestago_task/dashboard/models/crop_model.dart';
import 'package:vestago_task/dashboard/view_models/crops_provider.dart';

import 'crop_card.dart';

class CropContainer extends StatelessWidget {
  const CropContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: 250,
      child: Consumer<CropsProvider>(
        builder: (context,cropProvider,child) => _futureWidget(context,cropProvider,size),
      ),
    );
  }

  Widget _futureWidget(BuildContext context,CropsProvider provider,Size size){
    if(provider.loading){
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }else if(provider.error.code != 0){
      return Center(
        child: Text(
          "Error: ${provider.error.message} with code ${provider.error.code}",
          style: const TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
      );
    }else{
      return FutureBuilder<List<CropModel>>(
        future: provider.crops,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CupertinoActivityIndicator());
          }else if(snapshot.hasData){
            return _ui(context,provider,size);
          }else{
            return Center(
              child: Text("An error occurred ${snapshot.error}"),
            );
          }
        },
      );
    }
  }
  Widget _ui(BuildContext context,CropsProvider provider,Size size){
    return Column(
      children: <Widget>[
        SizedBox(
          height: 70,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: provider.textEditingController,
                onChanged: (text) {
                  provider.filterItems(text);
                },
                decoration: const InputDecoration(
                  hintText: 'Search Specific Crop',
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height:20),
        Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 100/40
              ),
              itemCount: provider.filteredList.length,
              itemBuilder: (context,index){
                return CropCard(
                    model: provider.filteredList[index]
                );
              },
          ),
        )
      ],
    );
  }
}
