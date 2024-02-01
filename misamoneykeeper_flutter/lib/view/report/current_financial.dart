import 'package:misamoneykeeper_flutter/common/report_row.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class CurrentFinancial extends StatefulWidget {
  const CurrentFinancial({super.key});

  @override
  State<CurrentFinancial> createState() => _CurrentFinancialState();
}

class _CurrentFinancialState extends State<CurrentFinancial> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const ReportRow(title: taichinhhientai, money: 36000),
        10.heightBox,
        Column(
          children: [
            const ReportRow(title: "Tổng có", money: 36000),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.black26,
                    thickness: 1,
                  );
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Colors.amber, shape: BoxShape.circle),
                        child: Image.asset(
                          icReport_1,
                          width: 10,
                          fit: BoxFit.cover,
                        )),
                    title: "Tiền mặt".text.make(),
                    subtitle: formatCurrency(0).text.make(),
                    trailing: Image.asset(
                      icRight,
                      width: 20,
                      color: Colors.black.withOpacity(0.4),
                    ),
                    onTap: () {},
                  );
                },
              ),
            )
          ],
        ),
        10.heightBox,
        const ReportRow(title: "Tổng nợ", money: 0),
      ]),
    );
  }
}
