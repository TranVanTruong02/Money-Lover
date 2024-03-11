import 'package:misamoneykeeper_flutter/controller/sign_up_view_model.dart';
import 'package:misamoneykeeper_flutter/utility/export.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final authVM = Get.put(SignUpVM());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(20), // Đặt bán kính bo góc ở đây
                child: Image.asset(
                  icLogo,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              10.heightBox,
              const Text(
                'Sổ Thu Chi MISA',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 15),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: authVM.txtTenDem.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập họ và tên đệm';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Họ và tên đệm',
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: authVM.txtTen.value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập tên';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Tên',
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: const BorderSide(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: authVM.txtEmail.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: authVM.txtSDT.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số điện thoại';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Số điện thoại',
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: authVM.txtPassword.value,
                      obscureText: !authVM.isShowPasswordLogin.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Mật khẩu',
                        suffixIcon: IconButton(
                          onPressed: () {
                            authVM.showPassword();
                          },
                          icon: Icon(!authVM.isShowPasswordLogin.value
                              ? Icons.visibility_off
                              : Icons.visibility),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: const BorderSide(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    RichText(
                      text: const TextSpan(
                        text:
                            'Bằng cách bấn vào nút đăng ký, bạn đã đồng ký với',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        children: [
                          TextSpan(
                            text: ' thoả thuận sử dụng',
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(
                            text: ' và ',
                          ),
                          TextSpan(
                            text: 'Chính sách quyền riêng tư',
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(
                            text: ' của MISA ',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //     content: Text('ddd'),
                                //   ),
                                // );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              splashFactory: NoSplash.splashFactory,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                            ).copyWith(
                              elevation: const MaterialStatePropertyAll(0),
                            ),
                            child: Text(
                              'Đăng Ký'.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: const TextSpan(
                        text: 'Bạn đã có tài khoản? ',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Đăng nhập ngay',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            endIndent: 15,
                            thickness: 0.7,
                          ),
                        ),
                        Text('Hoặc đăng nhập bằng'),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            indent: 15,
                            thickness: 0.7,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          imgFacebook,
                          height: 35,
                          width: 35,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Image.asset(
                          imgGoogle,
                          height: 35,
                          width: 35,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
