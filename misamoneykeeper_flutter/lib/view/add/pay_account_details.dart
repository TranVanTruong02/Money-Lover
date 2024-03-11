import 'package:misamoneykeeper_flutter/controller/pay_account_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/pay_collect_view_model.dart';
import 'package:misamoneykeeper_flutter/controller/pay_view_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class PayAccountDetails extends StatelessWidget {
  final int type;
  const PayAccountDetails({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    var payAccount = Get.put(PayAccountViewModel());
    final payVM = Get.find<PayViewModel>();
    final payVM1 = Get.find<PayCollectViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: "Chọn tài khoản".text.size(18).white.fontFamily(sansBold).make(),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: payAccount.serviceCallAccount(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: loadingIndicator());
          } else if (snapshot.hasError) {
            return Container(
              color: Colors.amber,
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            var data = snapshot.data!;
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.black26,
                );
              },
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Colors.amber, shape: BoxShape.circle),
                        child: Image.asset(
                          (data[index].acType == 1 ? icReport_1 : icReport_2),
                          width: 10,
                          fit: BoxFit.cover,
                        )),
                    15.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ("${data[index].acName}")
                            .text
                            .size(16)
                            .color(Colors.black45)
                            .fontFamily(sansBold)
                            .make(),
                        3.heightBox,
                        formatCurrency(data[index].acMoney)
                            .text
                            .size(14)
                            .fontFamily(sansRegular)
                            .color(Colors.blue[200])
                            .make(),
                      ],
                    ),
                    const Spacer(),
                    data[index].accountId == payVM.accountId.value
                        ? const Icon(
                            Icons.check_box_rounded,
                            color: Colors.blue,
                          )
                        : const SizedBox.shrink(),
                  ],
                )
                    .box
                    .padding(const EdgeInsets.symmetric(vertical: 5))
                    .margin(const EdgeInsets.symmetric(vertical: 5))
                    .make()
                    .onTap(() {
                  if (type == 1) {
                    payVM.accountIcon.value =
                      data[index].acType == 1 ? icReport_1 : icReport_2;
                  payVM.accountTitle.value = data[index].acName!;
                  payVM.accountId.value = data[index].accountId!;
                  } else {
                    payVM1.accountIcon.value =
                      data[index].acType == 1 ? icReport_1 : icReport_2;
                  payVM1.accountTitle.value = data[index].acName!;
                  payVM1.accountId.value = data[index].accountId!;
                  }
                  
                  Get.back();
                });
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
