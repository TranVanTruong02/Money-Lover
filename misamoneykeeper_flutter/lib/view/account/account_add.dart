import 'package:misamoneykeeper_flutter/controller/account_add_view_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class AccountAdd extends StatefulWidget {
  const AccountAdd({super.key});

  @override
  State<AccountAdd> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AccountAdd> {
  final List<String> _accountTypes = ['Tiền mặt', 'Ngân hàng'];
  var accountAddVM = Get.put(AccountAddViewModel());
  @override
  void initState() {
    super.initState();
    accountAddVM.clean();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Thêm tài khoản',
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
          () => accountAddVM.isLoading.value == true
              ? Center(child: loadingIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Card(
                        child: TextField(
                          controller: accountAddVM.balanceController.value,
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
                          controller: accountAddVM.nameController.value,
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
                          value: accountAddVM.accountType.value,
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
                            accountAddVM.accountType.value =
                                newValue ?? 'Tiền mặt';
                            if (newValue == 'Tiền mặt') {
                              accountAddVM.accountTypeId.value = 1;
                            } else {
                              accountAddVM.accountTypeId.value = 2;
                            }
                          },
                        ),
                      ),
                      Card(
                        child: TextFormField(
                          controller: accountAddVM.descriptionController.value,
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
                              accountAddVM.serviceCallCategory();
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