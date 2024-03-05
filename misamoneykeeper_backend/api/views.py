from django.contrib.auth import authenticate, get_user_model, login, logout
from django.contrib.auth.hashers import make_password
from django.http import JsonResponse
from django.utils import timezone
from datetime import datetime, timedelta
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from .serializers import UserSerializer, UserViewSerializer, UserLoginSerializer, AccountSerializer, CategorySerializer, CategoryDetailsSerializer, PayAddSerializer, PayViewSerializer, PayHistorySerializer, BalanceAdjustmentSerializer, AccountUpdateSerializer
from .models import User, Account, Category, CategoryDetails, Pay
from rest_framework_simplejwt.tokens import RefreshToken
from django.db.models import Prefetch, Sum, Q
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
                return JsonResponse(data, status=status.HTTP_201_CREATED)
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
                return JsonResponse(data, status=status.HTTP_201_CREATED)
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
                return JsonResponse(data, status=status.HTTP_200_OK)

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
            return JsonResponse(data, status=status.HTTP_200_OK)
            
        return Response({'error': 'refresh token không hợp lệ'}, status=400)

# API màn hình Add Thu/Chi
class PayAddView(APIView):
    def post(self, request):

        data=request.data

        user_id = data.get('user_id')
        category_details_id = data.get('category_details_id')
        account_id = data.get('account_id')
        if not User.objects.filter(id=user_id).exists():
                return Response({
                    'error_message': 'Người dùng không tồn tại',
                    'error_code': 400,
                }, status=status.HTTP_400_BAD_REQUEST)
        else:
            if not CategoryDetails.objects.filter(category_details_id=category_details_id).exists(): 
                return Response({
                    'error_message': 'Hạng mục không tồn tại',
                    'error_code': 400,
                }, status=status.HTTP_400_BAD_REQUEST)
            else:
                if not Account.objects.filter(account_id=account_id).exists():
                    return Response({
                        'error_message': 'Ví không tồn tại',
                        'error_code': 400,
                    }, status=status.HTTP_400_BAD_REQUEST)
                else:
                    serializer = PayAddSerializer(data=request.data)
                    if serializer.is_valid():
                        pay = serializer.save()
                        data = {
                            'status': 1,
                            'payload': PayViewSerializer(pay).data,
                            'message': "Bạn đã thêm khoản thu/chi thành công!"
                        }
                        return JsonResponse(data, status=status.HTTP_200_OK)
                    return Response({
                        'error_messages': serializer.errors,
                        'error_code': 400
                    }, status=status.HTTP_400_BAD_REQUEST)

# API điều chỉnh số dư
class BalanceAdjustmentView(APIView):
    def patch(self, request):
        data = request.data
        account_id = data.get('account_id')
        user_id = data.get('user_id')
        ac_money = data.get('ac_money')
        if not Account.objects.filter(account_id=account_id).exists():
            return Response({
                'error_message': 'Ví không tồn tại',
                    'error_code': 400,
            }, status=status.HTTP_400_BAD_REQUEST)
        else:
            if not User.objects.filter(id=user_id).exists():
                return Response({
                    'error_message': 'Người dùng không tồn tại',
                    'error_code': 400,
                }, status=status.HTTP_400_BAD_REQUEST)
            else:
                account = Account.objects.get(account_id=account_id)
                serializer = BalanceAdjustmentSerializer(data=request.data)
                if serializer.is_valid():
                    account.ac_money = ac_money
                    account.save()
                    data = {
                        'status': 1,
                        'payload': AccountSerializer(account).data,
                        'message': "Bạn đã thay đổi số dư thành công"
                    }
                    return JsonResponse(data, status=status.HTTP_200_OK)
                return Response({
                    'error_messages': serializer.errors,
                    'error_code': 400
                }, status=status.HTTP_400_BAD_REQUEST)
   
# API Hiển thị hạng mục
class CategoryView(APIView):
    def post(self, request):
        data = request.data
        cad_type = data.get('cad_type')
        category = Category.objects.order_by('category_id') # Sắp xếp giảm dần có dấu trừ đằng trc ('-account_id')
        if not Account.objects.filter(cad_type=cad_type).exists():
            return Response({
                'error_message': 'Loại hạng mục không tồn tại',
                    'error_code': 400,
            }, status=status.HTTP_400_BAD_REQUEST)
        else:
            categoryDetails = CategoryDetails.objects.filter(cad_type=cad_type).order_by('category_details_id')
            categorySerializer = CategorySerializer(category, many=True).data # many=True, Serializer sẽ xử lý một danh sách (list)
            categoryDetailsSerializer = CategoryDetailsSerializer(categoryDetails, many=True).data # .data để danh sách dữ liệu sau khi serializer đã xử lý xong
            for a in categorySerializer:
                a['category_details'] = [b for b in categoryDetailsSerializer if b['category_id'] == a['category_id']]
            data = {
                'status': 1,
                'payload': list(categorySerializer),
                'message': "Bạn đã lấy ra dữ liệu hạng mục thành công"
            }
            return JsonResponse(data)
    
