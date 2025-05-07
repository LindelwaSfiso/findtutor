from django.urls import path, include
from rest_framework_simplejwt.views import TokenRefreshView, TokenObtainPairView, TokenVerifyView, TokenBlacklistView

from .views import SignUpUserView

app_name = "api"
urlpatterns = [
	path('signup/', SignUpUserView.as_view(), name='signup'),
	path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
	path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
	path('token/verify/', TokenVerifyView.as_view(), name='token_verify'),
	path('token/blacklist/', TokenBlacklistView.as_view(), name='token_blacklist'),

	path('', include('core.urls')),
	path('forums/', include('forum.urls')),
]
