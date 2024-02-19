from django.contrib import admin
from .models import User, Account

@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    # Tùy chỉnh hiển thị và quản lý User trong admin
    list_display = ('id', 'type', 'email', 'mobile', 'number_coins', 'modify_date')
    search_fields = ('email', 'mobile')
    list_filter = ('type',)
    ordering = ('id',)
    readonly_fields = ['id', 'type', 'email', 'modify_date']

@admin.register(Account)
class AccountAdmin(admin.ModelAdmin):
    list_display = ('account_id', 'user_id', 'ac_name', 'ac_money', 'ac_type', 'ac_explanation', 'ac_modify_date')
    search_fields = ('account_id', 'ac_name')
    list_filter = ('ac_type',)
    ordering = ('account_id',)
    readonly_fields = ['account_id', 'user_id', 'ac_type', 'ac_modify_date']
    



# # list_display: Xác định các trường được hiển thị trong danh sách đối tượng.
# # list_filter: Tạo bộ lọc bên cạnh danh sách đối tượng để lọc theo các trường cụ thể.
# # search_fields: Kích hoạt tìm kiếm cho danh sách đối tượng với các trường cụ thể.
# # ordering: Xác định thứ tự sắp xếp mặc định của danh sách đối tượng.
# # readonly_fields: Định nghĩa danh sách các trường chỉ đọc không thể chỉnh sửa.
# # fieldsets : Tùy chỉnh các trường hiển thị và yêu cầu khi tạo đối tượng mới.