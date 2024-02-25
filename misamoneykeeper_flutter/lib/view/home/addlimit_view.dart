
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class AddLimitView extends StatelessWidget {
  TextEditingController _namelimitController = TextEditingController();
  TextEditingController _limitController = TextEditingController();
  TextEditingController _startDate = TextEditingController();
  TextEditingController _endDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          },
              icon: Icon(Icons.arrow_back)),
          title: Text("Thêm Hạn Mức", style: TextStyle(
              fontSize: 18,
              color: Colors.white
          ),),
          centerTitle: true,
          actions: [
            Icon(Icons.more_vert)
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             const   SizedBox(height: 30,),
                Container(
                  height: 350,
                  width: 350,
                    color: Colors.white,
                  child: Column(
                    children: [
                      TextField(
                        controller: _namelimitController,
                        decoration: InputDecoration(
                          labelText: 'Tên hạn mức',
                            prefixIcon: Icon(Icons.book_rounded),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            )
                        ),
                      ),
                  const  SizedBox(height: 15.0),
                      TextField(
                        controller: _limitController,
                        decoration: InputDecoration(
                          labelText: 'Số tiền',
                            prefixIcon: Icon(Icons.monetization_on_rounded),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            )
                        ),
                      ),

                      SizedBox(height: 15.0),
                      TextField(
                        controller: _startDate,
                        decoration: InputDecoration(
                            labelText: 'Ngày bắt đầu',
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
                              initialDate: DateTime.now() ,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100));
                          if(pickeddate != null)
                            {
                              _startDate.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                            }
                        },
                      ),
                      SizedBox(height: 15.0),
                      TextField(
                        controller: _endDate,
                        decoration: InputDecoration(
                            labelText: 'Ngày kết thúc',
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
                            _endDate.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                          }
                        },
                      ),
                    ],
                  ),
                ),

                Container(
                    width: 300,
              child:
              ElevatedButton(onPressed: () {
              },
                child: Text('LƯU'),)
                ),
              ],
            ),
          ),
        ),
      );
  }


}