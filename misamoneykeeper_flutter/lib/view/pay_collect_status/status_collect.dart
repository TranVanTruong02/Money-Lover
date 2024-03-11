import 'package:intl/intl.dart';
import 'package:misamoneykeeper_flutter/controller/status_collect_view_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class StatusCollect extends StatefulWidget {
  const StatusCollect({super.key});

  @override
  State<StatusCollect> createState() => _StatusCollectState();
}

var statusCollectVM = Get.put(StatusCollectViewModel());

class _StatusCollectState extends State<StatusCollect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: statusCollectVM.serviceCallStatusCollect(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: loadingIndicator());
            } else if (snapshot.hasError) {
              return Container(
                color: Colors.amber,
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data!;
              var isLoading = false.obs;
              return Column(
                children: [
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Tổng Thu:"
                          .text
                          .size(16)
                          .color(Colors.black)
                          .fontFamily(sansBold)
                          .make(),
                      formatCurrency(data[0].sumMoney)
                          .text
                          .size(16)
                          .color(Colors.red)
                          .fontFamily(sansBold)
                          .make(),
                    ],
                  )
                      .box
                      .color(Colors.white)
                      .padding(const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10))
                      .make(),
                  10.heightBox,
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 10),
                    itemCount: data[0].categoryDetails!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 229, 229, 229),
                                  child: Image.network(
                                    "${SVKey.mainUrl}${data[0].categoryDetails![index].cadImage!}",
                                    width: 30,
                                  )),
                              10.widthBox,
                              "${data[0].categoryDetails![index].cadName}"
                                  .text
                                  .size(16)
                                  .fontFamily(sansBold)
                                  .color(Colors.black87)
                                  .make(),
                              const Spacer(),
                              formatCurrency(
                                      data[0].categoryDetails![index].sumMoney)
                                  .text
                                  .size(14)
                                  .color(Colors.red)
                                  .fontFamily(sansBold)
                                  .make(),
                              5.widthBox,
                              IconButton(
                                  onPressed: () {
                                    isLoading.value = !isLoading.value;
                                  },
                                  icon: const Icon(Icons.navigate_next))
                            ],
                          )
                              .box
                              .margin(const EdgeInsets.symmetric(vertical: 2))
                              .make(),
                          Obx(
                            () => isLoading.value == true
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 20),
                                    itemCount: data[0]
                                        .categoryDetails![index]
                                        .pay!
                                        .length,
                                    itemBuilder: (context, index1) {
                                      final formatter =
                                          DateFormat('dd/MM/yyyy');
                                      DateTime date = DateTime.parse(data[0]
                                          .categoryDetails![index]
                                          .pay![index1]
                                          .pDate!);
                                      String dateString =
                                          formatter.format(date);
                                      return Row(
                                        children: [
                                          dateString.text
                                              .size(16)
                                              .fontFamily(sansRegular)
                                              .color(Colors.black87)
                                              .make(),
                                          const Spacer(),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              formatCurrency(data[0]
                                                      .categoryDetails![index]
                                                      .pay![index1]
                                                      .pMoney)
                                                  .text
                                                  .size(14)
                                                  .color(Colors.black)
                                                  .fontFamily(sansRegular)
                                                  .make(),
                                              5.heightBox,
                                              const Icon(
                                                Icons.wallet,
                                                size: 20,
                                                color: Colors.black54,
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                          .box
                                          .margin(const EdgeInsets.symmetric(
                                              vertical: 2))
                                          .make();
                                    },
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      );
                    },
                  ),
                  10.heightBox,
                ],
              );
            } else {
              return Container(
                color: Colors.amber,
              );
            }
          },
        ),
      ),
    );
  }
}
