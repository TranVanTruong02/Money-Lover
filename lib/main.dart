
import 'package:flutter/material.dart';

void main() {
  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}



class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

        Container (
        height: 250,
        color: Colors.blue,
        child: Stack(
          children: [
            Positioned(
              top: 70,
              left: 20,
              child: Text(
                'Xin chào, Tùng',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 30,
              right: 30,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
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
            ),

          ],
        ),
      ),
            // phần tiếp
            Container(
              height: 250,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.black12),
                  bottom: BorderSide(color: Colors.black12),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 15,
                    child: Text(
                      'Tình hình thu chi',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 25,
                    left: 20,
                      child:
                       DropdownButton(
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
                          value: 'Hôm nay',
                          onChanged: (value) {
                            // Xử lý sự kiện khi người dùng chọn một giá trị mới
                          },
                        ),
                      ),
                  Positioned(
                    top: 125,
                      left: 125,
                      child:
                  Text('Không có dữ liệu',
                    style: TextStyle(
                    color: Colors.black12,
                      fontSize: 18
                  ),
                  )

                  ),
                  Positioned(
                    top: 220,
                      left: 250,
                      child: Text(
                        'Lịch sử ghi chú >',
                        style:
                        TextStyle(
                          color: Colors.blue,
                          fontSize: 18
                        )
                      ),
                  )
                ],
              ),
            ),
            //phần tiếp
            Container(
              height: 200,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.black12),
                  bottom: BorderSide(color: Colors.black12),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 15,
                    child: Text(
                      'Hạn mức chi',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 75,
                    left: 75,
                    child: Text(
                      'Cùng sổ thu chi MISA lập ra các hạn mức ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 95,
                    left: 95,
                    child: Text(
                      'chi để quản lý chi tiêu tốt hơn nhé!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: 120,
                    child: Text(
                      '+ Thêm hạn mức chi',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
       // phần tiếp

            Container(
              height: 200,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.black12),
                  bottom: BorderSide(color: Colors.black12),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 15,
                    child: Text(
                      'Du lịch',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 75,
                    left: 75,
                    child: Text(
                      'Hãy tạo chuyến đi để theo dõi cùng sổ thu',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 95,
                    left: 180,
                    child: Text(
                      'chi Misa',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: 140,
                    child: Text(
                      '+ Thêm hạn mới',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),

      ],
      )
      ),
      bottomNavigationBar: BottomNavigationBar(

        items: [
           BottomNavigationBarItem(
             icon: Icon(Icons.home),
             label: 'Tổng Quan',
             backgroundColor: Colors.blue,
           ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Tài khoản',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'T',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.report),
              label: 'Báo Cáo',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'Khác',
            backgroundColor: Colors.blue,
          )
        ],



      ),
    );
  }
}










