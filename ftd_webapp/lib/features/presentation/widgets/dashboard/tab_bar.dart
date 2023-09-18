import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ftd_webapp/features/data/models/dataset/dataset.dart';
import 'package:ftd_webapp/features/presentation/widgets/dashboard/control_panel.dart';
import 'package:tabbed_card/tabbed_card.dart';

class MainTabBar extends ConsumerWidget{

  final Dataset dataset;
  const MainTabBar(this.dataset, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TabbedCard(
            tabs: [
              TabbedCardItem(
                label: "Time Manager",
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.black54,
                ),
                options: TabbedCardItensOptions(
                  tabColor: Colors.white24,
                ),
                child: ControlPanel(dataset),
              ),
              TabbedCardItem(
                label: "Analytics",
                icon: const Icon(
                  Icons.analytics_outlined,
                  color: Colors.black54,
                ),
                options: TabbedCardItensOptions(
                  tabColor: Colors.white24,
                ),
                child: Text("Provaaa"),
              ),
              TabbedCardItem(
                label: "Street Analytics",
                icon: const Icon(
                  Icons.map_outlined,
                  color: Colors.black54,
                ),
                options: TabbedCardItensOptions(
                  tabColor: Colors.white24,
                ),
                child: Text("Provaaa"),
              ),
            ],
          );
  }
}