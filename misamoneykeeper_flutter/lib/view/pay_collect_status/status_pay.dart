import 'package:intl/intl.dart';
import 'package:misamoneykeeper_flutter/controller/status_pay_view_model.dart';
import 'package:misamoneykeeper_flutter/server/globs.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/add/add_view.dart';

class StatusPay extends StatefulWidget {
  const StatusPay({super.key});

  @override
  State<StatusPay> createState() => _StatusPayState();
}

var statusPayVM = Get.put(StatusPayViewModel());

class _StatusPayState extends State<StatusPay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: statusPayVM.serviceCallStatusPay(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: loadingIndicator());
            } else if (snapshot.hasError) {
              return Container(
                color: Colors.amber,
              );
            } else if (snapshot.hasData) {
              var data = snapshot.data!;
              var sum = 0;
              for (var element in data) {
                sum += element.sumMoney!;
              }
              var money = formatCurrency(sum);
              var isLoading = false.obs;
              return Column(
                children: [
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Tổng Chi"
                          .text
                          .size(16)
                          .color(Colors.black)
                          .fontFamily(sansBold)
                          .make(),
                      money.text
                          .size(16)
                          .color(Colors.red)
                          .fontFamily(sansBold)
                          .make(),
                    ],
                  )
                      .box
                      .white
                      .padding(const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10))
                      .make(),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 10),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(255, 229, 229, 229),
                                  child: Image.network(
                                    "${SVKey.mainUrl}${data[index].caImage!}",
                                    width: 30,
                                  )),
                              10.widthBox,
                              "${data[index].caName}"
                                  .text
                                  .size(16)
                                  .fontFamily(sansBold)
                                  .color(Colors.black87)
                                  .make(),
                              const Spacer(),
                              formatCurrency(data[index].sumMoney)
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
                                    padding: const EdgeInsets.only(right: 20),
                                    itemCount:
                                        data[index].categoryDetails!.length,
                                    itemBuilder: (context, index1) {
                                      return Column(children: [
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  isLoading.value =
                                                      !isLoading.value;
                                                },
                                                icon: const Icon(
                                                  Icons.arrow_drop_up_sharp,
                                                  size: 30,
                                                  color: Colors.black,
                                                )),
                                            CircleAvatar(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 229, 229, 229),
                                                child: Image.network(
                                                  "${SVKey.mainUrl}${data[index].categoryDetails![index1].cadImage!}",
                                                  width: 25,
                                                )),
                                            10.widthBox,
                                            "${data[index].categoryDetails![index1].cadName}"
                                                .text
                                                .size(16)
                                                .fontFamily(sansBold)
                                                .color(Colors.black87)
                                                .make(),
                                            const Spacer(),
                                            formatCurrency(data[index]
                                                    .categoryDetails![index1]
                                                    .sumMoney)
                                                .text
                                                .size(14)
                                                .color(Colors.black)
                                                .fontFamily(sansRegular)
                                                .make(),
                                          ],
                                        )
                                            .box
                                            .margin(const EdgeInsets.symmetric(
                                                vertical: 2))
                                            .make(),
                                        // Tieenf
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          itemCount: data[index]
                                              .categoryDetails![index1]
                                              .pay!
                                              .length,
                                          itemBuilder: (context, index2) {
                                            final formatter =
                                                DateFormat('dd/MM/yyyy');
                                            DateTime date = DateTime.parse(
                                                data[index]
                                                    .categoryDetails![index1]
                                                    .pay![index2]
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    formatCurrency(data[index]
                                                            .categoryDetails![
                                                                index1]
                                                            .pay![index2]
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
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2))
                                                .make()
                                                .onTap(() {
                                              Get.to(
                                                  () => AddView(
                                                        isCheck: true,
                                                        payId: data[index]
                                                                .categoryDetails![
                                                                    index1]
                                                                .pay![index2]
                                                        .payId,
                                                        categoryIcon: SVKey
                                                                .mainUrl +
                                                            data[index]
                                                                .categoryDetails![
                                                                    index1]
                                                                .pay![index2]
                                                                .cadImage!,
                                                        categoryTitle: data[
                                                                index]
                                                            .categoryDetails![
                                                                index1]
                                                            .pay![index2]
                                                            .categoryName,
                                                        categoryDetailsId: data[
                                                                index]
                                                            .categoryDetails![
                                                                index1]
                                                            .pay![index2]
                                                            .categoryDetailsId,
                                                        accountIcon: data[index]
                                                            .categoryDetails![
                                                                index1]
                                                            .pay![index2]
                                                            .acType,
                                                        accountTitle: data[
                                                                index]
                                                            .categoryDetails![
                                                                index1]
                                                            .pay![index2]
                                                            .acName,
                                                        accountId: data[index]
                                                            .categoryDetails![
                                                                index1]
                                                            .pay![index2]
                                                            .accountId,
                                                        dateController: data[
                                                                index]
                                                            .categoryDetails![
                                                                index1]
                                                            .pay![index2]
                                                            .pDate,
                                                        moneyAccount: data[
                                                                index]
                                                            .categoryDetails![
                                                                index1]
                                                            .pay![index2]
                                                            .pMoney!
                                                            .toString(),
                                                        descriptionAccount: data[
                                                                index]
                                                            .categoryDetails![
                                                                index1]
                                                            .pay![index2]
                                                            .pExplanation,
                                                      ),
                                                  transition:
                                                      Transition.rightToLeft);
                                            });
                                          },
                                        )
                                      ]);
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
