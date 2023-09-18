import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftd_webapp/features/data/models/dataset/dataset.dart';

class DatasetListItem extends StatefulWidget{

  final Dataset dataset;
  final Function(Dataset) loadDatasetCallback;

  const DatasetListItem({super.key, required this.dataset, required this.loadDatasetCallback});

  @override
  State<StatefulWidget> createState() => _DatasetListItemState();
}

class _DatasetListItemState extends State<DatasetListItem>{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() async {
        _onTap();
      },
      child: Card(
        child: Stack(
          children: [
            const SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child:
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  Text(widget.dataset.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text("Streets: ${widget.dataset.totalStreets}   Events: ${widget.dataset.totalEvents}",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
            Positioned(
              right: 0.0,
              top: 20,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () async {
                  _onTap();
                },
              ),
            ),
          ],
        )
      ),
    );
  }

  void _onTap() async {
    widget.loadDatasetCallback(widget.dataset);
  }

}