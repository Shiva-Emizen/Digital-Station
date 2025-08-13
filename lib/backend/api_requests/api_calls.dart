import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'package:ff_commons/api_requests/api_manager.dart';

export 'package:ff_commons/api_requests/api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start ClientAuthorization Group Code

class ClientAuthorizationGroup {
  static String getBaseUrl({
    String? authToken = '',
  }) =>
      'https://digitalstation.ezxdemo.com/api/v1';
  static Map<String, String> headers = {
    'Authorization': 'Bearer [auth_token]',
    'Accept-Language': 'en',
    'Accept': 'application/json',
  };
  static LoginApiCall loginApiCall = LoginApiCall();
  static SignUpApiCall signUpApiCall = SignUpApiCall();
  static GetCountryCall getCountryCall = GetCountryCall();
  static VerifyOtpCall verifyOtpCall = VerifyOtpCall();
  static ForgotPasswordCall forgotPasswordCall = ForgotPasswordCall();
  static ResetPasswordCall resetPasswordCall = ResetPasswordCall();
  static ResendOTPCall resendOTPCall = ResendOTPCall();
  static LoginWithSocialCall loginWithSocialCall = LoginWithSocialCall();
}

class LoginApiCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
    String? fcmToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    final ffApiRequestBody = '''
{
  "email": "${escapeStringForJson(email)}",
  "password": "${escapeStringForJson(password)}",
  "fcm_token": "${escapeStringForJson(fcmToken)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'LoginApi',
      apiUrl: '${baseUrl}/login/client',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SignUpApiCall {
  Future<ApiCallResponse> call({
    String? name = '',
    String? email = '',
    String? countryId = '',
    String? jobTitle = '',
    String? password = '',
    String? passwordConfirmation = '',
    String? fcmToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "email": "${escapeStringForJson(email)}",
  "country_id": "${escapeStringForJson(countryId)}",
  "job_title": "${escapeStringForJson(jobTitle)}",
  "password": "${escapeStringForJson(password)}",
  "password_confirmation": "${escapeStringForJson(passwordConfirmation)}",
  "fcm_token": "${escapeStringForJson(fcmToken)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'SignUpApi',
      apiUrl: '${baseUrl}/register/client',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetCountryCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = ClientAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'getCountry',
      apiUrl: '${baseUrl}/countries',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? countryList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class VerifyOtpCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? otp = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    final ffApiRequestBody = '''
{
  "email": "${escapeStringForJson(email)}",
  "otp": "${escapeStringForJson(otp)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VerifyOtp',
      apiUrl: '${baseUrl}/verify-email',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ForgotPasswordCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'ForgotPassword',
      apiUrl: '${baseUrl}/password/code',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ResetPasswordCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? otp = '',
    String? password = '',
    String? passwordConfirmation = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'ResetPassword',
      apiUrl: '${baseUrl}/password/reset',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ResendOTPCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    final ffApiRequestBody = '''
{
  "email": "${escapeStringForJson(email)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ResendOTP',
      apiUrl: '${baseUrl}/resend-code',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LoginWithSocialCall {
  Future<ApiCallResponse> call({
    String? providerName = '',
    String? email = '',
    String? name = '',
    String? fcmToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    final ffApiRequestBody = '''
{
  "provider_name": "${escapeStringForJson(providerName)}",
  "email": "${escapeStringForJson(email)}",
  "name": "${escapeStringForJson(name)}",
  "fcm_token": "${escapeStringForJson(fcmToken)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'LoginWithSocial',
      apiUrl: '${baseUrl}/login-with-social',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End ClientAuthorization Group Code

/// Start ClientHomePage Group Code

class ClientHomePageGroup {
  static String getBaseUrl({
    String? authToken = '',
  }) =>
      'https://digitalstation.ezxdemo.com/api/v1';
  static Map<String, String> headers = {
    'Authorization': 'Bearer [auth_token]',
    'Accept-Language': 'en',
    'Accept': 'application/json',
  };
  static PopularServiceCall popularServiceCall = PopularServiceCall();
  static RecentServicesCall recentServicesCall = RecentServicesCall();
  static CategoryCall categoryCall = CategoryCall();
  static OrderCall orderCall = OrderCall();
  static SubCategoryCall subCategoryCall = SubCategoryCall();
  static ServiceDetailCall serviceDetailCall = ServiceDetailCall();
  static NotificationCall notificationCall = NotificationCall();
  static ClientProfileCall clientProfileCall = ClientProfileCall();
  static ServiceApiCall serviceApiCall = ServiceApiCall();
  static CreateOrderCall createOrderCall = CreateOrderCall();
  static SavedServicesCall savedServicesCall = SavedServicesCall();
  static AddToFavouriteCall addToFavouriteCall = AddToFavouriteCall();
  static GetSliderAPICall getSliderAPICall = GetSliderAPICall();
  static AllServiceCall allServiceCall = AllServiceCall();
  static FreelancerProfileCall freelancerProfileCall = FreelancerProfileCall();
  static ChangeOrderCall changeOrderCall = ChangeOrderCall();
  static UpdateOrderCall updateOrderCall = UpdateOrderCall();
  static OrderDetailCall orderDetailCall = OrderDetailCall();
}

class PopularServiceCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'PopularService',
      apiUrl: '${baseUrl}/user/popular-services',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? popularServiceList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class RecentServicesCall {
  Future<ApiCallResponse> call({
    int? paginate,
    int? page,
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'RecentServices',
      apiUrl: '${baseUrl}/user/recent-views-services',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? recentViewList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class CategoryCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Category',
      apiUrl: '${baseUrl}/categories',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? categoryList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class OrderCall {
  Future<ApiCallResponse> call({
    String? paginate = '',
    String? orderBycreatedAt = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Order',
      apiUrl: '${baseUrl}/user/orders',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {
        'paginate': paginate,
        'order_by[created_at]': orderBycreatedAt,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? orderList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class SubCategoryCall {
  Future<ApiCallResponse> call({
    String? categoryId = '',
    String? name = '',
    String? paginate = '',
    String? page = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'SubCategory',
      apiUrl: '${baseUrl}/sub-categories',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {
        'category_id': categoryId,
        'name': name,
        'paginate': paginate,
        'page': page,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? subCategoryList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class ServiceDetailCall {
  Future<ApiCallResponse> call({
    String? subCategoryId = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'serviceDetail',
      apiUrl: '${baseUrl}/user/service/${subCategoryId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic serviceDetail(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );

  List? categoryList(dynamic response) => getJsonField(
        response,
        r'''$.data.categories''',
        true,
      ) as List?;

  List? galleryList(dynamic response) => getJsonField(
        response,
        r'''$.data.gallery''',
        true,
      ) as List?;

  List? portFolioList(dynamic response) => getJsonField(
        response,
        r'''$.data.portfolio''',
        true,
      ) as List?;

  List? faqList(dynamic response) => getJsonField(
        response,
        r'''$.data.faqs''',
        true,
      ) as List?;

  List? packageList(dynamic response) => getJsonField(
        response,
        r'''$.data.packages''',
        true,
      ) as List?;
}

class NotificationCall {
  Future<ApiCallResponse> call({
    String? orderBy = '',
    String? createdAt = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'notification',
      apiUrl: '${baseUrl}/notifications',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {
        'order_by[created_at]': orderBy,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? notificationList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class ClientProfileCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'clientProfile',
      apiUrl: '${baseUrl}/user-details',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic clientDetails(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
}

class ServiceApiCall {
  Future<ApiCallResponse> call({
    String? categoryId = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'serviceApi',
      apiUrl: '${baseUrl}/service/category/${categoryId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? serviceList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class CreateOrderCall {
  Future<ApiCallResponse> call({
    String? serviceId = '',
    String? packageId = '',
    String? description = '',
    FFUploadedFile? attachments,
    String? expressDelivery = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'CreateOrder',
      apiUrl: '${baseUrl}/user/orders',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {
        'service_id': serviceId,
        'package_id': packageId,
        'description': description,
        'attachments[]': attachments,
        'express_delivery': expressDelivery,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SavedServicesCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'savedServices',
      apiUrl: '${baseUrl}/user/favourite-services',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? savedList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class AddToFavouriteCall {
  Future<ApiCallResponse> call({
    String? id = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'AddToFavourite',
      apiUrl: '${baseUrl}/user/add-to-favourite/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetSliderAPICall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'GetSliderAPI',
      apiUrl: '${baseUrl}/sliders',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? sliderList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class AllServiceCall {
  Future<ApiCallResponse> call({
    String? search = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'AllService',
      apiUrl: '${baseUrl}/user/all-services',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {
        'search': search,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? serviceList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class FreelancerProfileCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'FreelancerProfile',
      apiUrl: '${baseUrl}/user/freelancer/${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic freelancerProfile(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
}

class ChangeOrderCall {
  Future<ApiCallResponse> call({
    String? orderId = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'ChangeOrder',
      apiUrl: '${baseUrl}/user/complete-order/${orderId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UpdateOrderCall {
  Future<ApiCallResponse> call({
    String? orderId = '',
    String? description = '',
    FFUploadedFile? attachments,
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'UpdateOrder',
      apiUrl: '${baseUrl}/user/orders/${orderId}?_method=PUT',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {
        'attachments[]': attachments,
        'description': description,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class OrderDetailCall {
  Future<ApiCallResponse> call({
    String? orderId = '',
    String? authToken = '',
  }) async {
    final baseUrl = ClientHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'OrderDetail',
      apiUrl: '${baseUrl}/user/orders/${orderId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic orderDetail(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
}

/// End ClientHomePage Group Code

/// Start FreelancerAuthorization Group Code

class FreelancerAuthorizationGroup {
  static String getBaseUrl({
    String? authToken = '',
  }) =>
      'https://digitalstation.ezxdemo.com/api/v1/';
  static Map<String, String> headers = {
    'Authorization': 'Bearer [auth_token]',
    'Accept-Language': 'en',
    'Accept': 'application/json',
  };
  static FreelancerLoginCall freelancerLoginCall = FreelancerLoginCall();
  static FreelancerRegistrationCall freelancerRegistrationCall =
      FreelancerRegistrationCall();
  static LanguageCall languageCall = LanguageCall();
  static SkillsCall skillsCall = SkillsCall();
  static AvatarCall avatarCall = AvatarCall();
  static PersonalInfoUpdateCall personalInfoUpdateCall =
      PersonalInfoUpdateCall();
  static AllLanguageCall allLanguageCall = AllLanguageCall();
  static AddLanguageCall addLanguageCall = AddLanguageCall();
  static AddSkillCall addSkillCall = AddSkillCall();
  static LevelCall levelCall = LevelCall();
  static OccupationCall occupationCall = OccupationCall();
  static GetOccupationCall getOccupationCall = GetOccupationCall();
}

class FreelancerLoginCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
    String? fcmToken = '',
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    final ffApiRequestBody = '''
{
  "email": "${escapeStringForJson(email)}",
  "password": "${escapeStringForJson(password)}",
  "fcm_token": "${escapeStringForJson(fcmToken)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'FreelancerLogin',
      apiUrl: '${baseUrl}login',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FreelancerRegistrationCall {
  Future<ApiCallResponse> call({
    String? name = '',
    String? email = '',
    String? password = '',
    String? passwordConfirmation = '',
    String? fcmToken = '',
    String? countryId = '',
    String? jobTitle = '',
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    final ffApiRequestBody = '''
{
  "name": "${escapeStringForJson(name)}",
  "email": "${escapeStringForJson(email)}",
  "password": "${escapeStringForJson(password)}",
  "password_confirmation": "${escapeStringForJson(passwordConfirmation)}",
  "fcm_token": "${escapeStringForJson(fcmToken)}",
  "country_id": "${escapeStringForJson(countryId)}",
  "job_title": "${escapeStringForJson(jobTitle)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'FreelancerRegistration',
      apiUrl: '${baseUrl}register',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LanguageCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Language',
      apiUrl: '${baseUrl}languages',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? addedLnglst(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class SkillsCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Skills',
      apiUrl: '${baseUrl}skill',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? sklLst(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class AvatarCall {
  Future<ApiCallResponse> call({
    FFUploadedFile? avatar,
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Avatar',
      apiUrl: '${baseUrl}edit-avatar',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {
        'avatar': avatar,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PersonalInfoUpdateCall {
  Future<ApiCallResponse> call({
    String? nickname = '',
    String? about = '',
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    final ffApiRequestBody = '''
{
  "nickname": "${escapeStringForJson(nickname)}",
  "about": "${escapeStringForJson(about)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'PersonalInfoUpdate',
      apiUrl: '${baseUrl}user-about-nick-name',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AllLanguageCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'AllLanguage',
      apiUrl: '${baseUrl}all-languages',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? languageList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class AddLanguageCall {
  Future<ApiCallResponse> call({
    String? languageId = '',
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    final ffApiRequestBody = '''
{
  "language_id": "${escapeStringForJson(languageId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AddLanguage',
      apiUrl: '${baseUrl}languages',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddSkillCall {
  Future<ApiCallResponse> call({
    String? title = '',
    String? experience = '',
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    final ffApiRequestBody = '''
{
  "title": "${escapeStringForJson(title)}",
  "experience": "${escapeStringForJson(experience)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AddSkill',
      apiUrl: '${baseUrl}skills',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class LevelCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Level',
      apiUrl: '${baseUrl}get-level-name',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? levelList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class OccupationCall {
  Future<ApiCallResponse> call({
    String? categoryId = '',
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    final ffApiRequestBody = '''
{
  "category_id": "${escapeStringForJson(categoryId)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Occupation',
      apiUrl: '${baseUrl}occupations',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetOccupationCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerAuthorizationGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'GetOccupation',
      apiUrl: '${baseUrl}occupations',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? occupationList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

/// End FreelancerAuthorization Group Code

/// Start FreelancerHomePage Group Code

class FreelancerHomePageGroup {
  static String getBaseUrl({
    String? authToken = '',
  }) =>
      'https://digitalstation.ezxdemo.com/api/v1/';
  static Map<String, String> headers = {
    'Authorization': 'Bearer [auth_token]',
    'Accept-Language': 'en',
    'Accept': 'application/json',
  };
  static OrderAPICall orderAPICall = OrderAPICall();
  static AddPortfolioCall addPortfolioCall = AddPortfolioCall();
  static AddFAQCall addFAQCall = AddFAQCall();
  static AddPackagesCall addPackagesCall = AddPackagesCall();
  static AddServicesCall addServicesCall = AddServicesCall();
  static MyServicesCall myServicesCall = MyServicesCall();
  static PortfolioCall portfolioCall = PortfolioCall();
  static GetPlanCall getPlanCall = GetPlanCall();
  static GetFAQCall getFAQCall = GetFAQCall();
  static ChangeStatusCall changeStatusCall = ChangeStatusCall();
  static FreelancerOrderDetailCall freelancerOrderDetailCall =
      FreelancerOrderDetailCall();
}

class OrderAPICall {
  Future<ApiCallResponse> call({
    String? paginate = '',
    String? statuses = '',
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'OrderAPI',
      apiUrl: '${baseUrl}freelancer/orders',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {
        'paginate': paginate,
        'statuses[]': statuses,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? freelancerOrderList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class AddPortfolioCall {
  Future<ApiCallResponse> call({
    String? title = '',
    List<FFUploadedFile>? galleryList,
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerHomePageGroup.getBaseUrl(
      authToken: authToken,
    );
    final gallery = galleryList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'AddPortfolio',
      apiUrl: '${baseUrl}portfolio',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {
        'title': title,
        'gallery[]': gallery,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddFAQCall {
  Future<ApiCallResponse> call({
    String? question = '',
    String? answer = '',
    String? serviceId = '',
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'AddFAQ',
      apiUrl: '${baseUrl}faqs',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {
        'service_id': serviceId,
        'question': question,
        'answer': answer,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddPackagesCall {
  Future<ApiCallResponse> call({
    String? title = '',
    String? description = '',
    String? price = '',
    String? deliveryTime = '',
    String? expressDeliverEnable = '',
    String? expressDeliveryAmount = '',
    String? numberOfRevisions = '',
    String? serviceId = '',
    dynamic featuresJson,
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    final features = _serializeJson(featuresJson, true);
    final ffApiRequestBody = '''
{
  "title": "${escapeStringForJson(title)}",
  "description": "${escapeStringForJson(description)}",
  "price": "${escapeStringForJson(price)}",
  "delivery_time": "${escapeStringForJson(deliveryTime)}",
  "express_deliver_enable": "${escapeStringForJson(expressDeliverEnable)}",
  "express_delivery_amount": "${escapeStringForJson(expressDeliveryAmount)}",
  "number_of_revisions": "${escapeStringForJson(numberOfRevisions)}",
  "service_id": "${escapeStringForJson(serviceId)}",
  "features": ${features}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AddPackages',
      apiUrl: '${baseUrl}packages',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AddServicesCall {
  Future<ApiCallResponse> call({
    String? title = '',
    String? description = '',
    List<FFUploadedFile>? galleryList,
    String? categoryId = '',
    String? categories = '',
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerHomePageGroup.getBaseUrl(
      authToken: authToken,
    );
    final gallery = galleryList ?? [];

    return ApiManager.instance.makeApiCall(
      callName: 'AddServices',
      apiUrl: '${baseUrl}services',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {
        'title': title,
        'description': description,
        'gallery[]': gallery,
        'category_id': categoryId,
        'categories[0][category_id]': categories,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class MyServicesCall {
  Future<ApiCallResponse> call({
    String? paginate = '',
    String? page = '',
    String? search = '',
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'MyServices',
      apiUrl: '${baseUrl}services',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {
        'paginate': paginate,
        'page': page,
        'search': search,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? serviceList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class PortfolioCall {
  Future<ApiCallResponse> call({
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'Portfolio',
      apiUrl: '${baseUrl}portfolio',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? portfolioList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetPlanCall {
  Future<ApiCallResponse> call({
    String? serviceId = '',
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'GetPlan',
      apiUrl: '${baseUrl}get-packages/${serviceId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? planList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetFAQCall {
  Future<ApiCallResponse> call({
    String? serviceId = '',
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'GetFAQ',
      apiUrl: '${baseUrl}get-faqs/${serviceId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List? faqList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class ChangeStatusCall {
  Future<ApiCallResponse> call({
    String? orderId = '',
    String? serviceId = '',
    String? link = '',
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'ChangeStatus',
      apiUrl:
          '${baseUrl}freelancer/orders/change-status/${orderId}/${serviceId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {
        'link': link,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class FreelancerOrderDetailCall {
  Future<ApiCallResponse> call({
    String? orderId = '',
    String? authToken = '',
  }) async {
    final baseUrl = FreelancerHomePageGroup.getBaseUrl(
      authToken: authToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'FreelancerOrderDetail',
      apiUrl: '${baseUrl}freelancer/order/${orderId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Bearer ${authToken}',
        'Accept-Language': 'en',
        'Accept': 'application/json',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  dynamic orderDetail(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
}

/// End FreelancerHomePage Group Code

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
