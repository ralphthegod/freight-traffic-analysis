import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftd_webapp/core/resources/constants/constants.dart';
import 'package:ftd_webapp/core/resources/data_state.dart';
import 'package:ftd_webapp/features/data/models/dataset/dataset.dart';
import 'package:ftd_webapp/features/presentation/states/dashboard_state.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class ControlPanel extends ConsumerStatefulWidget{

  final Dataset dataset;

  const ControlPanel(this.dataset, {Key? key}) : super(key: key);

  @override
  _ControlPanelState createState() => _ControlPanelState();

}

class _ControlPanelState extends ConsumerState<ControlPanel>{

  late var state;
  DateTime startDate = DateTime(2019,1,1,0,0);
  DateTime endDate = DateTime(2019,1,1,0,0);

  @override
  Widget build(BuildContext context) {
    state = ref.watch(dashboardStateProvider);
    return 
      Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Text("Dataset loaded: ${widget.dataset.name}",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 210,
                  height: 70,
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(text: startDate.toString()),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black54,
                ),
                
                const SizedBox(width: 10),
                SizedBox(
                  width: 210,
                  height: 70,
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: TextEditingController(text: endDate.toString()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed:() async{
                    ref.read(dashboardStateProvider.notifier).state = const DataEmpty();
                    List<DateTime>? dateTimeList =
                          await showOmniDateTimeRangePicker(
                        context: context,
                        startInitialDate: startDate,
                        startFirstDate:
                            DateTime(1600).subtract(const Duration(days: 3652)),
                        startLastDate: DateTime.now().add(
                          const Duration(days: 3652),
                        ),
                        endInitialDate: endDate,
                        endFirstDate:
                            DateTime(1600).subtract(const Duration(days: 3652)),
                        endLastDate: DateTime.now().add(
                          const Duration(days: 3652),
                        ),
                        is24HourMode: true,
                        isShowSeconds: false,
                        minutesInterval: 5,
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        constraints: const BoxConstraints(
                          maxWidth: 350,
                          maxHeight: 650,
                        ),
                        transitionBuilder: (context, anim1, anim2, child) {
                          return FadeTransition(
                            opacity: anim1.drive(
                              Tween(
                                begin: 0,
                                end: 1,
                              ),
                            ),
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 200),
                        barrierDismissible: true,
                        
                      );
                      if (dateTimeList != null && dateTimeList.length == 2) {
                        setState(() {
                          startDate = dateTimeList[0];
                          endDate = dateTimeList[1];
                        });
                      }
                  }, 
                  child:
                    const Text("Select date"),
                ),

                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    ref.read(dashboardStateProvider.notifier).fetch({"dataset": widget.dataset.name, "start": startDate.toIso8601String(), "end": endDate.toIso8601String()});
                  },
                  child: const Text("Load")
                
                )
              ],
            )
          ],
        )
      );
  }

}