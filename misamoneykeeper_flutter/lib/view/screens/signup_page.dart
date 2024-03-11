import 'package:misamoneykeeper_flutter/utility/export.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _controller = TextEditingController();
  bool _obscureText = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _obscureText = !_obscureText;
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
              Image.asset(
                'assets/images/save-money.png',
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 10),
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
                      obscureText: !_obscureText,
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
                            setState(
                              () {
                                _obscureText = !_obscureText;
                              },
                            );
                          },
                          icon: Icon(_obscureText
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
