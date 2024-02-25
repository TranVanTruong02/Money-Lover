import 'package:flutter/material.dart';

class changePasswordView extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
   return 
   Scaffold(
    appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          leading: IconButton(onPressed: () {
          },
              icon: const Icon(Icons.arrow_back)),
          title: const Text("Đổi Mật Khẩu", style: TextStyle(
              fontSize: 18,
              color: Colors.white
          ),),
          centerTitle: true,
        ),
      body:  SingleChildScrollView(
        child:  Column(
          children: [
          const SizedBox(height: 10),
          const  TextField(
                        
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu cũ',
                            prefixIcon: Icon(Icons.lock),
                        ),
                      ),
          const  SizedBox(height: 10),
          const  TextField(
                        
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu mới',
                            prefixIcon: Icon(Icons.lock),
                        ),
                      ),
          const  SizedBox(height: 10),
          const  TextField(
                        
                        decoration: InputDecoration(
                          labelText: 'Xác nhận mật khẩu',
                            prefixIcon: Icon(Icons.lock),
                        ),
                      ),
             SizedBox(height: 10),

           
             Container(
                    width: 300,
                    child:
                    ElevatedButton(onPressed: () {
                    },
                      child: Text('LƯU'),)
                ),
            

          

          ]
          ) ,
        )
   );
  }
  
}