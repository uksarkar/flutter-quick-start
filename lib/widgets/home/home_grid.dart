import 'package:flutter/material.dart';
import '../../utils/responsive.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _responsive = Responsive(context);

    return GridView.count(
      crossAxisCount: _responsive.devicePreferredValue(
        mobile: 2,
        large: 1,
      ),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      shrinkWrap: true,
      primary: false,
      scrollDirection: _responsive.devicePreferredValue(
        mobile: Axis.vertical,
        tablet: Axis.horizontal,
        large: Axis.vertical,
      ),
      children: [
        _box(
          "Users",
          Icons.people,
          _responsive.devicePreferredValue(
            mobile: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Hello from mobile"),
                ),
              );
            },
            large: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Hello from tablet, or desktop"),
                ),
              );
            },
          ),
        ),
        _box("Create User", Icons.person_add_alt, () {}),
        _box("Posts", Icons.line_weight_sharp, () {}),
        _box("Create Post", Icons.note_add_sharp, () {}),
      ],
    );
  }

  Widget _box(String label, IconData icon, void Function() onTap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: Colors.grey.shade200,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Icon(
                    icon,
                    size: 50,
                  ),
                ),
                Text(label)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
