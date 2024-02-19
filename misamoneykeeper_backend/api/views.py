from django.contrib.auth import authenticate, get_user_model, login, logout
from django.contrib.auth.hashers import make_password
from django.http import JsonResponse
from django.utils import timezone
from datetime import datetime, timedelta
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from .serializers import UserSerializer, UserViewSerializer, UserLoginSerializer, AccountSerializer
from .models import Account
from rest_framework_simplejwt.tokens import RefreshToken
# Tạo nhóm và gán quyền cho người dùng

# Tạo User Admin
class UserRegisterAdmin(APIView):
    permission_classes = []
    def post(self, request):
        data=request.data

        email = data.get('email')

        if get_user_model().objects.filter(email=email).exists():
                return Response({
                    'error_message': 'Email này đã được đăng ký.',
                    'error_code': 400,
                }, status=status.HTTP_400_BAD_REQUEST)
        else:
            # Dự Liệu Mặc Định
            data['type'] = 2  
            data['is_superuser'] = True
            data['is_staff'] = True
            # data['groups'] = [1] 
        
            serializer = UserSerializer(data=data)

            if serializer.is_valid():
                # Mã hóa mật khẩu của người dùng
                serializer.validated_data['password'] = make_password(serializer.validated_data['password'])

                # Lưu trữ dữ liệu
                user = serializer.save()

                data = {
                    'status': 1,
                    'payload': UserViewSerializer(user).data,
                    'message': "Bạn đã đăng kí tài khoản admin thành công"
                }
                return Response(data, status=status.HTTP_201_CREATED)
            else:
                return JsonResponse({
                    'error_message': 'Dữ liệu không hợp lệ.',
                    'errors_code': 400,
                    'errors': serializer.errors
                }, status=status.HTTP_400_BAD_REQUEST)

# Tạo Người Dùng
class UserRegisterView(APIView):
    permission_classes = []
    def post(self, request):
        data=request.data

        email = data.get('email')

        if get_user_model().objects.filter(email=email).exists():
                return Response({
                    'error_message': 'Email này đã được đăng ký.',
                    'error_code': 400,
                }, status=status.HTTP_400_BAD_REQUEST)
        else:
            # Dự Liệu Mặc Định
            data['type'] = 1 
            data['is_superuser'] = False
            data['is_staff'] = False
            data['groups'] = [] 
            data['user_permissions'] = [] 
        
            serializer = UserSerializer(data=data)

            if serializer.is_valid():
                # Mã hóa mật khẩu của người dùng
                serializer.validated_data['password'] = make_password(serializer.validated_data['password'])

                # Lưu trữ dữ liệu
                user = serializer.save()

                data = {
                    'status': 1,
                    'payload': UserViewSerializer(user).data,
                    'message': "Bạn đã đăng kí thành công"
                }
                return Response(data, status=status.HTTP_201_CREATED)
            else:
                return JsonResponse({
                    'error_message': 'Dữ liệu không hợp lệ.',
                    'errors_code': 400,
                    'errors': serializer.errors
                }, status=status.HTTP_400_BAD_REQUEST)

class UserLoginView(APIView):
    # Bỏ qua yêu cầu xác thực token
    permission_classes = []
    def post(self, request):
        serializer = UserLoginSerializer(data=request.data)
        if serializer.is_valid():
            user = authenticate(
                request,
                username=serializer.validated_data['email'],
                password=serializer.validated_data['password']
            )
            if user is not None:
                login(request, user)
                refresh = TokenObtainPairSerializer().get_token(user)
                # Lưu access token vào bảng dữ liệu
                user.access_token = refresh.access_token
                user.refresh_token = refresh
                user.access_token_expiration = timezone.now() + timedelta(minutes=120)
                user.refresh_token_expiration = timezone.now() + timedelta(days=10)
                user.save()
                data = {
                    'status': 1,
                    'payload': UserViewSerializer(user).data,
                    'message': "Bạn đã đăng nhập thành công"
                }
                return Response(data, status=status.HTTP_200_OK)

            return Response({
                'error_message': 'Email hoặc mật khẩu không đúng!',
                'error_code': 400
            }, status=status.HTTP_400_BAD_REQUEST)

        return Response({
            'error_messages': serializer.errors,
            'error_code': 400
        }, status=status.HTTP_400_BAD_REQUEST)

