from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.authtoken.models import Token
from django.contrib.auth import authenticate, login, logout
from .serializers import UserSerializer


# API Login
@api_view(['POST'])
def login(request):
    email = request.data.get('u_email')
    password = request.data.get('u_password')

    user = authenticate(request, email=email, password=password)
    if user is not None and user.is_client:
        # Đăng nhập thành công
        login(request, user)
        # Tạo mã Token
        token, created = Token.objects.get_or_create(user=user)
        if created:
             return Response({'token': token.key}, status=status.HTTP_200_OK)
        else:
            return Response({'message': 'Đã sảy ra lỗi.'}, status=status.HTTP_409_CONFLICT)
    return Response({'message': 'Tên đăng nhập hoặc mật khẩu không chính xác.'}, status=status.HTTP_401_UNAUTHORIZED)

# # API Logout
# @api_view(['POST'])
# def signup(request):
#     serializer = UserSerializer(data=request.data)
#     # Kiểm tra xem dữ liệu đầu vào có hợp lệ hay không
#     if serializer.is_valid():
#         user = serializer.save()
#         # Nếu token tạo thành tông, biến created = True
#         token, created = Token.objects.get_or_create(user=user)
#         if created:
#             return Response({'token': token.key}, status=status.HTTP_201_CREATED)
#         else:
#             return Response({'message': 'Người dùng đã tồn tại.'}, status=status.HTTP_409_CONFLICT)
#     #  Nếu dữ liệu đầu vào không hợp lệ, ta thông báo mã lỗi
#     return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# # API SignUp
# @api_view(['POST'])
# def logout(request):
#     # Kiểm tra xem người dùng có được xác thực hay không.
#     if request.user.is_authenticated:
#         logout(request)
#         return Response(status=status.HTTP_200_OK)
#     return Response({'message': 'Người dùng chưa đăng nhập.'}, status=status.HTTP_401_UNAUTHORIZED)
    