# API Lịch sử ghi chép
class HistoryView(APIView):
    def post(self, request):
        data = request.data
        user_id = data.get('user_id')
        p_type = data.get('p_type')
        if not User.objects.filter(id=user_id).exists():
            return Response({
                'error_message': 'Người dùng không tồn tại',
                'error_code': 400,
            }, status=status.HTTP_400_BAD_REQUEST)
        else:
            if not Pay.objects.filter(user_id=user_id).exists():
                return Response({
                    'error_message': 'Không có dữ liệu thu/chi nào',
                    'error_code': 400,
                }, status=status.HTTP_400_BAD_REQUEST)
            else:
                category = Pay.objects.filter(user_id=user_id, p_type=p_type
                ).prefetch_related( # Liên kết 3 bảng, sử dụng __ để định quan hệ
                    'category_details_id__category_id'
                ).values(
                    'category_details_id__category_id',
                    'category_details_id__category_id__ca_name',
                    'category_details_id__category_id__ca_image'
                ).annotate(
                    sum_money=Sum('p_money')
                )
                data1 = []
                for p in category:
                    data1.append({
                        'category_id': p['category_details_id__category_id'],
                        'ca_name': p['category_details_id__category_id__ca_name'],
                        'ca_image': p['category_details_id__category_id__ca_image'],
                        'sum_money': p['sum_money']
                    })
                # Thứ 2
                categoryDetails = Pay.objects.filter(user_id=user_id, p_type=p_type
                ).prefetch_related(
                    'category_details_id'
                ).values(
                    'category_details_id',
                    'category_details_id__category_id',
                    'category_details_id__cad_name',
                    'category_details_id__cad_image'
                 ).annotate(
                    sum_money=Sum('p_money')
                )
                data2 = []
                for p in categoryDetails:
                    data2.append({
                        'category_details_id': p['category_details_id'],
                        'category_id': p['category_details_id__category_id'],
                        'cad_name': p['category_details_id__cad_name'],
                        'cad_image': p['category_details_id__cad_image'],
                        'sum_money': p['sum_money']
                    })
                # Thứ 3
                pay = Pay.objects.filter(user_id=user_id, p_type=p_type).order_by('-p_date')
                paySerializer = PayHistorySerializer(pay, many=True).data
                #  Lồng category details
                for a in data2:
                    a['pay'] = [b for b in paySerializer if b['category_details_id'] == a['category_details_id']]
                #  Lồng category
                for a in data1:
                    a['category_details'] = [b for b in data2 if b['category_id'] == a['category_id']]
                
                data3 = {
                    'status': 1,
                    'payload': list(data1),
                    'message': "Bạn đã lấy ra dữ liệu lịch sử ghi chép thành công"
                }
                return JsonResponse(data3)

# API Ghi chép gần đây
class RecentNotesView(APIView):
    def post(self, request):
        data = request.data
        user_id = data.get('user_id')
        month = data.get('month')
        if not Pay.objects.filter(user_id=user_id).exists():
            return Response({
                'error_message': 'Không có dữ liệu thu/chi nào',
                'error_code': 400,
            }, status=status.HTTP_400_BAD_REQUEST)
        else:
            pay = Pay.objects.filter(user_id=user_id, p_date__month=month).values('p_date'
            ).annotate(
                sum_money_pay=Sum('p_money', filter=Q(p_type=1)),
                sum_money_collect=Sum('p_money', filter=Q(p_type=2))
            ).order_by('-p_date')
            data1 = []
            for p in pay:
                data1.append({
                    'p_date': p['p_date'].strftime("%Y-%m-%d"),
                    'p_money_pay': p['sum_money_pay'] if p['sum_money_pay'] is not None else 0, 
                    'p_money_collect': p['sum_money_collect'] if p['sum_money_collect'] is not None else 0, 
                })
            # Lấy dữ liệu Category
            category = Pay.objects.filter(user_id=user_id).prefetch_related(
                'category_details_id', 'account_id'
            )

            data2 = []
            for c in category:
                data2.append({
                    'p_date': c.p_date.strftime("%Y-%m-%d"), 
                    'category_details_id': c.category_details_id.category_details_id,
                    'category_name': c.category_details_id.cad_name,
                    'cad_image': c.category_details_id.cad_image.url, 
                    'p_type': c.p_type,
                    'p_money': c.p_money,
                    'ac_name': c.account_id.ac_name
                })

            for a in data1:
                a['category'] = [b for b in data2 if b['p_date'] == a['p_date']]
            
            data3 = {
                'status': 1,
                'payload': list(data1),
                'message': "Bạn đã lấy ra dữ liệu lịch sử ghi chép thành công"
            }
            return JsonResponse(data3)

