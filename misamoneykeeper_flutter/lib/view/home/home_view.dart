import 'package:flutter/material.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/dashboard/dashboard_view.dart';
import 'package:misamoneykeeper_flutter/view/report/report_view.dart';
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    DashboardPage(),
    AccountPage(),
    const ReportView(),
    MorePage(),
    Add(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              IconButton(
                icon:
                Icon(Icons.home), onPressed: () {
          _onItemTapped(0);
        },
        ),

              SizedBox(width: 10),

              IconButton(
                icon: Icon(Icons.account_balance_wallet),
                onPressed: () {
                  _onItemTapped(1);
                },
              ),



              SizedBox(width: 10),

              IconButton(
                icon: Icon(Icons.bar_chart),
                onPressed: () {
                  _onItemTapped(2);
                },
              ),

              SizedBox(width: 10),

              IconButton(
                icon: Icon(Icons.dashboard),
                onPressed: () {
                  _onItemTapped(3);

                },
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                
                    )
                  ),
                  child: const Text(
                    "hihi",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: sansRegular
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {  _onItemTapped(4); },
        child: Icon(Icons.add),
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Text(
        'Account',
        style: TextStyle(fontSize: 24),
    );
  }
}

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
       Text(
        'More',
        style: TextStyle(fontSize: 24),
    );
  }
}

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Text(
        'Add',
        style: TextStyle(fontSize: 24),
      );
  }
}