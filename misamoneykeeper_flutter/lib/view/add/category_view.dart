import 'package:misamoneykeeper_flutter/common/report_cell.dart';
import 'package:misamoneykeeper_flutter/controller/splash_view_model.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';
import 'package:misamoneykeeper_flutter/view/report/report_details.dart';
import 'package:misamoneykeeper_flutter/common/category_cell.dart';


class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  // final splashVM = Get.find<SplashViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0.5,
        centerTitle: true,
        title: "Chọn Hạng Mục".text.white.size(20).fontFamily(sansSemibold).make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
      child: Container(
        color: Color.fromARGB(255, 178, 178, 178),
       
        child: Column(children: [
          Row(
            children: [
              Image.asset(
            imgAnuong
            ,
            width: 30,
            height: 30,
          ),
          10.widthBox,
          "Ăn Uống".text
              .size(16)
              .fontFamily(sansBold)
              .color(Colors.black87)
              .make()
            ],
          ),
          SizedBox(height: 20,),
          GridView.builder(
          shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.6),
            itemCount: textListCategory1.length,
            itemBuilder: ((context, index) {
              return ReportCell(
                  icon: iconListCategory1[index],
                  title: textListCategory1[index],
                  onPressed: () {
                    switch (index) {
                      case 0:
                       
                      case 7:
                        // splashVM.logout();
                    }
                  });
            })),
        ]),
      ),
      )
    );
  }
}
