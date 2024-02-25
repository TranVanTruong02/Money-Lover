import 'package:flutter/material.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
class InformationView extends StatefulWidget {
  @override
  InformationViewState createState() => InformationViewState();
}

class InformationViewState extends State<InformationView>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(onPressed: () {
          }, 
              icon: Icon(Icons.arrow_back, color: Colors.black,)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),
               Image.asset(
                            imgUser,
                            height: 50,
                            width: 50,
                          ),
            const  SizedBox(height: 10),
              'tung alo'.text.make(),
            const  SizedBox(height: 10),
              'tung@gmai.com'.text.make(), // thêm email bên backend
              ElevatedButton(
              onPressed: () {
              },
                child: const Text('SỬA'),),

              SizedBox(height: 50),
              ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const Divider(color: Colors.black, height: 1,);
              }, 
              itemCount: textListinformation.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(textListinformation[index], 
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: sansRegular,
                    color: index != 1 ? Colors.black : Colors.red
                  ),),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    switch(index) {
                      case 0: 
                    }
                  },
                  
                );
              },
              )
            ],
          ),
        ),
      ),
    );
     
  }
  
}
