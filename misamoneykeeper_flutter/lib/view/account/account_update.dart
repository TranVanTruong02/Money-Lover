import 'package:misamoneykeeper_flutter/controller/account_update_view_model.dart';
import 'package:misamoneykeeper_flutter/model/account_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class AccountUpdate extends StatefulWidget {
  final AccountModel accountModel;
  const AccountUpdate({super.key, required this.accountModel});

  @override
  State<AccountUpdate> createState() => _AccountUpdateState();
}

class _AccountUpdateState extends State<AccountUpdate> {
  late AccountUpdateViewModel accountUpdateVM;
  @override
  void initState() {
    super.initState();
    accountUpdateVM =
        Get.put(AccountUpdateViewModel(widget.accountModel.accountId!));
    accountUpdateVM.balanceController.value.text =
        widget.accountModel.acMoney!.toString();
    accountUpdateVM.nameController.value.text = widget.accountModel.acName!;
    if (widget.accountModel.acType == 1) {
      accountUpdateVM.accountType.value = "Tiền mặt";
    } else {
      accountUpdateVM.accountType.value = "Ngân hàng";
    }
    accountUpdateVM.descriptionController.value.text =
        widget.accountModel.acExplanation!;
  }

  final List<String> _accountTypes = ['Tiền mặt', 'Ngân hàng'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sửa tài khoản',
            style: TextStyle(
              color: Colors.white,
              // Đặt màu chữ thành màu trắng
            ),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.close, // Icon dấu X
              color: Colors.white, // Đặt màu của icon thành màu trắng
            ),
            onPressed: () {
              Navigator.pop(context); // Đóng trang khi nhấn nút dấu X
            },
          ),
        ),
        body: Obx(
          () => accountUpdateVM.isLoading.value == true
              ? Center(child: loadingIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Card(
                        child: TextField(
                          controller: accountUpdateVM.balanceController.value,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            labelText: 'Số dư ban đầu',
                            prefixIcon: Icon(Icons.attach_money),
                          ),
                        ),
                      ),
                      Card(
                        child: TextField(
                          controller: accountUpdateVM.nameController.value,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            labelText: 'Tên tài khoản',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      Obx(
                        () => DropdownButton(
                          value: accountUpdateVM.accountType.value,
                          isExpanded: true,
                          underline: const SizedBox(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          items: _accountTypes.map((accountType) {
                            return DropdownMenuItem(
                              value: accountType,
                              child: Row(
                                children: [
                                  if (accountType == 'Tiền mặt')
                                    const Icon(Icons.account_balance_wallet)
                                  else if (accountType == 'Ngân hàng')
                                    const Icon(Icons.account_balance),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(accountType),
                                ],
                              ),
                            );
                          }).toList(),
                          // Xóa đối số vị trí thừa
                          onChanged: (newValue) {
                            accountUpdateVM.accountType.value =
                                newValue ?? 'Tiền mặt';
                            if (newValue == 'Tiền mặt') {
                              accountUpdateVM.accountTypeId.value = 1;
                            } else {
                              accountUpdateVM.accountTypeId.value = 2;
                            }
                          },
                        ),
                      ),
                      Card(
                        child: TextFormField(
                          controller:
                              accountUpdateVM.descriptionController.value,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            labelText: 'Diễn giải',
                            prefixIcon: Icon(Icons.sort),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Màu xanh
                              minimumSize: const Size(
                                  200.0, 50.0), // Chiều dài và chiều cao
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                            ),
                            onPressed: () {
                              accountUpdateVM.serviceCallAccountUpdate();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.save,
                                  color: Colors.white,
                                ),
                                Text('Lưu',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
        ));
  }
}
