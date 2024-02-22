import 'package:misamoneykeeper_flutter/common/report_row.dart';
import 'package:misamoneykeeper_flutter/controller/current_financial_view_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class CurrentFinancial extends StatefulWidget {
  const CurrentFinancial({super.key});

  @override
  State<CurrentFinancial> createState() => _CurrentFinancialState();
}

class _CurrentFinancialState extends State<CurrentFinancial> {
  late CurrentFinancialViewModel currentFinancialVM;

  @override
  void initState() {
    super.initState();
    currentFinancialVM = Get.put(CurrentFinancialViewModel());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: FutureBuilder(
      future: currentFinancialVM.serviceCallList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingIndicator();
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Container();
          } else if (snapshot.hasData) {
            var data = snapshot.data!;
            return Column(children: [
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
                      itemCount: data.length,
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
                          title: ("k").text.make(),
                          subtitle: formatCurrency(10000).text.make(),
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
            ]);
          } else {
            return Container();
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    ));
  }
}
