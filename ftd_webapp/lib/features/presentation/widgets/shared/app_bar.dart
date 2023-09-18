import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  
  final bool automaticallyImplyLeading;
  const MainAppBar({super.key, this.automaticallyImplyLeading = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      automaticallyImplyLeading: automaticallyImplyLeading,
        elevation: 2.0,
        title: const Text('Freight Traffic Analysis', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30.0)),
        actions: <Widget>
        [
          Container
          (
            margin: const EdgeInsets.only(right: 20.0, top:3.0),
            child: const Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>
              [
                Text('FTA', style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w700, fontSize: 14.0)),
              ],
            ),
          )
        ],
      );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}