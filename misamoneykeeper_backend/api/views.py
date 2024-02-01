from django.contrib.auth import authenticate, get_user_model
from django.contrib.auth.hashers import make_password
from django.http import JsonResponse

from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from .serializers import UserSerializer, UserLoginSerializer


class UserRegisterView(APIView):
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            email = serializer.validated_data['email']  # Lấy địa chỉ email

            # Kiểm tra tài khoản đã tồn tại hay chưa
            if get_user_model().objects.filter(email=email).exists():
                return JsonResponse({
                    'error_message': 'Email này đã được đăng ký.',
                    'error_code': 400,
                }, status=status.HTTP_400_BAD_REQUEST)
            else:
                # Nếu email chưa được sử dụng, tiến hành đăng ký
                serializer.validated_data['password'] = make_password(serializer.validated_data['password'])
                user = serializer.save()

                return JsonResponse({
                    'message': 'Đăng ký thành công!'
                }, status=status.HTTP_201_CREATED)

        else:
            return JsonResponse({
                'error_message': 'Dữ liệu không hợp lệ.',
                'errors_code': 400,
            }, status=status.HTTP_400_BAD_REQUEST)

class UserLoginView(APIView):
    def post(self, request):
        serializer = UserLoginSerializer(data=request.data)
        if serializer.is_valid():
            user = authenticate(
                request,
                username=serializer.validated_data['email'],
                password=serializer.validated_data['password']
            )
            if user:
                refresh = TokenObtainPairSerializer().get_token(user)
                # Lưu access token vào bảng dữ liệu
                user.auth_token = refresh.access_token  # Giả sử trường auth_token trong model User
                user.save()
                data = {
                    'payload': UserSerializer(user).data
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
    
