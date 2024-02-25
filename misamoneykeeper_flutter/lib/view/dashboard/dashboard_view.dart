import 'package:flutter/material.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}
String dropbuttonvalue = 'Hôm nay';
class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container (
              height: 250,
              color: Colors.blue,
              child: Stack(
                children: [
                  Column(
                    children: [
                      60.heightBox,
                    Row(
                      children: [
                        20.widthBox,
                        Text(
                        'Xin chào, Tùng',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      ],
                    ),
                    30.heightBox,
                    Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Tổng Số Dư : ',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black
                                ),
                              ),
                              Text(' 0 VND ',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.indigo,
                                ),
                              )
                            ],
                          ),
                            
                          SizedBox(width: 150),
                          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward))
                        ],
                      ),
                    ),
                    ],
                  ),
                  
                  
                  
        
                ],
              ),
            ),
            // phần tiếp
            const SizedBox(height: 12.0),
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                border: const Border(
                  top: BorderSide(color: Colors.black12),
                  bottom: BorderSide(color: Colors.black12),
                ),
              ),
              padding: EdgeInsets.all(12.0),
              //   color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tình hình thu chi',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 12.0),
                  Container(
                    width: 120,
                    child: DropdownButton (
                      hint: Text('Hôm nay'),
                      items: [
                        DropdownMenuItem(
                          child: Text('Hôm nay'),
                          value: 'Hôm nay',
                        ),
                        DropdownMenuItem(
                          child: Text('Tuần này'),
                          value: 'Tuần nay',
                        ),
                        DropdownMenuItem(
                          child: Text('Tháng này'),
                          value: 'Tháng này',
                        ),
                      ],
                      value: dropbuttonvalue,
                      onChanged: (String? value) {
                        setState(() {
                          dropbuttonvalue = value!;
                        });
                        // Xử lý sự kiện khi người dùng chọn một giá trị mới
                      },
                    ),
                  ),
        
                  SizedBox(height: 35.0),
                    Align(
                      alignment: Alignment.center,
                      child:
                      Text(
                        'Không có dữ liệu',
                        style: TextStyle(fontSize: 14.0, color: Colors.black12),
                      ),
                    ),
        
                  SizedBox(height: 35.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child:
                    TextButton(
                      onPressed: () {
                        // Xử lý khi người dùng nhấp vào "Thêm hạn mức"
                      },
                      child: Text('Lịch sử ghi chú >'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.0,),
            Container(decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.black12),
                bottom: BorderSide(color: Colors.black12),
              ),
            ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
        
                  Text(
                    'Thêm hạn mức',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 24.0),
                  Align(
                    alignment: Alignment.center,
                    child:  Text(
                      'Cùng sổ thu chi MISA lập ra các hạn mức',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child:
                    Text(
                      'chi để quản lý chi tiêu tốt hơn nhé!',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  TextButton(
                    onPressed: () {
                      // Xử lý khi người dùng nhấp vào "Thêm hạn mức"
                    },
                    child: Text('+ Thêm hạn mức'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.black12),
                  bottom: BorderSide(color: Colors.black12),
                ),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Du lịch',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 24.0),
                  Align(
                    alignment: Alignment.center,
                    child:  Text(
                      'Hãy tạo chuyến đi để theo dõi cùng sổ thu',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child:
                    Text(
                      'chi Misa',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  TextButton(
                    onPressed: () {
                      
                      // Xử lý khi người dùng nhấp vào "Thêm hạn mức"
                    },
                    child: Text('+ Thêm mới'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0,),
          ],
        ),
      );
  }
}