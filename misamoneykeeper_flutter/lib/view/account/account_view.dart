import 'package:misamoneykeeper_flutter/common/exit_dialog.dart';
import 'package:misamoneykeeper_flutter/common/report_row.dart';
import 'package:misamoneykeeper_flutter/controller/account_view_model.dart';
import 'package:misamoneykeeper_flutter/model/account_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/account/account_add.dart';
import 'package:misamoneykeeper_flutter/view/account/account_update.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late AccountViewModel accountViewModel;
  @override
  void initState() {
    super.initState();
    accountViewModel = Get.put(AccountViewModel());
  }

  @override
  void dispose() {
    Get.delete<AccountViewModel>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AccountAdd()));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'Tài khoản',
          style: TextStyle(
            color: Colors.white,
            // Đặt màu chữ thành màu trắng
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder<List<AccountModel>?>(
        stream: accountViewModel.dataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: loadingIndicator());
          } else if (snapshot.hasError) {
            return Container(
              color: Colors.amber,
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            int sum = 0;
            for (var element in data!) {
              sum += element.acMoney!;
            }

            return SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Tổng tiền: ${formatCurrency(sum)}',
                    style: const TextStyle(
                        fontSize: 17,
                        fontFamily: sansBold,
                        color: Colors.black),
                  ),
                ),
                10.heightBox,
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ReportRow(
                          title: "Sử dụng (${data.length} tài khoản)",
                          money: sum),
                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 1,
                            thickness: 1,
                          );
                        },
                        itemBuilder: (context, index) {
                          var menuKey = GlobalKey();
                          return Row(
                            children: [
                              Container(
                                  width: 40,
                                  height: 40,
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle),
                                  child: Image.asset(
                                    (data[index].acType == 1
                                        ? icReport_1
                                        : icReport_2),
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
                                      .color(Colors.black)
                                      .fontFamily(sansBold)
                                      .make(),
                                  3.heightBox,
                                  formatCurrency(data[index].acMoney)
                                      .text
                                      .size(14)
                                      .fontFamily(sansBold)
                                      .color(Colors.black45)
                                      .make(),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                key: menuKey,
                                onPressed: () {
                                  final RenderBox overlay = Overlay.of(context)
                                      .context
                                      .findRenderObject() as RenderBox;
                                  final RenderBox button =
                                      menuKey.currentContext!.findRenderObject()
                                          as RenderBox;
                                  final position = button.localToGlobal(
                                      Offset.zero,
                                      ancestor: overlay);
                                  showMenu(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    position: RelativeRect.fromLTRB(position.dx,
                                        position.dy + button.size.height, 0, 0),
                                    items: [
                                      const PopupMenuItem(
                                        value: 1,
                                        child: Text("Sửa Tài Khoản",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: sansBold,
                                                color: Colors.black)),
                                      ),
                                      const PopupMenuItem(
                                        value: 2,
                                        child: Text("Xóa Tài Khoản",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: sansBold,
                                                color: Colors.black)),
                                      ),
                                    ],
                                    elevation: 8,
                                  ).then((value) {
                                    if (value == 1) {
                                      Get.to(
                                          () => AccountUpdate(
                                              accountModel: data[index]),
                                          transition: Transition.rightToLeft);
                                    } else if (value == 2) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => ExitDialog(
                                                accountId:
                                                    data[index].accountId!,
                                              ));
                                    }
                                  });
                                },
                                icon: const Icon(
                                  Icons.more_vert,
                                  size: 25,
                                  color: Colors.black45,
                                ),
                              )
                            ],
                          )
                              .box
                              .padding(const EdgeInsets.symmetric(vertical: 5))
                              .margin(const EdgeInsets.symmetric(vertical: 5))
                              .make()
                              .onTap(() {});
                        },
                      )
                    ],
                  ),
                ),
              ],
            ));
          } else {
            return Container(
              color: const Color.fromARGB(255, 63, 52, 18),
            );
          }
        },
      ),
    );
  }
}
