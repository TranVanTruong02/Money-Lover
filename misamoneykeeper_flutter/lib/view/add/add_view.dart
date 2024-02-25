import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
class AddView extends StatefulWidget {
  @override
  AddViewState createState() => AddViewState();
}

class AddViewState extends State<AddView>
{  
  bool showTextField = false;
  TextEditingController _Date = TextEditingController();
  int position = 0;
  String pop = "Thêm chi tiết";
  


  void changePosition(int index) {
    setState(() {
      position = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          leading: IconButton(onPressed: () {
          },
              icon: const Icon(Icons.arrow_back)),
          title: InkWell(
            onTap: () {
              final left = context.screenWidth * 0.3;
              final top = context.screenHeight * 0.11;

              showMenu(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                context: context,
                position: RelativeRect.fromLTRB(left, top, left, 0.0),
                items: List.generate(
                  textListAdd.length,
                  (index) => PopupMenuItem(
                    value: index + 1,
                    child: Row(children: [
                      Image.asset(
                        iconListReport[index],
                        width: 15,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        textListAdd[index],
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.5),
                            fontFamily: sansRegular),
                      ),
                      index == position
                          ? Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.check_sharp,
                                  weight: 15,
                                  color: Colors.red.withOpacity(0.5),
                                )
                              ],
                            )
                          : const SizedBox.shrink()
                    ]),
                  ),
                ),
              ).then((value) {
                switch (value) {
                  case 1:
                    changePosition(0);
                    break;
                  case 2:
                    changePosition(1);
                    break;
                }
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                textListAdd[0]
                    .text
                    .size(18)
                    .fontFamily(sansBold)
                    .white
                    .make(),
                const SizedBox(width: 5),
                Image.asset(
                  icArrowDown,
                  width: 12,
                  color: Colors.white,
                ),
              ],
            )
                .box
                .height(35)
                .padding(const EdgeInsets.symmetric(horizontal: 15))
                .withDecoration(
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.3),
                  ),
                )
                .make(),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
             
            const SizedBox(height: 10),

            TextField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                        decoration: InputDecoration(
                          labelText: 'Số Tiền',
                            prefixIcon: Icon(Icons.money),
                        ),
                      ),
          const  SizedBox(height: 20,),
              Row(
                children: [
                  Icon(
                  Icons.help,
                  color: Colors.blue,
                  size: 18.0,
                  ),
                  SizedBox(width: 10,),
                  Text("Chọn Hạng Mục")
                ],
              ),
              SizedBox(height: 25,),
               TextField(
                        controller: _Date,
                        decoration: InputDecoration(
                            labelText: 'Ngày thực hiện',
                            //   filled: true,
                            prefixIcon: Icon(Icons.calendar_today),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            )
                        ),
                        //  readOnly: true,
                        onTap: () async{
                          DateTime? pickeddate = await showDatePicker(context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100));
                          if(pickeddate != null)
                          {
                            _Date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                          }
                        },
                      ),

                SizedBox(height: 15,),

              GestureDetector(
          onTap: () {
            setState(() {
              showTextField = !showTextField;
              showTextField ? pop = "Ẩn Thông Tin" : pop = "Thêm chi tiết";
            });
          },
          child: Text(
            '$pop',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue
            ),
          ),
        ),
        showTextField
            ? const Column(
              children: [
             SizedBox(height: 10,),
             TextField(
                        decoration: InputDecoration(
                          labelText: 'Sự kiện',
                            prefixIcon: Icon(Icons.apartment_sharp),
                        ),
                      ),
              SizedBox(height: 10,),
              TextField(
                        decoration: InputDecoration(
                          labelText: 'sử dụng vào việc ',
                            prefixIcon: Icon(Icons.account_circle_rounded),
                        ),
                      ),
              ]
            )
            : SizedBox(),

          SizedBox(height: 15,),
          Container(
                    width: 400,
                    child:
                    ElevatedButton(onPressed: () {
                    },
                      child: Text('LƯU'),)
                ),

            ],
            )
          ),
    );
  }
  
}