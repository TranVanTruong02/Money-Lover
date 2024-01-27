from django.contrib.auth import authenticate
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
            serializer.validated_data['password'] = make_password(serializer.validated_data['password'])
            user = serializer.save()
            
            return JsonResponse({
                'message': 'Register successful!'
            }, status=status.HTTP_201_CREATED)

        else:
            return JsonResponse({
                'error_message': 'This email has already exist!',
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
                data = {
                    'refresh_token': str(refresh),
                    'access_token': str(refresh.access_token)
                }
                return Response(data, status=status.HTTP_200_OK)

            return Response({
                'error_message': 'Email or password is incorrect!',
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
    
