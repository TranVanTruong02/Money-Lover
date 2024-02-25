import 'package:misamoneykeeper_flutter/utility/export.dart';

class CategoryCell extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onPressed;
  const CategoryCell(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 20,
          ),
          10.heightBox,
          title.text
              .size(12)
              .fontFamily(sansBold)
              .color(Colors.black87)
              .make()
        ]).box.white.roundedSM.shadowSm.make().onTap(onPressed);
  }
}
