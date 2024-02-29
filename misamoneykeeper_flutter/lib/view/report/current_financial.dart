import 'package:misamoneykeeper_flutter/common/report_row.dart';
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
    return SingleChildScrollView(
        child: FutureBuilder<List<ReportAccount>>(
      future: currentFinancialVM.serviceCallList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.amber,
          );
        } else {
          return Container(
            color: const Color.fromARGB(255, 108, 103, 88),
          );
        }
      },
    ));
  }
}
