from django.contrib import admin
from .models import User

@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    # Tùy chỉnh hiển thị và quản lý User trong admin
    list_display = ('email', 'type', 'mobile', 'number_coins', 'modify_date')
    search_fields = ('email', 'mobile')
    list_filter = ('type',)
    # list_display = ('first_name', 'last_name', 'email', 'mobile', 'u_status', 'u_created_date')
    # list_filter = ('u_status', 'u_type', 'u_created_date')
    # search_fields = ('u_first_name', 'u_last_name', 'email')
    # ordering = ('user_id',)
    # readonly_fields = ['u_created_date', 'u_modify_date']
    # fieldsets = (
    #     ('User Name', {
    #         'fields': ('u_first_name', 'u_last_name')
    #     }),
    #     ('User Auth', {
    #         'fields': ('email', 'password')
    #     }),
    #     ('Additional Information', {
    #         'fields': ('u_type', 'u_mobile')
    #     })
    # )

# @admin.register(UserDetails)
# class UserDetailsAdmin(admin.ModelAdmin):
#     pass # Không có hành động nào


# # list_display: Xác định các trường được hiển thị trong danh sách đối tượng.
# # list_filter: Tạo bộ lọc bên cạnh danh sách đối tượng để lọc theo các trường cụ thể.
# # search_fields: Kích hoạt tìm kiếm cho danh sách đối tượng với các trường cụ thể.
# # ordering: Xác định thứ tự sắp xếp mặc định của danh sách đối tượng.
# # readonly_fields: Định nghĩa danh sách các trường chỉ đọc không thể chỉnh sửa.
# # fieldsets : Tùy chỉnh các trường hiển thị và yêu cầu khi tạo đối tượng mới.