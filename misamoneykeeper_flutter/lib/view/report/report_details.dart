import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/report/current_financial.dart';

class ReportDetails extends StatefulWidget {
  const ReportDetails({super.key});

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  int position = 0;

  void changePosition(int index) {
    setState(() {
      position = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 242, 242),
        appBar: AppBar(
          title: InkWell(
            onTap: () {
              final left = context.screenWidth / 4.3;
              final top = context.screenHeight * 0.12;
              final right = left;

              showMenu(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                context: context,
                position: RelativeRect.fromLTRB(left, top, right, 0.0),
                items: List.generate(
                  textLisReport.length,
                  (index) => PopupMenuItem(
                    value: index + 1,
                    child: Row(children: [
                      Image.asset(
                        iconListReport[index],
                        width: 15,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        textLisReport[index],
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.5),
                            fontFamily: sansRegular),
                      ),
                      index == position
                          ? Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.check_sharp,
                                  weight: 15,
                                  color: Colors.red.withOpacity(0.5),
                                )
                              ],
                            )
                          : const SizedBox.shrink()
                    ]),
                  ),
                ),
              ).then((value) {
                switch (value) {
                  case 1:
                    changePosition(0);
                    break;
                  case 2:
                    changePosition(1);
                    break;
                  case 3:
                    changePosition(2);
                    break;
                  case 4:
                    changePosition(3);
                    break;
                  case 5:
                    changePosition(4);
                    break;
                  case 6:
                    changePosition(5);
                    break;
                  case 7:
                    changePosition(6);
                    break;
                  case 8:
                    changePosition(7);
                    break;
                }
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                textLisReport[0]
                    .text
                    .size(18)
                    .fontFamily(sansBold)
                    .white
                    .make(),
                const SizedBox(width: 5),
                Image.asset(
                  icArrowDown,
                  width: 12,
                  color: Colors.white,
                ),
              ],
            )
                .box
                .height(35)
                .padding(const EdgeInsets.symmetric(horizontal: 15))
                .withDecoration(
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.3),
                  ),
                )
                .make(),
          ),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: position,
          children: [
            const CurrentFinancial(),
            Container(color: Colors.blue),
            Container(color: Colors.cyan),
            Container(color: Colors.lightGreenAccent),
            Container(color: Colors.cyanAccent),
            Container(color: Colors.black38),
            Container(),
            Container(),
          ],
        ));
  }
}
