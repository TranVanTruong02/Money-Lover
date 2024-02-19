from rest_framework import serializers  
from django.contrib.auth import get_user_model
from .models import Account

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = get_user_model()  # Sử dụng get_user_model() để lấy model User chính xác
        fields = '__all__'
        extra_kwargs = {'password': {'write_only': True}}

class UserViewSerializer(serializers.ModelSerializer):
    class Meta:
        model = get_user_model()  # Sử dụng get_user_model() để lấy model User chính xác
        fields = ('id', 'first_name', 'last_name', 'type', 'email', 'mobile', 'mobile_code', 'access_token', 'refresh_token', 'access_token_expiration', 'refresh_token_expiration', 'reset_code', 'number_coins')

class UserLoginSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True)
    password = serializers.CharField(required=True)

class AccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = '__all__'


# class UserSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = User
#         fields = (
#             'user_id',
#             'u_first_name',
#             'u_last_name',
#             'u_type',
#             'u_email',
#             'u_mobile',
#             'u_password',
#             'u_auth_token',
#             'u_device_token',
#             'u_reset_code',
#             'u_number_coins',
#             'u_status',
#             'u_created_date',
#             'u_modify_date',
#         )
#         extra_kwargs = {
#             'password': {'write_only': True},
#             'auth_token': {'read_only': True},
#         }

#     def validate_email(self, value):
#         # Thêm các quy tắc xác thực email nếu cần thiết
#         return value

#     def create(self, validated_data):
#         user = Users.objects.create_user(**validated_data)
#         return user

        
# class UserDetailsSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = UserDetails
#         fields = '__all__'

#     # Chỉ cho phép tối đa 1000 ký tự
#     # body = serializers.CharField(max_length=1000)

#     # def validate_body(self, value):

#     #     # Đảm bảo body không chứa từ ngữ không phù hợp
#     #     inappropriate_words = ['dcm', 'con chó này']
#     #     for word in inappropriate_words:
#     #         if word in value:
#     #             raise serializers.ValidationError("Chứa nội dung không phù hợp.")
#     #     return value

# # class UserDetailsSerializer(serializers.ModelSerializer):
# #     # Chỉ cho phép tối đa 1000 ký tự
# #     body = serializers.CharField(max_length=1000)

# #     class Meta:
# #         model = UserDetails
# #         fields = '__all__'

# # #     def validate_body(self, value):

# # #         # Đảm bảo body không chứa từ ngữ không phù hợp
# # #         inappropriate_words = ['dcm', 'con chó này']
# # #         for word in inappropriate_words:
# # #             if word in value:
# # #                 raise serializers.ValidationError("Body contains inappropriate content")
# # #         return value

# # #     def validate(self, data):

# # #         # Đảm bảo body không trùng lặp trong cùng một User
# # #         user = data.get('user')
# # #         body = data.get('body')

# # #         if user and body:
# # #             existing_user_details = UserDetails.objects.filter(user=user, body=body)
# # #             if existing_user_details.exists():
# # #                 raise serializers.ValidationError("User details with the same body already exist")
# # #         return data

# # #     def create(self, validated_data):

# # #         # Tạo đối tượng mới và lưu nó vào cơ sở dữ liệu.
# # #         user_details = UserDetails.objects.create(**validated_data)
# # #         return user_details

# # #     def update(self, instance, validated_data):
# # #         # Thực hiện logic tùy chỉnh trước khi cập nhật UserDetails

# # #         for key, value in validated_data.items():
# # #             setattr(instance, key, value)
# # #         instance.save()

# # #         # Thực hiện các hoạt động tùy chỉnh khác sau khi cập nhật UserDetails

# # #         return instance

# # # class UserSerializer(serializers.ModelSerializer):
# # #     # Yêu cầu định dạng email
# # #     username = serializers.EmailField()

# # #     # Ẩn giá trị khi trả về Response
# # #     password = serializers.CharField(write_only=True)

# # #     class Meta:
# # #         model = User
# # #         fields = ['id', 'username', 'password']

# # #     def validate_username(self, value):
# # #         # Kiểm tra logic tùy chỉnh cho trường username
# # #         # Ví dụ: Đảm bảo username không trùng lặp trong cơ sở dữ liệu
# # #         existing_users = User.objects.filter(username=value)
# # #         if self.instance:
# # #             existing_users = existing_users.exclude(pk=self.instance.pk)
# # #         if existing_users.exists():
# # #             raise serializers.ValidationError("Username already exists")
# # #         return value

# # #     def create(self, validated_data):
# # #         # Thực hiện logic tùy chỉnh trước khi tạo User mới

# # #         password = validated_data.pop('password')
# # #         user = User.objects.create(**validated_data)
# # #         user.set_password(password)
# # #         user.save()

# # #         # Thực hiện các hoạt động tùy chỉnh khác sau khi tạo User mới

# # #         return user

# # #     def update(self, instance, validated_data):
# # #         # Thực hiện logic tùy chỉnh trước khi cập nhật User

# # #         for key, value in validated_data.items():
# # #             if key == 'password':
# # #                 instance.set_password(value)
# # #             else:
# # #                 setattr(instance, key, value)
# # #         instance.save()

# # #         # Thực hiện các hoạt động tùy chỉnh khác sau khi cập nhật User

# # #         return instance
    

# # #     from rest_framework import serializers

# # # class UserSerializer(serializers.ModelSerializer):
# # #     class Meta:
# # #         model = User
# # #         fields = '__all__'
    
# # #     def validate_u_email(self, value):
# # #         # Kiểm tra tính hợp lệ của địa chỉ email
# # #         # Ví dụ: Đảm bảo địa chỉ email là duy nhất trong hệ thống
# # #         if User.objects.filter(u_email=value).exists():
# # #             raise serializers.ValidationError("Địa chỉ email đã tồn tại.")
# # #         return value
    
# # #     def validate_u_mobile(self, value):
# # #         # Kiểm tra tính hợp lệ của số điện thoại di động
# # #         # Ví dụ: Đảm bảo số điện thoại di động là duy nhất trong hệ thống
# # #         if User.objects.filter(u_mobile=value).exists():
# # #             raise serializers.ValidationError("Số điện thoại đã tồn tại.")
# # #         return value
    
# # #     def validate(self, data):
# # #         # Kiểm tra tính hợp lệ của dữ liệu trong toàn bộ Serializer
# # #         # Ví dụ: Kiểm tra xem tên đăng nhập và mật khẩu có hợp lệ không
# # #         u_mobile = data.get('u_mobile')
# # #         u_password = data.get('u_password')
        
# # #         if u_mobile and u_password:
# # #             # Thực hiện kiểm tra đăng nhập tại đây
# # #             # Ví dụ: Kiểm tra xem tên đăng nhập và mật khẩu có khớp không
# # #             if not authenticate(u_mobile, u_password):
# # #                 raise serializers.ValidationError("Số điện thoại hoặc mật khẩu không hợp lệ.")
        
# # #         return data
    
# # # Mục Đích:
    
# # # Chuyển đổi đối tượng thành dữ liệu: đối tượng Python -> JSON 
# # # Chuyển đổi dữ liệu thành đối tượng: JSON -> đối tượng Python
# # # Xác thực và kiểm tra dữ liệu: Serializer cho phép bạn xác thực và kiểm tra dữ liệu được gửi từ yêu cầu.
