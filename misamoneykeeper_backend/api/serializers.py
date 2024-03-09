from rest_framework import serializers  
from django.contrib.auth import get_user_model
from .models import UserDetails, Account, Category, CategoryDetails, Pay

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = get_user_model()  # Sử dụng get_user_model() để lấy model User chính xác
        fields = '__all__'
        extra_kwargs = {'password': {'write_only': True}}

class UserViewSerializer(serializers.ModelSerializer):
    class Meta:
        model = get_user_model()  # Sử dụng get_user_model() để lấy model User chính xác
        fields = ('id', 'first_name', 'last_name', 'type', 'email', 'mobile', 'mobile_code', 'access_token', 'refresh_token', 'access_token_expiration', 'refresh_token_expiration', 'reset_code',)

class UserLoginSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True)
    password = serializers.CharField(required=True)

class UserDetailsSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserDetails
        fields = '__all__'

class AccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ('account_id', 'user_id', 'ac_name', 'ac_money', 'ac_type', 'ac_explanation', 'ac_status', 'ac_modify_date')

#  Thêm dữ liệu cho Bảng Pay
class PayAddSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pay
        fields = ('user_id', 'category_details_id', 'account_id', 'p_type', 'p_money', 'p_explanation', 'p_date',)

class PayViewSerializer(serializers.ModelSerializer):
    class Meta:
        model = Pay
        fields = ('pay_id', 'user_id', 'category_details_id', 'account_id', 'p_type', 'p_money', 'p_explanation', 'p_date', 'p_status', 'p_modify_date',)

# API Điều chỉnh số dư
class BalanceAdjustmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ('account_id', 'user_id', 'ac_money',)

# API Hạng mục
class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ('category_id', 'ca_name', 'ca_image', 'ca_explanation',)

class CategoryDetailsSerializer(serializers.ModelSerializer):
    class Meta:
        model = CategoryDetails
        fields = ('category_details_id', 'category_id', 'cad_type', 'cad_name', 'cad_image', 'cad_explanation',)
#  API Lịch sử ghi chép
class PayHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Pay
        fields = ('pay_id', 'category_details_id', 'p_type', 'p_money', 'p_date',)

# API Sửa lại tài khoản (ví)
class AccountUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ('account_id', 'user_id', 'ac_name', 'ac_money', 'ac_type', 'ac_explanation')



    
# # # Mục Đích:
    
# # # Chuyển đổi đối tượng thành dữ liệu: đối tượng Python -> JSON 
# # # Chuyển đổi dữ liệu thành đối tượng: JSON -> đối tượng Python
# # # Xác thực và kiểm tra dữ liệu: Serializer cho phép bạn xác thực và kiểm tra dữ liệu được gửi từ yêu cầu.