# Đăng xuất
class UserLogoutView(APIView):
    def post(request):
        logout(request)
        data = {
            'status': 1,
            'message': "Bạn đã đăng xuất thành công"
        }
        return Response(data, status=status.HTTP_200_OK)
    
# Yêu cầu access token mới
class RefreshAccessToken(APIView):
    permission_classes = []

    def post(self, request):
        refresh_token = request.data.get('refresh_token')
        if refresh_token:
            try:
                refresh_token_instance = RefreshToken(refresh_token)
                access_token = refresh_token_instance.access_token
            except Exception as e:
                return Response({'error': 'Invalid refresh token'}, status=400)
            
            user = get_user_model().objects.get(refresh_token=refresh_token_instance)
            user.access_token = access_token
            user.access_token_expiration = timezone.now() + timedelta(minutes=120)
            user.save()
            data = {
                'status': 1,
                'payload': UserSerializer(user).data,
                'message': "Cập nhập access token thành công"
            }
            return Response(data, status=status.HTTP_200_OK)
            
        return Response({'error': 'refresh token không hợp lệ'}, status=400)

class AccountCreateView(APIView):
    def post(self, request):
        serializer = AccountSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class AccountView(APIView):
    def post(self, request):
        user_id = request.data.get('user_id')
        accounts = Account.objects.filter(user_id=user_id)
        serializer = AccountSerializer(accounts, many=True)
        data = {
            'status': 1,
            'payload': serializer.data
        }
        return Response(data)














# # from rest_framework import status
# from rest_framework.decorators import api_view
# from rest_framework.response import Response
# from django.contrib.auth import authenticate, login
# from .models import User

# # API Login
# @api_view(['POST'])
# def login(request):
#     email = request.data.get('u_email')
#     password = request.data.get('u_password')

#     user = authenticate(request, username=email, password=password)
#     if user is not None:
#         login(request, user)
#         return Response({'success': True})
#     else:
#         return Response({'success': False})
#     # if user is not None:
#     #     # Đăng nhập thành công
#     #     login(request, user)
#     #     # Tạo mã token mới
#     #     token = jwt.encode({'user_id': user.id}, settings.SECRET_KEY, algorithm='HS256')

#     #         # Lưu mã token vào người dùng
#     #         user.u_auth_token = token
#     #         user.save()
#     #     # Tạo mã Token
#     #     token, created = Token.objects.get_or_create(user=user)
#     #     if created:
#     #          user.u_auth_token = token
#     #          return Response({'token': token.key}, status=status.HTTP_200_OK)
#     #     else:
#     #         return Response({'message': 'Đã sảy ra lỗi.'}, status=status.HTTP_409_CONFLICT)
#     # return Response({'message': 'Tên đăng nhập hoặc mật khẩu không chính xác.'}, status=status.HTTP_401_UNAUTHORIZED)

# # # # API Logout
# # # @api_view(['POST'])
# # # def signup(request):
# # #     serializer = UserSerializer(data=request.data)
# # #     # Kiểm tra xem dữ liệu đầu vào có hợp lệ hay không
# # #     if serializer.is_valid():
# # #         user = serializer.save()
# # #         # Nếu token tạo thành tông, biến created = True
# # #         token, created = Token.objects.get_or_create(user=user)
# # #         if created:
# # #             return Response({'token': token.key}, status=status.HTTP_201_CREATED)
# # #         else:
# # #             return Response({'message': 'Người dùng đã tồn tại.'}, status=status.HTTP_409_CONFLICT)
# # #     #  Nếu dữ liệu đầu vào không hợp lệ, ta thông báo mã lỗi
# # #     return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# # # # API SignUp
# # # @api_view(['POST'])
# # # def logout(request):
# # #     # Kiểm tra xem người dùng có được xác thực hay không.
# # #     if request.user.is_authenticated:
# # #         logout(request)
# # #         return Response(status=status.HTTP_200_OK)
# # #     return Response({'message': 'Người dùng chưa đăng nhập.'}, status=status.HTTP_401_UNAUTHORIZED)
    