# API Hiển thị tài khoản (ví)
class AccountView(APIView):
    def post(self, request):
        user_id = request.data.get('user_id')
        if not User.objects.filter(id=user_id).exists():
            return Response({
                'error_message': 'Người dùng không tồn tại',
                'error_code': 400,
            }, status=status.HTTP_400_BAD_REQUEST)
        else:
            accounts = Account.objects.filter(user_id=user_id)
            if not accounts.exists():
                return Response({
                    'error_message': 'Chưa có ví nào',
                    'error_code': 400,
                }, status=status.HTTP_400_BAD_REQUEST)
            else:
                serializer = AccountSerializer(accounts, many=True)
                data = {
                    'status': 1,
                    'payload': serializer.data,
                    'message': "Bạn đã lấy thông tin tài khoản thành công"
                }
                return JsonResponse(data)
        
# API Thêm tài khoản (ví)
class AccountAddView(APIView):
    def post(self, request):
        user_id = request.data.get('user_id')
        if not User.objects.filter(id=user_id).exists():
            return Response({
                'error_message': 'Người dùng không tồn tại',
                'error_code': 400,
            }, status=status.HTTP_400_BAD_REQUEST)
        else:
            serializer = AccountSerializer(data=request.data)
            if serializer.is_valid():
                serializer.save()
                data = {
                    'status': 1,
                    'payload': serializer.data,
                    'message': "Chúc mừng bạn đã đăng kí tài khoản (ví) thành công"
                }
                return JsonResponse(data, status=status.HTTP_201_CREATED)
            return Response({
                'error_messages': serializer.errors,
                'error_code': 400
            }, status=status.HTTP_400_BAD_REQUEST)

# API Sửa tài khoản (ví)
class AccountUpdateView(APIView):
    def patch(self, request):
        data = request.data
        account_id = data.get('account_id')
        user_id = data.get('user_id')
        if not Account.objects.filter(account_id=account_id, user_id=user_id).exists():
            return Response({
                'error_message': 'Ví không tồn tại',
                    'error_code': 400,
            }, status=status.HTTP_400_BAD_REQUEST)
        else:
            if not User.objects.filter(id=user_id).exists():
                return Response({
                    'error_message': 'Người dùng không tồn tại',
                    'error_code': 400,
                }, status=status.HTTP_400_BAD_REQUEST)
            else:
                account = Account.objects.get(account_id=account_id, user_id=user_id)
                serializer = AccountUpdateSerializer(data=request.data)
                if serializer.is_valid():
                    account.ac_name = data.get('ac_name')
                    account.ac_money = data.get('ac_money')
                    account.ac_type = data.get('ac_type')
                    account.ac_explanation = data.get('ac_explanation')
                    account.save()
                    data = {
                        'status': 1,
                        'payload': AccountSerializer(account).data,
                        'message': "Bạn đã cập nhật thông tin tài khoản (ví) thành công"
                    }
                    return JsonResponse(data, status=status.HTTP_200_OK)
                return Response({
                    'error_messages': serializer.errors,
                    'error_code': 400
                }, status=status.HTTP_400_BAD_REQUEST)
    
# API Xóa tài khoản (ví)
class AccountDeleteView(APIView):
    def delete(self, request):
        data = request.data
        account_id = data.get('account_id')
        user_id = data.get('user_id')
        if not Account.objects.filter(account_id=account_id, user_id=user_id).exists():
            return Response({
                'error_message': 'Ví không tồn tại',
                    'error_code': 400,
            }, status=status.HTTP_400_BAD_REQUEST)
        else:
            if not User.objects.filter(id=user_id).exists():
                return Response({
                    'error_message': 'Người dùng không tồn tại',
                    'error_code': 400,
                }, status=status.HTTP_400_BAD_REQUEST)
            else:
                account = Account.objects.get(account_id=account_id, user_id=user_id)
                account.delete()
                data = {
                    'status': 1,
                    'message': "Bạn đã xóa tài khoản (ví) thành công"
                }
                return JsonResponse(data, status=status.HTTP_200_OK)

# API Ngừng sử dụng tài khoản (ví)
class AccountStopUsingView(APIView):
    def patch(self, request):
        data = request.data
        account_id = data.get('account_id')
        user_id = data.get('user_id')
        if not Account.objects.filter(account_id=account_id, user_id=user_id).exists():
            return Response({
                'error_message': 'Ví không tồn tại',
                    'error_code': 400,
            }, status=status.HTTP_400_BAD_REQUEST)
        else:
            if not User.objects.filter(id=user_id).exists():
                return Response({
                    'error_message': 'Người dùng không tồn tại',
                    'error_code': 400,
                }, status=status.HTTP_400_BAD_REQUEST)
            else:
                account = Account.objects.get(account_id=account_id, user_id=user_id)
                serializer = AccountUpdateSerializer(data=request.data)
                if serializer.is_valid():
                    account.ac_status = data.get('ac_status')
                    account.save()
                    data = {
                        'status': 1,
                        'payload': AccountSerializer(account).data,
                        'message': "Bạn đã sử dụng/ngừng sử dụng tài khoản (ví) thành công"
                    }
                    return JsonResponse(data, status=status.HTTP_200_OK)
                return Response({
                    'error_messages': serializer.errors,
                    'error_code': 400
                }, status=status.HTTP_400_BAD_REQUEST)
    
# API hiển thị số tiết kiệm
    
# API thêm sổ tiết kiệm