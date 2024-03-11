import 'package:date_format/date_format.dart';
import 'package:flutter/services.dart';
import 'package:misamoneykeeper_flutter/controller/pay_collect_view_model.dart';
import 'package:misamoneykeeper_flutter/server/loading_indicator.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/add/category_collect.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as datatTimePicker;
import 'package:misamoneykeeper_flutter/view/add/pay_account_details.dart';

class PayCollect extends StatefulWidget {
  final bool? isCheck;
  final String? categoryIcon;
  final String? categoryTitle;
  final int? categoryDetailsId;
  final int? accountIcon;
  final String? accountTitle;
  final int? accountId;
  final String? dateController;
  final String? moneyAccount;
  final String? descriptionAccount;

  const PayCollect(
      {super.key,
      this.isCheck,
      this.categoryIcon,
      this.categoryTitle,
      this.categoryDetailsId,
      this.accountIcon,
      this.accountTitle,
      this.accountId,
      this.dateController,
      this.moneyAccount,
      this.descriptionAccount});

  @override
  State<PayCollect> createState() => _PayAccountState();
}

class _PayAccountState extends State<PayCollect> {
  FocusNode dateFocusNode = FocusNode();
  final payVM = Get.put(PayCollectViewModel());

  @override
  void initState() {
    super.initState();
    if (widget.isCheck == null) {
      payVM.clean();
    } else {
      widget.categoryIcon != null
          ? payVM.categoryIcon.value = widget.categoryIcon!
          : payVM.categoryIcon.value = '';
      widget.categoryTitle != null
          ? payVM.categoryTitle.value = widget.categoryTitle!
          : payVM.categoryTitle.value = '';
      widget.categoryDetailsId != null
          ? payVM.categoryDetailsId.value = widget.categoryDetailsId!
          : payVM.categoryDetailsId.value = 0;
      widget.accountIcon != null
          ? payVM.accountIcon.value = widget.accountIcon!
          : payVM.accountIcon.value = 0;
      widget.accountTitle != null
          ? payVM.accountTitle.value = widget.accountTitle!
          : payVM.accountTitle.value = '';
      widget.accountId != null
          ? payVM.accountId.value = widget.accountId!
          : payVM.accountId.value = 0;
      widget.dateController != null
          ? payVM.dateController.value.text = widget.dateController!
          : payVM.dateController.value.text = '';
      widget.moneyAccount != null
          ? payVM.moneyAccount.value.text = widget.moneyAccount!
          : payVM.moneyAccount.value.text = '';
      widget.descriptionAccount != null
          ? payVM.descriptionAccount.value.text = widget.descriptionAccount!
          : payVM.descriptionAccount.value.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => payVM.isLoading.value == true
            ? Center(
                child: loadingIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextField(
                      controller: payVM.moneyAccount.value,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontFamily: sansRegular),
                      decoration: const InputDecoration(
                        labelText: 'Số Tiền',
                        prefixIcon: Icon(Icons.money),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () async {
                          Get.to(() => const CategoryCollect(),
                              transition: Transition.rightToLeft);
                        },
                        child: Row(
                          children: [
                            payVM.categoryIcon.value == ''
                                ? Image.asset(
                                    imgHelp,
                                    width: 25,
                                    height: 25,
                                  )
                                : Image.network(
                                    payVM.categoryIcon.value,
                                    width: 25,
                                    height: 25,
                                  ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              payVM.categoryTitle.value == ''
                                  ? "Chọn hạng mục"
                                  : payVM.categoryTitle.value,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Spacer(),
                            const Icon(Icons.navigate_next)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: payVM.dateController.value,
                      focusNode: dateFocusNode,
                      keyboardType: TextInputType.none,
                      decoration: const InputDecoration(
                          labelText: 'Ngày thực hiện',
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                          ),
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          )),
                      //  readOnly: true,
                      onTap: () {
                        datatTimePicker.DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(1900, 1, 1),
                          maxTime: DateTime.now(),
                          theme: const datatTimePicker.DatePickerTheme(
                            containerHeight: 150.0,
                          ),
                          onConfirm: (date) {
                            if (dateFocusNode.hasFocus) {
                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                          },
                          onChanged: (date) {
                            var formatData =
                                formatDate(date, [yyyy, '-', mm, '-', dd]);
                            payVM.dateController.value.text = formatData;
                            FocusScope.of(context).unfocus();
                          },
                          currentTime: DateTime.now(),
                          locale: datatTimePicker.LocaleType.vi,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Chọn tài khoản
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () async {
                          Get.to(() => const PayAccountDetails(type: 2),
                              transition: Transition.rightToLeft);
                        },
                        child: Row(
                          children: [
                            payVM.accountIcon.value == 0
                                ? const Icon(
                                    Icons.account_balance_wallet,
                                    size: 25,
                                    color: Colors.black,
                                  )
                                : payVM.accountIcon.value == 1
                                    ? const Icon(
                                        Icons.account_balance_wallet,
                                        size: 25,
                                        color: Colors.black,
                                      )
                                    : const Icon(
                                        Icons.account_balance,
                                        size: 25,
                                        color: Colors.black,
                                      ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              payVM.accountTitle.value == ''
                                  ? "Chọn tài khoản"
                                  : payVM.accountTitle.value,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Spacer(),
                            const Icon(Icons.navigate_next)
                          ],
                        ),
                      ),
                    ),
                    10.heightBox,
                    TextFormField(
                      controller: payVM.descriptionAccount.value,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        labelText: 'Diễn giải',
                        prefixIcon: Icon(Icons.sort),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        width: 400,
                        child: ElevatedButton(
                          onPressed: () {
                            payVM.serviceAddPay();
                          },
                          child: const Text('LƯU'),
                        )),
                  ],
                )),
              ),
      ),
    );
  }
}