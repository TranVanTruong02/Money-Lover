import 'package:misamoneykeeper_flutter/controller/current_financial_view_model.dart';
import 'package:misamoneykeeper_flutter/model/report_account.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class CurrentFinancial extends StatefulWidget {
  const CurrentFinancial({super.key});

  @override
  State<CurrentFinancial> createState() => _CurrentFinancialState();
}

class _CurrentFinancialState extends State<CurrentFinancial> {
  late CurrentFinancialViewModel currentFinancialVM;
  late Stream<List<ReportAccount>?> dataStream;

  @override
  void initState() {
    super.initState();
    currentFinancialVM = Get.put(CurrentFinancialViewModel());
  }

  @override
  void dispose() {
    Get.delete<CurrentFinancialViewModel>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<ReportAccount>?>(
      stream: currentFinancialVM.dataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: loadingIndicator());
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.amber,
          );
        } else if (snapshot.hasData) {
          var data = snapshot.data;
          return Column(
            children: [
              "Hihi".text.make(),
              "oki: ${data![0].acName}".text.make(),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return "oki: ${data![index].acName}".text.make();
                },
              )
            ],
          );
        } else {
          return Container(
            color: Color.fromARGB(255, 63, 52, 18),
          );
        }
      },
    ));
  }
}
