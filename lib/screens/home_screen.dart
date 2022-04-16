import 'package:flutter/material.dart';
import 'package:flutter_quick_start/utils/responsive.dart';
import 'package:flutter_quick_start/utils/theming.dart';
import 'package:flutter_quick_start/widgets/home/home_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// instantiate the grid items
    const HomeGrid _grids = HomeGrid();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.home),
            Text("HOME"),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final _theme = Theming(context);

          return Responsive(context).devicePreferredValue(
            ///---------------Mobile---------------
            mobile: const Padding(
              padding: EdgeInsets.all(30),
              child: _grids,
            ),

            ///---------------/Mobile---------------
            ///---------------Tablet---------------
            tablet: Column(
              children: [
                SizedBox(
                  height: _theme.heightInPercentage(10),
                  child: _grids,
                ),
                Expanded(
                  child: Center(
                    child: Text("Hey"),
                  ),
                )
              ],
            ),

            ///---------------/Tablet---------------
            ///---------------Large---------------
            large: Row(
              children: [
                SizedBox(
                  width: _theme.widthInPercentage(20),
                  child: _grids,
                ),
                Expanded(
                  child: Center(
                    child: Text("Hello"),
                  ),
                )
              ],
            ),

            ///---------------/Large---------------
          );
        },
      ),
    );
  }
}
