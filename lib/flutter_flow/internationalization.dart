import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
  }) =>
      [enText, arText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomePage
  {
    'g0hx8vrw': {
      'en': 'DS Categories',
      'ar': 'فئات DS',
    },
    'jvoomwde': {
      'en': 'View all',
      'ar': 'عرض الكل',
    },
    'laukp26z': {
      'en': 'Popular Services',
      'ar': 'الخدمات الشعبية',
    },
    'd2skxp94': {
      'en': 'View all',
      'ar': 'عرض الكل',
    },
    'wn65sjss': {
      'en': 'Recently viewed',
      'ar': 'تمت مشاهدته مؤخرًا',
    },
    'tv53vz82': {
      'en': 'View all',
      'ar': 'عرض الكل',
    },
    'en144zqw': {
      'en': 'Welcome Back',
      'ar': 'مرحبًا بعودتك',
    },
    'r14e9dby': {
      'en': 'Search',
      'ar': 'يبحث',
    },
    'r1nsrtq9': {
      'en': 'Welcome Back',
      'ar': 'مرحبًا بعودتك',
    },
    '1v3zwolj': {
      'en': 'Completed Jobs',
      'ar': 'الوظائف المكتملة',
    },
    'n2zd2q7c': {
      'en': 'My Orders',
      'ar': 'طلبياتي',
    },
    'oj79jx8w': {
      'en': 'Services',
      'ar': 'خدمات',
    },
    '2pfc6jye': {
      'en': 'Wallet',
      'ar': 'محفظة',
    },
    'hwc5ij42': {
      'en': 'My Portfolio',
      'ar': 'محفظتي',
    },
    '30wdqf6m': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // SplashPage
  {
    'tp4w00df': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // UserSelectionPage
  {
    '095vvy2b': {
      'en': 'Freelancer',
      'ar': 'عامل مستقل',
    },
    'd6mumpva': {
      'en': 'Need Service',
      'ar': 'بحاجة إلى خدمة',
    },
    'su6dwttg': {
      'en': 'Already Member',
      'ar': 'عضو بالفعل',
    },
    'c6klibw9': {
      'en': 'Sign In',
      'ar': 'تسجيل الدخول',
    },
    'q0t3qyqd': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // CreateAccountPage
  {
    'g2b3xa62': {
      'en': 'Create Account',
      'ar': '',
    },
    'b9x7n3no': {
      'en': 'Add your information',
      'ar': '',
    },
    '0oiwxg3k': {
      'en': 'Full Name',
      'ar': '',
    },
    '6dxh0mc5': {
      'en': 'Email',
      'ar': '',
    },
    'g4qro8d4': {
      'en': 'Select...',
      'ar': '',
    },
    'wvt4rsa9': {
      'en': 'Search...',
      'ar': '',
    },
    'xv22xy7b': {
      'en': 'Job Title',
      'ar': '',
    },
    'o2v47jux': {
      'en': 'Password',
      'ar': '',
    },
    'fku75cj9': {
      'en': 'Confirm Password',
      'ar': '',
    },
    'j57tqj2k': {
      'en': 'Next',
      'ar': '',
    },
    '5ksw11rq': {
      'en': 'Already Member ? ',
      'ar': '',
    },
    'ifv6rxon': {
      'en': ' Sign in',
      'ar': '',
    },
    'i9imlovp': {
      'en': 'Only alphabetic characters (A–Z, a–z) are allowed.',
      'ar': '',
    },
    'ymq84qzt': {
      'en': 'Only alphabetic characters (A–Z, a–z) are allowed.',
      'ar': '',
    },
    '3x141p50': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'eljy7u5l': {
      'en': 'Email is required',
      'ar': '',
    },
    'reb51g27': {
      'en': 'please enter valid email',
      'ar': '',
    },
    't9sd6vqr': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    '2sx7txdl': {
      'en': 'Job Title is required',
      'ar': '',
    },
    '18x6vxzn': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    '0dn4groz': {
      'en': 'Password is required',
      'ar': '',
    },
    'awnio01s': {
      'en': 'Min 8 chars, 1 upper, 1 lower, 1 number, 1 symbol.',
      'ar': '',
    },
    '16gs4526': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    '9wug7ir2': {
      'en': 'Confirm Password is required',
      'ar': '',
    },
    '2tdkqfzg': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'sm090agd': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // SelectPlanPage
  {
    'bpdqo8uc': {
      'en': 'Select Plan',
      'ar': '',
    },
    'xzmkupcv': {
      'en': 'You are almost done',
      'ar': '',
    },
    '5yfzc59t': {
      'en': 'Agree with ',
      'ar': '',
    },
    'gn4tktvr': {
      'en': ' Terms & Conditions',
      'ar': '',
    },
    'e7akbp0q': {
      'en': 'Sign up',
      'ar': '',
    },
    '7k3luuk1': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // TermsConditionPage
  {
    '7licmhur': {
      'en': 'Terms & Conditions',
      'ar': '',
    },
    'gf0fu10b': {
      'en':
          'Horem ipsum dolor sit amet, \n\nconsectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.\n             \nCurabitur tempor quis eros\n\ntempus lacinia. Nam bibendum pellentesque quam a convallis. Sed ut vulputate nisi. Integer in felis sed leo vestibulum venenatis. Suspendisse quis arcu sem. Aenean feugiat ex eu vestibulum vestibulum. Morbi a eleifend magna. Nam metus lacus, porttitor eu mauris a, blandit ultrices nibh. Mauris sit amet magna non ligula vestibulum eleifend. Nulla varius volutpat turpis sed lacinia. Nam eget mi in purus lobortis eleifend. Sed nec ante dictum sem condimentum ullamcorper quis venenatis nisi. Proin vitae facilisis nisi, ac posuere leo.\n              \nNam pulvinar blandit velit\n\nid condimentum diam faucibus at. Aliquam lacus nisi, sollicitudin at nisi nec, fermentum congue felis. Quisque mauris dolor, fringilla sed tincidunt ac, finibus non odio. Sed vitae mauris nec ante pretium finibus. Donec nisl neque, pharetra ac elit eu, faucibus aliquam ligula. Nullam dictum, tellus tincidunt tempor laoreet, nibh elit sollicitudin felis, eget feugiat sapien diam nec nisl. Aenean gravida turpis nisi, consequat dictum risus dapibus a. Duis felis ante, varius in neque eu, tempor suscipit sem. Maecenas ullamcorper gravida sem sit amet cursus. Etiam pulvinar purus vitae justo pharetra consequat. Mauris id mi ut arcu feugiat maximus. Mauris consequat tellus id tempus aliquet.\n              Vestibulum dictum ultrices elit a luctus. Sed in ante ut leo congue posuere at sit amet ligula. Pellentesque eget augue nec nisl sodales blandit sed et sem. Aenean quis finibus arcu, in hendrerit purus. Praesent ac aliquet lorem. Morbi feugiat aliquam ligula, et vestibulum ligula hendrerit vitae. Sed ex lorem, pulvinar sed auctor sit amet, molestie a nibh. Ut euismod nisl arcu, sed placerat nulla volutpat aliquet. Ut id convallis nisl. Ut mauris leo, lacinia sed elit id, sagittis rhoncus odio. Pellentesque sapien libero, lobortis a placerat et, malesuada sit amet dui. Nam sem sapien, congue eu rutrum nec, pellentesque eget ligula.\n              Nunc tempor interdum ex, sed cursus nunc egestas aliquet. Pellentesque interdum vulputate elementum. Donec erat diam, pharetra nec enim ut, bibendum pretium tellus. Vestibulum et turpis nibh. Cras vel ornare velit, ac pretium arcu. Cras justo augue, finibus id sollicitudin et, rutrum eget metus. Suspendisse ut mauris eu massa pulvinar sollicitudin vel sed enim. Pellentesque viverra arcu et dignissim vehicula. Donec a velit ac dolor dapibus pellentesque sit amet at erat. Phasellus porttitor, justo eu ultrices vulputate, nisi mi placerat lectus, sed rutrum tellus est id urna. Aliquam pellentesque odio metus, sit amet imperdiet nisl sodales eu. Quisque viverra nunc nec vestibulum dapibus. Integer nec diam a libero tincidunt varius sed vel odio. Donec rutrum dapibus massa, vel tempor nulla porta id. Suspendisse vulputate fermentum sem sollicitudin facilisis. Aliquam vehicula sapien nec ante auctor, quis mollis leo tincidunt.\n              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent auctor purus luctus enim egestas, ac scelerisque ante pulvinar. Donec ut rhoncus ex. Suspendisse ac rhoncus nisl, eu tempor urna. Curabitur vel bibendum lorem. Morbi convallis convallis diam sit amet lacinia. Aliquam in elementum tellus.\n',
      'ar': '',
    },
    'tgwmmwb2': {
      'en': 'Decline',
      'ar': '',
    },
    'jj5pkfj6': {
      'en': 'Accept',
      'ar': '',
    },
    'w6nfkglo': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // AccountPage
  {
    'fogxglcc': {
      'en': 'Account',
      'ar': '',
    },
    'e210nnpf': {
      'en': 'Orders',
      'ar': '',
    },
    '8xopt5o9': {
      'en': 'My Profile',
      'ar': '',
    },
    '5jc5pjnj': {
      'en': 'My Portfolio',
      'ar': '',
    },
    'owveokpy': {
      'en': 'Wallet',
      'ar': '',
    },
    'zcje2wmc': {
      'en': 'Payment Methods',
      'ar': '',
    },
    '40b9lok5': {
      'en': 'Notifications ',
      'ar': '',
    },
    '37cjzr0x': {
      'en': 'Language',
      'ar': '',
    },
    'laywq6hc': {
      'en': 'Invite friends',
      'ar': '',
    },
    's996upmk': {
      'en': 'About',
      'ar': '',
    },
    'h80zjut3': {
      'en': 'Help',
      'ar': '',
    },
    'rr0f9sjr': {
      'en': 'Logout',
      'ar': '',
    },
    'qekn6etp': {
      'en': 'Account',
      'ar': '',
    },
    'y03i6yjk': {
      'en': 'Orders',
      'ar': '',
    },
    '8yt6ozs8': {
      'en': 'My Profile',
      'ar': '',
    },
    'paux1ykz': {
      'en': 'Notifications ',
      'ar': '',
    },
    '5yd61tmp': {
      'en': 'Language',
      'ar': '',
    },
    '7k0dqx8r': {
      'en': 'Saved Services',
      'ar': '',
    },
    'sq71m0gd': {
      'en': 'Invite friends',
      'ar': '',
    },
    'pph8p7hc': {
      'en': 'About',
      'ar': '',
    },
    'frowf834': {
      'en': 'Help',
      'ar': '',
    },
    '0789fh7g': {
      'en': 'Logout',
      'ar': '',
    },
    'nngz2843': {
      'en': 'Account',
      'ar': '',
    },
  },
  // LanguagePage
  {
    'rzrl1lj6': {
      'en': 'Language',
      'ar': '',
    },
    'efmxd3t2': {
      'en': 'English',
      'ar': '',
    },
    'z5bh3p18': {
      'en': 'Arabic',
      'ar': '',
    },
    '4vq0jetk': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // CategoryPage
  {
    'b1x6bvxf': {
      'en': 'Select Category',
      'ar': '',
    },
    'cxw88jv4': {
      'en': 'Search',
      'ar': '',
    },
    't3ktiofk': {
      'en': 'Search',
      'ar': '',
    },
  },
  // SubCategory
  {
    'lbql1xc1': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // OrderPage
  {
    '9ekr5d8b': {
      'en': 'Orders',
      'ar': '',
    },
    'dgsq5h3p': {
      'en': 'Service by :',
      'ar': '',
    },
    'l0sofjwf': {
      'en': 'Package :',
      'ar': '',
    },
    'doafugrn': {
      'en': 'Delivery time :',
      'ar': '',
    },
    'kstuihpk': {
      'en': 'Comments',
      'ar': '',
    },
    '15h32y6f': {
      'en': 'Accept',
      'ar': '',
    },
    'iv9a4fzl': {
      'en': 'Decline',
      'ar': '',
    },
    'e1q1c0w2': {
      'en': 'Orders',
      'ar': '',
    },
    'vg9yz0um': {
      'en': 'Service by :',
      'ar': '',
    },
    '65x9cuo3': {
      'en': 'Package :',
      'ar': '',
    },
    '29vwqe4l': {
      'en': 'Delivery time :',
      'ar': '',
    },
    'izr0rxwo': {
      'en': 'Comments',
      'ar': '',
    },
    'tz3u1ioc': {
      'en': 'Job Done Successfully',
      'ar': '',
    },
    '8whi7yy5': {
      'en': 'View Files',
      'ar': '',
    },
    'tqj86eqw': {
      'en': 'You can accept or ask for',
      'ar': '',
    },
    'x5pxuwke': {
      'en': ' 2 more edits',
      'ar': '',
    },
    'itnv7aly': {
      'en':
          'If action was taken before 15/03/2024 05:10 PM , The work will be approved automatically ',
      'ar': '',
    },
    '8dqb1kh1': {
      'en': 'Complete',
      'ar': '',
    },
    '4an3t9my': {
      'en': 'Request Edit',
      'ar': '',
    },
    'eo8rqs7e': {
      'en': 'Order',
      'ar': '',
    },
  },
  // RequestEditPage
  {
    'rwtbtxzh': {
      'en': 'Request Edit',
      'ar': '',
    },
    '2xnspz2v': {
      'en': 'Add description',
      'ar': '',
    },
    'ivd61rug': {
      'en': 'Attach Files',
      'ar': '',
    },
    'q88n02re': {
      'en': 'Select zip,image,pdf or ms.word',
      'ar': '',
    },
    'h74nnnmm': {
      'en': 'Cancel',
      'ar': '',
    },
    'p7749cw0': {
      'en': 'Confirm',
      'ar': '',
    },
    'y0odn8ku': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // OrdersPage
  {
    'lur27yvo': {
      'en': 'Orders',
      'ar': '',
    },
    'a6hbrpfo': {
      'en': ' Minimalist logo design',
      'ar': '',
    },
    '4w4x139b': {
      'en': 'Service by :',
      'ar': '',
    },
    'h9p6gmdl': {
      'en': '  Ahmed Edrress',
      'ar': '',
    },
    'cdd7sh8w': {
      'en': 'Package :',
      'ar': '',
    },
    'dbi8cwz4': {
      'en': '  Gold',
      'ar': '',
    },
    'xlfh7nwo': {
      'en': 'Delivery time :',
      'ar': '',
    },
    '6inckutq': {
      'en': '  2 days',
      'ar': '',
    },
    's3ndfd7x': {
      'en': 'Comments',
      'ar': '',
    },
    'yqrvnrb4': {
      'en':
          'Excellent question! We suggest you either register for a RANDOM.ORG account or make a donation to Concern. In case you don\'t know them, Concern is a charity that helps poor people in the third world achieve self-sustainable improvements in their lifestyles. We recommend them because we agree with their mission statement (which they unfortunately removed as per January 2010 Excellent question! We suggest you either register for a RANDOM.ORG account or make a donation to Concern. In case you don\'t know them, Concern is a charity that helps poor people in the third world achieve self-sustainable improvements in their lifestyles. We recommend them because we agree with their mission statement (which they unfortunately removed as per January 2010 Excellent question! We suggest you either register for a RANDOM.ORG account or make a donation to Concern. In case you don\'t know them, Concern is a charity that helps poor people in the third world achieve self-sustainable improvements in their lifestyles. We recommend them because we agree with their mission statement (which they unfortunately as per January 2010',
      'ar': '',
    },
    '0wea1umc': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // SavedPage
  {
    'afl6wtdn': {
      'en': 'Saved',
      'ar': '',
    },
    'cxjv4jfn': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // ServicePage
  {
    'fzovjxtz': {
      'en': 'Services',
      'ar': '',
    },
    'rrneey99': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // ProfilePage
  {
    '2iog8n90': {
      'en': 'Ahmed Edrress',
      'ar': '',
    },
    'zy2vi3ia': {
      'en': 'From',
      'ar': '',
    },
    'mw78703t': {
      'en': 'Egypt (6:55 PM)',
      'ar': '',
    },
    '9sal953k': {
      'en': 'Member Since',
      'ar': '',
    },
    '9kvrcubk': {
      'en': 'October 2022',
      'ar': '',
    },
    'u879ajl7': {
      'en': 'Completed  Orders',
      'ar': '',
    },
    '2ic77963': {
      'en': '15 order',
      'ar': '',
    },
    'a0arz4l7': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // CompleteProfilePage
  {
    'cb42qkzz': {
      'en': 'Ahmed Edrress',
      'ar': '',
    },
    '7bojfco7': {
      'en': 'UI/WordPress Developer',
      'ar': '',
    },
    'ffmzhimt': {
      'en': 'About',
      'ar': '',
    },
    'cc8271mx': {
      'en': 'Info',
      'ar': '',
    },
    'eobzqxk1': {
      'en':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
      'ar': '',
    },
    'bsrugfxc': {
      'en': 'From',
      'ar': '',
    },
    '99bogtmw': {
      'en': 'Egypt (6:55 PM)',
      'ar': '',
    },
    'cg2j1g4f': {
      'en': 'Member Since',
      'ar': '',
    },
    'nxtnsrx3': {
      'en': 'October 2022',
      'ar': '',
    },
    'al4kie96': {
      'en': 'Languages',
      'ar': '',
    },
    'qy1ovg7j': {
      'en': 'Arabic  -  English',
      'ar': '',
    },
    '68obyc7g': {
      'en': 'Skills',
      'ar': '',
    },
    '92le0mui': {
      'en': 'Web design  -  WordPress design',
      'ar': '',
    },
    'lgwrxg77': {
      'en': 'Services',
      'ar': '',
    },
    'u3iz83tr': {
      'en': 'Portfolio',
      'ar': '',
    },
    'bonfv1h2': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // SubscriptionPage
  {
    '9xu3p458': {
      'en': 'Page Title',
      'ar': '',
    },
    '7b0fb6g0': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // CreateOrder
  {
    'tvd1kn7w': {
      'en': 'Add description',
      'ar': '',
    },
    'yepsy9vw': {
      'en': 'Attach Files',
      'ar': '',
    },
    '6enxy1vj': {
      'en': 'Select zip,image,pdf or ms.word',
      'ar': '',
    },
    '5dbmolkm': {
      'en': 'Select zip,image,pdf or ms.word',
      'ar': '',
    },
    'tga6spm8': {
      'en': 'Express Delivery',
      'ar': '',
    },
    'fi47lxcq': {
      'en': 'This Option Will add Extra ',
      'ar': '',
    },
    '0mm0f1dw': {
      'en': ' \$20',
      'ar': '',
    },
    'vcqhksxc': {
      'en': 'Cancel',
      'ar': '',
    },
    'gl17jklm': {
      'en': 'Confirm',
      'ar': '',
    },
    'lhygjie0': {
      'en': 'Please add description here',
      'ar': '',
    },
    'htvpt7ca': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'azd6g7om': {
      'en': 'Order',
      'ar': '',
    },
    '8bw7o5ox': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // PersonalInformationPage
  {
    '21fk5zky': {
      'en': 'Personal Information',
      'ar': '',
    },
    'p5mu6rv3': {
      'en': 'Add your information',
      'ar': '',
    },
    'tve717on': {
      'en': 'Profile picture',
      'ar': '',
    },
    'hyj7ox3c': {
      'en': 'Display name',
      'ar': '',
    },
    'epkkxq88': {
      'en': 'Display name',
      'ar': '',
    },
    'wpd8a4cc': {
      'en': 'About you',
      'ar': '',
    },
    'nhslwbs8': {
      'en': 'Description',
      'ar': '',
    },
    '0fq4hqji': {
      'en': 'Languages',
      'ar': '',
    },
    'arni46o3': {
      'en': 'Add ',
      'ar': '',
    },
    'f4guxcs9': {
      'en': 'Previous',
      'ar': '',
    },
    'dgou2zb1': {
      'en': 'Next',
      'ar': '',
    },
    '7dcivv59': {
      'en': 'Display name is required',
      'ar': '',
    },
    'ww3ig3zz': {
      'en': 'Display name is required',
      'ar': '',
    },
    '22ij1m3k': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'tmekk5co': {
      'en': 'Description is required',
      'ar': '',
    },
    'w1v3v46l': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    '3hj2a0ra': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // WorkInformationPage
  {
    '0guvg86t': {
      'en': 'Work Information',
      'ar': '',
    },
    'iznm262a': {
      'en': 'Add your information',
      'ar': '',
    },
    'uhqyacbz': {
      'en': 'Your Occupation',
      'ar': '',
    },
    '595fkqgx': {
      'en': 'Add ',
      'ar': '',
    },
    '3gbygkcl': {
      'en': 'Skills',
      'ar': '',
    },
    'gdjvt3mg': {
      'en': 'Add ',
      'ar': '',
    },
    'ejvzc84j': {
      'en': 'Previous',
      'ar': '',
    },
    'vdylu3at': {
      'en': 'Next',
      'ar': '',
    },
    'fszbtwp8': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // SelectSubscriptionPage
  {
    'nf8zxkno': {
      'en': 'Work Information',
      'ar': '',
    },
    '983mmdo5': {
      'en': 'Add your information',
      'ar': '',
    },
    'g6rblqlk': {
      'en': 'Empowering Freelancers connecting opportunities ',
      'ar': '',
    },
    '2qoxnktg': {
      'en': 'Elevate your journey with DS App',
      'ar': '',
    },
    'typd2giu': {
      'en': 'Just one step away of getting ajob',
      'ar': '',
    },
    '8xecdj8b': {
      'en': 'Standard',
      'ar': '',
    },
    'cpt2p200': {
      'en': '\$15 for 6 Months',
      'ar': '',
    },
    'si8c0e58': {
      'en': 'Premium',
      'ar': '',
    },
    'uu4trikb': {
      'en': '\$15 for 6 Months',
      'ar': '',
    },
    'y6yndlmp': {
      'en': 'Agree with ',
      'ar': '',
    },
    'xnixa146': {
      'en': ' Terms & Conditions',
      'ar': '',
    },
    'a8zvx4hf': {
      'en': 'Sign up',
      'ar': '',
    },
    'yfeqs76c': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // FreeLancerHomePage
  {
    'ykjvnewn': {
      'en': 'Welcome Back',
      'ar': '',
    },
    '84cx5cgz': {
      'en': 'Ahmed Edrress',
      'ar': '',
    },
    '1qflb80x': {
      'en': '12',
      'ar': '',
    },
    'xxsujciy': {
      'en': 'Completed Jobs',
      'ar': '',
    },
    'jkzqjji9': {
      'en': 'My Orders',
      'ar': '',
    },
    'cgh3edrd': {
      'en': 'My Orders',
      'ar': '',
    },
    '7yokxcn9': {
      'en': 'My Orders',
      'ar': '',
    },
    'a9fmc2d3': {
      'en': 'My Orders',
      'ar': '',
    },
    '0wlpo2mg': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // FreelancerOrderPage
  {
    '915u6vv1': {
      'en': 'Orders',
      'ar': '',
    },
    'mb2dzbem': {
      'en': ' Minimalist logo design',
      'ar': '',
    },
    'lx7dvjud': {
      'en': 'Service by :',
      'ar': '',
    },
    'uazhbw8f': {
      'en': '  Ahmed Edrress',
      'ar': '',
    },
    'u6sabeg9': {
      'en': 'Package :',
      'ar': '',
    },
    'hgovfnf2': {
      'en': '  Gold',
      'ar': '',
    },
    'l82oc7cg': {
      'en': 'Delivery time :',
      'ar': '',
    },
    'kvt87m6o': {
      'en': '  2 days',
      'ar': '',
    },
    'lfj6hdl1': {
      'en': 'Comments',
      'ar': '',
    },
    '8e3z2c68': {
      'en':
          'Excellent question! We suggest you either register for a RANDOM.ORG account or make a donation to Concern. In case you don\'t know them, Concern is a charity that helps poor people in the third world achieve self-sustainable improvements in their lifestyles. We recommend them because we agree with their mission statement (which they unfortunately removed as per January 2010',
      'ar': '',
    },
    'wbqfvunn': {
      'en': 'Accept',
      'ar': '',
    },
    'qg4maujo': {
      'en': 'Decline',
      'ar': '',
    },
    'b1rdp1ws': {
      'en': ' Minimalist logo design',
      'ar': '',
    },
    'n31szte3': {
      'en': 'Service by :',
      'ar': '',
    },
    'j9anzc4c': {
      'en': '  Ahmed Edrress',
      'ar': '',
    },
    'x4hw2mew': {
      'en': 'Package :',
      'ar': '',
    },
    'lvi9vpqf': {
      'en': '  Gold',
      'ar': '',
    },
    'gdn3l939': {
      'en': 'Delivery time :',
      'ar': '',
    },
    '62e4gszo': {
      'en': '  2 days',
      'ar': '',
    },
    'n5jmg576': {
      'en': 'Comments',
      'ar': '',
    },
    'fkgpcdcy': {
      'en':
          'Excellent question! We suggest you either register for a RANDOM.ORG account or make a donation to Concern. In case you don\'t know them, Concern is a charity that helps poor people in the third world achieve self-sustainable improvements in their lifestyles. We recommend them because we agree with their mission statement (which they unfortunately removed as per January 2010',
      'ar': '',
    },
    'ivqep6fa': {
      'en': 'Job Done Successfully',
      'ar': '',
    },
    'ccg2gr1y': {
      'en': 'View Files',
      'ar': '',
    },
    'm5hoxu2r': {
      'en': 'You can accept or ask for',
      'ar': '',
    },
    'hdg0u5sl': {
      'en': ' 2 more edits',
      'ar': '',
    },
    'j5nn66r9': {
      'en':
          'If action was taken before 15/03/2024 05:10 PM , The work will be approved automatically ',
      'ar': '',
    },
    'wo4b1zyp': {
      'en': 'Complete',
      'ar': '',
    },
    'y10jcwaw': {
      'en': 'Request Edit',
      'ar': '',
    },
    'rfssaimo': {
      'en': 'Orders',
      'ar': '',
    },
    'wdtmq21o': {
      'en': 'Service by :',
      'ar': '',
    },
    '8k5bchk7': {
      'en': 'Package :',
      'ar': '',
    },
    'louwkgbo': {
      'en': 'Delivery time :',
      'ar': '',
    },
    '788y3j6j': {
      'en': 'Comments',
      'ar': '',
    },
    '762697ju': {
      'en': 'Job Done Successfully',
      'ar': '',
    },
    'uezuki7n': {
      'en': 'View Files',
      'ar': '',
    },
    'k71ieveh': {
      'en': 'You can accept or ask for',
      'ar': '',
    },
    'ydy30ba1': {
      'en': ' 2 more edits',
      'ar': '',
    },
    'hag9q1o1': {
      'en':
          'If action was taken before 15/03/2024 05:10 PM , The work will be approved automatically ',
      'ar': '',
    },
    'eytr2o3v': {
      'en': 'Complete',
      'ar': '',
    },
    'we7zz3u3': {
      'en': 'Request Edit',
      'ar': '',
    },
    'c4datdny': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // PortfolioPage
  {
    'g08jczif': {
      'en': 'My Portfolio',
      'ar': '',
    },
    'm2g2xlwp': {
      'en': 'Add New Gallery',
      'ar': '',
    },
    '3na60rmn': {
      'en': '1',
      'ar': '',
    },
    'awz5ifzo': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // MyPortFolioPage
  {
    'n8hjgwn0': {
      'en': 'My Portfolio',
      'ar': '',
    },
    '4d3c2aow': {
      'en': 'Save',
      'ar': '',
    },
    '3psjtp6b': {
      'en': 'Enter Title',
      'ar': '',
    },
    'ig23abo7': {
      'en': 'Add New Gallery',
      'ar': '',
    },
    'xgjjm5ak': {
      'en': 'Title is required',
      'ar': '',
    },
    'qqyxur81': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'l37pql5v': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // WalletPage
  {
    'c5czq7lo': {
      'en': 'Wallet',
      'ar': '',
    },
    'uuyp2ije': {
      'en': 'You are ready to earn',
      'ar': '',
    },
    'uanbvlzo': {
      'en': '\$ 0.00',
      'ar': '',
    },
    'ktya3ei2': {
      'en': 'Withdraw History',
      'ar': '',
    },
    'ryd4689w': {
      'en': 'View all',
      'ar': '',
    },
    'o9p7p83d': {
      'en': 'Requested Withdraw',
      'ar': '',
    },
    'f5grchvr': {
      'en': '20 Aug 2023',
      'ar': '',
    },
    't8009te8': {
      'en': '\$ 150',
      'ar': '',
    },
    'f9e4mgkn': {
      'en': 'Requested Withdraw',
      'ar': '',
    },
    '483nmm29': {
      'en': '20 Aug 2023',
      'ar': '',
    },
    'lxyp873d': {
      'en': '\$ 150',
      'ar': '',
    },
    'li20lc9o': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // PaymentPage
  {
    'hxqqglai': {
      'en': 'Payment Methods',
      'ar': '',
    },
    'u0r5q1ax': {
      'en': 'Save',
      'ar': '',
    },
    'qryr2r31': {
      'en': 'Enter your Paypal Email',
      'ar': '',
    },
    'p5hj93f0': {
      'en': 'Beneficiary\'s full name',
      'ar': '',
    },
    'oilm0evo': {
      'en': 'Enter your Paypal Email',
      'ar': '',
    },
    '1kmu8xc0': {
      'en': 'International Bank Account Number (IBAN)',
      'ar': '',
    },
    '8daitsza': {
      'en': 'Enter your Paypal Email',
      'ar': '',
    },
    '99stcez8': {
      'en': 'Bank name and address',
      'ar': '',
    },
    'wsz14m4g': {
      'en': 'Enter your Paypal Email',
      'ar': '',
    },
    '2ea3i2gb': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // MessagePage
  {
    'mzqgetoz': {
      'en': 'Orders',
      'ar': '',
    },
    '7yck75dc': {
      'en': 'Mohamed Hamed',
      'ar': '',
    },
    'f6uwppji': {
      'en': 'Lorem Ipsum is simply... ',
      'ar': '',
    },
    'z7oago5q': {
      'en': '5 Min',
      'ar': '',
    },
    'lmldn563': {
      'en': 'Mohamed Hamed',
      'ar': '',
    },
    'fbv24wmp': {
      'en': 'Lorem Ipsum is simply... ',
      'ar': '',
    },
    'm1f2cn3j': {
      'en': '5 Min',
      'ar': '',
    },
    'y0g16bt0': {
      'en': 'Mohamed Hamed',
      'ar': '',
    },
    '7r474ton': {
      'en': 'Lorem Ipsum is simply... ',
      'ar': '',
    },
    'tt9ltu8x': {
      'en': '5 Min',
      'ar': '',
    },
    '9ebmpryf': {
      'en': 'Mohamed Hamed',
      'ar': '',
    },
    '3sp0aala': {
      'en': 'Lorem Ipsum is simply... ',
      'ar': '',
    },
    'p95j73lu': {
      'en': '5 Min',
      'ar': '',
    },
    '4x8p47s5': {
      'en': 'Mohamed Hamed',
      'ar': '',
    },
    'jc1ii5fz': {
      'en': 'Lorem Ipsum is simply... ',
      'ar': '',
    },
    'orh5pbf1': {
      'en': '5 Min',
      'ar': '',
    },
    '5ckz46l8': {
      'en': 'Mohamed Hamed',
      'ar': '',
    },
    'w3wpxd0c': {
      'en': 'Lorem Ipsum is simply... ',
      'ar': '',
    },
    'y9c0ni6f': {
      'en': '5 Min',
      'ar': '',
    },
    'gee630rm': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // NotificationPage
  {
    '6w4vwfqz': {
      'en': '5 Min',
      'ar': '',
    },
    '868vzggp': {
      'en': 'Notifications',
      'ar': '',
    },
    'r0ipfd4u': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // MyServicePage
  {
    'hy0472qu': {
      'en': 'My Services',
      'ar': '',
    },
    'dwg63cdl': {
      'en': 'Add Service',
      'ar': '',
    },
    'dbpofhqz': {
      'en': 'Search',
      'ar': '',
    },
    'qwlizj8k': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // AddNewService
  {
    'oof6dd4m': {
      'en': 'Add New Service',
      'ar': '',
    },
    'm86beweb': {
      'en': 'Service title',
      'ar': '',
    },
    'fi30jo9b': {
      'en': 'Service title',
      'ar': '',
    },
    '36uritu5': {
      'en': 'Service gallery',
      'ar': '',
    },
    'wbuw8x1p': {
      'en': 'Service description',
      'ar': '',
    },
    'dxtup6p7': {
      'en': 'About Service',
      'ar': '',
    },
    'jg4w0qfi': {
      'en': 'Service category',
      'ar': '',
    },
    '0tuqrwcc': {
      'en': 'Select Category',
      'ar': '',
    },
    'z583ujux': {
      'en': 'Search...',
      'ar': '',
    },
    'rinid81g': {
      'en': 'Select  SubCategory',
      'ar': '',
    },
    'w9w8mwsu': {
      'en': 'Search...',
      'ar': '',
    },
    '87bhnelc': {
      'en': 'Add Service',
      'ar': '',
    },
    '0bi7vxyy': {
      'en': 'Service title is required',
      'ar': '',
    },
    'hlnn1fib': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    '8eiy8bii': {
      'en': 'About Service is required',
      'ar': '',
    },
    'v971u4zu': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    '7dp8uvqe': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // AddNewServiceNextPage
  {
    '1y1701ac': {
      'en': 'Add New Service',
      'ar': '',
    },
    '1ig4bjdg': {
      'en': 'Packages',
      'ar': '',
    },
    'ktkrn1g7': {
      'en': 'Add ',
      'ar': '',
    },
    '3mllwvb3': {
      'en': 'Previous',
      'ar': '',
    },
    'xq9mxche': {
      'en': 'Next',
      'ar': '',
    },
    '5mht4pzu': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // PublishServicePage
  {
    'pzv2w4wp': {
      'en': 'Add New Service',
      'ar': '',
    },
    'oiooiws4': {
      'en': 'Faqs',
      'ar': '',
    },
    'debibr52': {
      'en': 'Add ',
      'ar': '',
    },
    'du2m6dql': {
      'en': 'Previous',
      'ar': '',
    },
    't92gpjht': {
      'en': 'Publish',
      'ar': '',
    },
    'zu822whk': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // ServiceSuccessFullyPublishPage
  {
    'uqg3y6eq': {
      'en': 'Manage Services',
      'ar': '',
    },
    '4brrqo3c': {
      'en': 'Add New Service',
      'ar': '',
    },
    '7naad9l0': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // AddPakagePage
  {
    'c3grqpai': {
      'en': 'Add Package',
      'ar': '',
    },
    '1sn0y65u': {
      'en': 'Package title',
      'ar': '',
    },
    'nr8fqn1c': {
      'en': 'Pakage title',
      'ar': '',
    },
    '64x643uf': {
      'en': 'Package description',
      'ar': '',
    },
    'cefmas5i': {
      'en': 'Description',
      'ar': '',
    },
    '6mxqm8kj': {
      'en': 'Package price',
      'ar': '',
    },
    'rjrpptyx': {
      'en': 'Price',
      'ar': '',
    },
    'q7v6q6yz': {
      'en': 'Delivery time',
      'ar': '',
    },
    't58kch9e': {
      'en': 'Delivery time',
      'ar': '',
    },
    'w27t791k': {
      'en': 'Search...',
      'ar': '',
    },
    'rgnwpi5y': {
      'en': 'Option 1',
      'ar': '',
    },
    'uft629wj': {
      'en': 'Option 2',
      'ar': '',
    },
    'wg4tjjhh': {
      'en': 'Option 3',
      'ar': '',
    },
    '8tr993gw': {
      'en': 'Express Delivery',
      'ar': '',
    },
    'udsjgowg': {
      'en': 'Price',
      'ar': '',
    },
    'cohapn67': {
      'en': 'Number of revisions',
      'ar': '',
    },
    'kcx3krq1': {
      'en': 'Revisions',
      'ar': '',
    },
    '56zoudiv': {
      'en': 'Other features',
      'ar': '',
    },
    '6clyp9ic': {
      'en': 'Add ',
      'ar': '',
    },
    'khr6z0bz': {
      'en': 'Previous',
      'ar': '',
    },
    '6nfv7i1i': {
      'en': 'Add',
      'ar': '',
    },
    '5k2nyf8g': {
      'en': 'Pakage title is required',
      'ar': '',
    },
    'nuorqyb5': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'ics8n1dy': {
      'en': 'Description is required',
      'ar': '',
    },
    'kosh6f9l': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    '67lfin7i': {
      'en': 'Price is required',
      'ar': '',
    },
    '2d5jvc2p': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'z4huyg7f': {
      'en': 'Price is required',
      'ar': '',
    },
    'asdsa7vd': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    '8wcog162': {
      'en': 'Revisions is required',
      'ar': '',
    },
    'p9nxfoko': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'gp0p4kfv': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // AddFaqPage
  {
    'b6yvbzaq': {
      'en': 'Add Faq',
      'ar': '',
    },
    'ktx2ltq4': {
      'en': 'Question',
      'ar': '',
    },
    'gkm1etui': {
      'en': 'Question',
      'ar': '',
    },
    've45x4wn': {
      'en': 'Answer',
      'ar': '',
    },
    'xu3pw4ek': {
      'en': 'Question is required',
      'ar': '',
    },
    'e8nwcbb0': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'isff8kl1': {
      'en': 'Answer is required',
      'ar': '',
    },
    'fqlkg3m8': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'n5qan6w5': {
      'en': 'Cancel',
      'ar': '',
    },
    'qh3p3lot': {
      'en': 'Add',
      'ar': '',
    },
    'v6kmf5gd': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // OtpPage
  {
    'btq62de3': {
      'en': 'OTP Verification',
      'ar': '',
    },
    'ixwa74gr': {
      'en': 'Verify',
      'ar': '',
    },
    '57naodf9': {
      'en': 'Didn’t get the OTP? ',
      'ar': '',
    },
    '863h18mx': {
      'en': 'Resend',
      'ar': '',
    },
    'h9fofgwf': {
      'en': 'OTP code is required',
      'ar': '',
    },
    'lc77utt1': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // ForgotPasswordPage
  {
    'jhoxhja4': {
      'en': 'Forgot Password',
      'ar': '',
    },
    'ar9c5nx2': {
      'en': 'Email',
      'ar': '',
    },
    'zh43e5td': {
      'en': 'Submit',
      'ar': '',
    },
    '5iwwqq2z': {
      'en': 'Email is required',
      'ar': '',
    },
    '554d709l': {
      'en': 'Please enter valid email',
      'ar': '',
    },
    'kubwudlf': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'hrvrzbmu': {
      'en': 'Password is required',
      'ar': '',
    },
    'xgw5tns7': {
      'en': 'Please enter valid name',
      'ar': '',
    },
    '8th9nc6m': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'bkkm6vsr': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // ResetPasswordPage
  {
    'lk77zkh8': {
      'en': 'Reset Password',
      'ar': '',
    },
    'znndw9q5': {
      'en': 'Email',
      'ar': '',
    },
    '3d598tul': {
      'en': 'Otp',
      'ar': '',
    },
    'dzuixasa': {
      'en': 'Password',
      'ar': '',
    },
    'p99l86ir': {
      'en': 'Confirm Password',
      'ar': '',
    },
    '4xm905uk': {
      'en': 'Submit',
      'ar': '',
    },
    '9onipqg6': {
      'en': 'Email is required',
      'ar': '',
    },
    't4uqkzqb': {
      'en': 'Please enter valid email',
      'ar': '',
    },
    '0yyoqjy5': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'z9uj9u6h': {
      'en': 'Password is required',
      'ar': '',
    },
    'eo94lqp2': {
      'en': 'Please enter valid name',
      'ar': '',
    },
    'il85rm94': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'iygatnk5': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // ServiceDetailPage
  {
    'ghyim16e': {
      'en': 'Delivery time',
      'ar': '',
    },
    'yhvq829g': {
      'en': 'Revisions',
      'ar': '',
    },
    'a0l4dtf9': {
      'en': 'Continue',
      'ar': '',
    },
    'h2ywztkp': {
      'en': 'Reviews',
      'ar': '',
    },
    'mdu06j9e': {
      'en': '4.9',
      'ar': '',
    },
    'gp1dky31': {
      'en': 'View all',
      'ar': '',
    },
    'owlctk8d': {
      'en': 'FAQs',
      'ar': '',
    },
    'lxzvlmeb': {
      'en': 'View all',
      'ar': '',
    },
    'yxhsmzhc': {
      'en': 'My Portfolio',
      'ar': '',
    },
    'yum7tpzn': {
      'en': 'View all',
      'ar': '',
    },
    'n5ybdzzz': {
      'en': 'Recently viewed',
      'ar': '',
    },
    'kbsotbtj': {
      'en': 'View all',
      'ar': '',
    },
    'q1zypqos': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // ViewAllPage
  {
    'ik4fsx53': {
      'en': 'Popular Services',
      'ar': '',
    },
    'lha79rto': {
      'en': 'Home',
      'ar': 'بيت',
    },
  },
  // CreateAccountPageFreelancer
  {
    'eyjby725': {
      'en': 'Create Account',
      'ar': '',
    },
    '2lez41fv': {
      'en': 'Add your information',
      'ar': '',
    },
    'rnzipupa': {
      'en': 'Full Name',
      'ar': '',
    },
    '2kh6puiz': {
      'en': 'Email',
      'ar': '',
    },
    'yl93y76x': {
      'en': 'Select...',
      'ar': '',
    },
    'h8g757fs': {
      'en': 'Search...',
      'ar': '',
    },
    'fpeby77e': {
      'en': 'Job Title',
      'ar': '',
    },
    'yxxigt6s': {
      'en': 'Password',
      'ar': '',
    },
    'icwn46lq': {
      'en': 'Confirm Password',
      'ar': '',
    },
    '53m7dux9': {
      'en': 'Next',
      'ar': '',
    },
    'x0h0ivq9': {
      'en': 'Already Member ? ',
      'ar': '',
    },
    '9sgeuz2v': {
      'en': ' Sign in',
      'ar': '',
    },
    'k1zpk9g8': {
      'en': 'Only alphabetic characters (A–Z, a–z) are allowed.',
      'ar': '',
    },
    '78x7vg53': {
      'en': 'Only alphabetic characters (A–Z, a–z) are allowed.',
      'ar': '',
    },
    '3774ia1e': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'ckbmblx6': {
      'en': 'Email is required',
      'ar': '',
    },
    '387gh9sk': {
      'en': 'please enter valid email',
      'ar': '',
    },
    'vuofiebo': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'wyh44ppl': {
      'en': 'Job Title is required',
      'ar': '',
    },
    'ebd5rsyv': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'ubl35j72': {
      'en': 'Password is required',
      'ar': '',
    },
    'umqea9m8': {
      'en': 'Min 8 chars, 1 upper, 1 lower, 1 number, 1 symbol.',
      'ar': '',
    },
    'bsv3i8ez': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'hoj17kor': {
      'en': 'Confirm Password is required',
      'ar': '',
    },
    'af8go9qx': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'czy3q284': {
      'en': 'Home',
      'ar': '',
    },
  },
  // LoginPageFreelancer
  {
    'ycxma01x': {
      'en': 'Welcome Back',
      'ar': '',
    },
    '87ssl0m9': {
      'en': 'Sign in By',
      'ar': '',
    },
    '6n9uw2jq': {
      'en': 'Email',
      'ar': '',
    },
    '75gmr2e7': {
      'en': 'Password',
      'ar': '',
    },
    't8pf4rzg': {
      'en': 'Remember me',
      'ar': '',
    },
    '4w4bgqkf': {
      'en': 'Sign in',
      'ar': '',
    },
    'wq5ytahf': {
      'en': 'Or sign in by',
      'ar': '',
    },
    'mn6wd87b': {
      'en': 'Join us',
      'ar': '',
    },
    'qdx7zcro': {
      'en': 'Forgot Password',
      'ar': '',
    },
    'unhnwhxm': {
      'en': 'Email is required',
      'ar': '',
    },
    'xhtc37eg': {
      'en': 'Please enter valid email',
      'ar': '',
    },
    'yvmnz3yh': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    'c5mh65af': {
      'en': 'Password is required',
      'ar': '',
    },
    'u1ldie85': {
      'en': 'Please enter valid name',
      'ar': '',
    },
    'dahi2txb': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
    '17gytkwk': {
      'en': 'Home',
      'ar': '',
    },
  },
  // OtpPageFreelancer
  {
    'u56a5bcr': {
      'en': 'OTP Verification',
      'ar': '',
    },
    'oocnuj1x': {
      'en': 'Verify',
      'ar': '',
    },
    '1j64rrlr': {
      'en': 'Didn’t get the OTP? ',
      'ar': '',
    },
    'buf2tza7': {
      'en': 'Resend',
      'ar': '',
    },
    '78mkex51': {
      'en': 'OTP code is required',
      'ar': '',
    },
    't3i4jvkg': {
      'en': 'Home',
      'ar': '',
    },
  },
  // HomePageCopy
  {
    'z2ebto2v': {
      'en': 'DS Categories',
      'ar': '',
    },
    'omwwgrdf': {
      'en': 'View all',
      'ar': '',
    },
    'hjy7rvi0': {
      'en': 'Popular Services',
      'ar': '',
    },
    'b44rkg3d': {
      'en': 'View all',
      'ar': '',
    },
    'b158s3sv': {
      'en': 'Recently viewed',
      'ar': '',
    },
    '2kfgiogy': {
      'en': 'View all',
      'ar': '',
    },
    '9fje9kod': {
      'en': 'Welcome Back',
      'ar': '',
    },
    '2h4cokd0': {
      'en': 'Search',
      'ar': '',
    },
    'lsslm2tk': {
      'en': 'Welcome Back',
      'ar': '',
    },
    'h6iwtuz1': {
      'en': 'Completed Jobs',
      'ar': '',
    },
    '3ybt4g3s': {
      'en': 'My Orders',
      'ar': '',
    },
    'fhuukxpa': {
      'en': 'Services',
      'ar': '',
    },
    'ueo4zugl': {
      'en': 'Wallet',
      'ar': '',
    },
    '4rnm6rzs': {
      'en': 'My Portfolio',
      'ar': '',
    },
    'epe9cjhb': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Logout
  {
    '3zn7uzpj': {
      'en': 'Log Out',
      'ar': '',
    },
    'tf3hlqky': {
      'en': 'Are you sure you want to log out?',
      'ar': '',
    },
    '9hw1zykc': {
      'en': 'Cancel',
      'ar': '',
    },
    'umqapd5e': {
      'en': 'Yes',
      'ar': '',
    },
  },
  // AddLanguage
  {
    'mjha4pii': {
      'en': 'Add Language',
      'ar': '',
    },
    '62t4uhfp': {
      'en': 'Select Language',
      'ar': '',
    },
    '7xbbhbq1': {
      'en': 'Search...',
      'ar': '',
    },
    '584dq2kr': {
      'en': 'Cancel',
      'ar': '',
    },
    'ebgmgui5': {
      'en': 'Add',
      'ar': '',
    },
  },
  // AddSkill
  {
    'nza6d2c9': {
      'en': 'Add Skill',
      'ar': '',
    },
    '7to24sjb': {
      'en': 'Example : HTML',
      'ar': '',
    },
    'ijtleo45': {
      'en': 'Experience level',
      'ar': '',
    },
    'nddskxlo': {
      'en': 'Search...',
      'ar': '',
    },
    'i2kiacv4': {
      'en': 'Cancel',
      'ar': '',
    },
    'uaoz53nw': {
      'en': 'Add',
      'ar': '',
    },
    'y84sdf3d': {
      'en': 'This field is required',
      'ar': '',
    },
    '18orq3sg': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
  },
  // AddOccupation
  {
    '3c86ffm9': {
      'en': 'Add Occupation',
      'ar': '',
    },
    'v9bpdw5w': {
      'en': 'Select category',
      'ar': '',
    },
    '7nzjgaqu': {
      'en': 'Search...',
      'ar': '',
    },
    'ngck71yz': {
      'en': 'Cancel',
      'ar': '',
    },
    '5055rw1m': {
      'en': 'Add',
      'ar': '',
    },
    'ofizvrn5': {
      'en': 'This field is required',
      'ar': '',
    },
    'wunwhbhd': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
  },
  // AddTitle
  {
    'j19llnky': {
      'en': 'Add Title',
      'ar': '',
    },
    'irwhu9yn': {
      'en': 'Example : HTML',
      'ar': '',
    },
    '9tum9rxi': {
      'en': 'Cancel',
      'ar': '',
    },
    'lfcfvsj4': {
      'en': 'Add',
      'ar': '',
    },
    '4dafyryh': {
      'en': 'Thid field can\'t be empty',
      'ar': '',
    },
    'k6cgi9bs': {
      'en': 'Please choose an option from the dropdown',
      'ar': '',
    },
  },
  // Miscellaneous
  {
    'kyvafmr2': {
      'en': '',
      'ar': '',
    },
    'nzy24gi3': {
      'en': '',
      'ar': '',
    },
    'sz2jg8yi': {
      'en': '',
      'ar': '',
    },
    'birb9srd': {
      'en': '',
      'ar': '',
    },
    '88ur0luc': {
      'en': '',
      'ar': '',
    },
    'h83esyzw': {
      'en': '',
      'ar': '',
    },
    '1sfx4g1k': {
      'en': '',
      'ar': '',
    },
    'f585vcn6': {
      'en': '',
      'ar': '',
    },
    'pv3z50lu': {
      'en': '',
      'ar': '',
    },
    '2v6a6y8r': {
      'en': '',
      'ar': '',
    },
    'j7kk176p': {
      'en': '',
      'ar': '',
    },
    '1obzezr4': {
      'en': '',
      'ar': '',
    },
    'wtn9n76j': {
      'en': '',
      'ar': '',
    },
    'l1urbft5': {
      'en': '',
      'ar': '',
    },
    'nj2hr8nm': {
      'en': '',
      'ar': '',
    },
    '4qcwm18p': {
      'en': '',
      'ar': '',
    },
    '103aik6c': {
      'en': '',
      'ar': '',
    },
    'b3ogb3go': {
      'en': '',
      'ar': '',
    },
    'n2hvdmsn': {
      'en': '',
      'ar': '',
    },
    '84n5afq6': {
      'en': '',
      'ar': '',
    },
    '11mxlzqw': {
      'en': '',
      'ar': '',
    },
    'fols2s5q': {
      'en': '',
      'ar': '',
    },
    '5n2oyx9r': {
      'en': '',
      'ar': '',
    },
    'n8jc18n4': {
      'en': '',
      'ar': '',
    },
    '343h4p17': {
      'en': '',
      'ar': '',
    },
    'payj74vq': {
      'en': '',
      'ar': '',
    },
    'flqhtfjk': {
      'en': '',
      'ar': '',
    },
  },
].reduce((a, b) => a..addAll(b));
