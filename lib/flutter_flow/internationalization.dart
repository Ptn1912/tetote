import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['vi', 'en', 'ja'];

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
    String? viText = '',
    String? enText = '',
    String? jaText = '',
  }) =>
      [viText, enText, jaText][languageIndex] ?? '';

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

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

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

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // DanhMucPage
  {
    'x2nguhs3': {
      'vi': 'Danh mục',
      'en': 'Category',
      'ja': 'カテゴリー',
    },
    '9e4lm75c': {
      'vi': 'Dùng điểm xanh',
      'en': 'Use Green Point',
      'ja': '緑色のポイントを使用',
    },
    's3p8qb4p': {
      'vi': 'Đổi quà xanh',
      'en': 'Exchange Green Gifts',
      'ja': 'ギフトを引き換え',
    },
    'qyor0zwt': {
      'vi': 'Nhận ngay những món quà xanh bền vững bằng điểm GP',
      'en': 'Receive sustainable green gifts with GP points',
      'ja': 'GPポイントで持続可能なグリーンギフトを受け取ろう',
    },
    'ozu17lhd': {
      'vi': 'Đóng góp xanh',
      'en': 'Green contributions',
      'ja': '環境への貢献',
    },
    'q8v7hlzn': {
      'vi': 'Đóng góp GP cho các dự án tạo tác động xã hội',
      'en': 'GP contributions to social impact projects',
      'ja': '社会的影響を与えるプロジェクトへの GP の貢献',
    },
    'ryv25d46': {
      'vi': 'Chuyển điểm',
      'en': 'Point transfer',
      'ja': 'ポイント移行',
    },
    '282ne7su': {
      'vi': 'Cùng chia sẽ niềm vui xanh với bạn bè bằng cách tặng điểm xanh GP',
      'en': 'Share green joy with friends by donating GP green points',
      'ja': 'GP グリーン ポイントを寄付して、緑の喜びを友達と共有しましょう',
    },
    '30sqlevj': {
      'vi': 'Tích điểm xanh',
      'en': 'Earn green points',
      'ja': 'グリーンポイントを獲得',
    },
    'ffflm9rb': {
      'vi': 'Sống xanh',
      'en': 'Live green',
      'ja': 'ライブグリーン',
    },
    '6goqix8n': {
      'vi': 'Sống xanh hơn 1% bằng cách thực hiện hành động xanh mỗi ngày',
      'en': 'Live 1% greener by taking green actions every day',
      'ja': '毎日環境に優しい行動をとって、1% 環境に優しい生活を送りましょう',
    },
    'ye7hh2rj': {
      'vi': 'Truy lùng điểm xám',
      'en': 'Hunt for gray spots',
      'ja': '灰色の点を探す',
    },
    'dhfaqeiu': {
      'vi': 'Báo cáo các điểm xả rác trái phép và tồn đọng lâu ngày',
      'en': 'Report illegal and long-standing dumping sites',
      'ja': '長年にわたって不法投棄されている場所を報告する',
    },
    '5qd0wxvp': {
      'vi': 'Shop Xanh  EcoFuturía',
      'en': 'EcoFuturía Green Shop',
      'ja': 'エコフューチュリア グリーン ショップ',
    },
    '0bm4zlr0': {
      'vi': 'Cùng chung tay giúp đỡ các cộng đồng ý nghĩa',
      'en': 'Let\'s join hands to help meaningful communities',
      'ja': '力を合わせて有意義なコミュニティを支援しましょう',
    },
    'op3qqsbs': {
      'vi': 'Trạm xanh đổi rác',
      'en': 'Green station for trash exchange',
      'ja': 'ゴミ交換所「みどりのステーション」',
    },
    'jw5oagnp': {
      'vi': 'Nơi nhận rác thải đã qua chế biến để mang đi xử lí và tái chế',
      'en': 'A place to receive processed waste for treatment and recycling',
      'ja': '処理済み廃棄物を処理およびリサイクルのために受け取る場所',
    },
    'fusg7728': {
      'vi': 'Giới Thiệu Bạn Bè',
      'en': 'Introduce to your friends',
      'ja': 'お友達に紹介してください',
    },
    'b4ragd0r': {
      'vi': 'Lan tỏa lối sống xanh tới bạn bè nhận ngay 5GP',
      'en':
          'Spread the green lifestyle to your friends and receive 5GP immediately',
      'ja': 'グリーンなライフスタイルを友達と共有し、すぐに 5GP を受け取りましょう',
    },
    '8ae0vyvf': {
      'vi': 'Danh Mục',
      'en': 'Category',
      'ja': 'カテゴリー',
    },
  },
  // Doiqua
  {
    '3ijn13z1': {
      'vi': 'ĐỔI QUÀ XANH',
      'en': 'EXCHANGE GREEN GIFTS',
      'ja': 'グリーンギフトを交換する',
    },
    'av9jm4w0': {
      'vi': 'Quà cùa tôi',
      'en': 'My gift',
      'ja': '私のギフト',
    },
    'wjtlfhg9': {
      'vi': 'QUÀ XANH',
      'en': 'GREEN GIFT',
      'ja': 'グリーンギフト',
    },
    'dgpios1w': {
      'vi': 'ĐA DẠNG',
      'en': 'DIVERSITY',
      'ja': '多様性',
    },
    'sd1ochkq': {
      'vi': 'Ý NGHĨA',
      'en': 'MEANING',
      'ja': '意味',
    },
    'jofow8ih': {
      'vi': 'CHUNG TAY',
      'en': 'JOIN HANDS',
      'ja': '手と手',
    },
    '23ag059k': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホームページ',
    },
  },
  // Donggopxanh
  {
    'r9lq9lbj': {
      'vi': 'Đóng góp xanh',
      'en': 'Green contributions',
      'ja': '環境への貢献',
    },
    '6nj5b4hd': {
      'vi': 'Đang diễn ra',
      'en': 'Happenning',
      'ja': 'ハプニング',
    },
    'l3vptwso': {
      'vi': 'ỦNG HỘ TRỒNG RỪNG: GÓP 1 CÂY LÀ GÓP RỪNG ',
      'en':
          'SUPPORT FORESTRY: CONTRIBUTING 1 TREE IS CONTRIBUTING TO THE FOREST',
      'ja': '森林を支援する: 1 本の木に貢献することが森林に貢献することになります',
    },
    '6jnqyr3e': {
      'vi':
          'Bạn có biết cứ mỗi phút trôi qua, Trái Đất mất đi một diện tích rừng bằng 40 sân bóng đá không?',
      'en':
          'Did you know that every minute that passes, the Earth loses an area of ​​forest equal to 40 football fields?',
      'ja': '地球は毎分サッカー場40個分に相当する森林面積を失っていることをご存知ですか？',
    },
    'ikthejiu': {
      'vi': '2669',
      'en': '2669',
      'ja': '2669',
    },
    'osumkuj1': {
      'vi': '/6500 GP mục tiêu',
      'en': '/6500 GP target',
      'ja': '/6500GP目標',
    },
    'en32025e': {
      'vi': '69',
      'en': '69',
      'ja': '69',
    },
    'xwvu2ilh': {
      'vi': 'người đóng góp',
      'en': 'Contributors',
      'ja': '貢献者',
    },
    'usmn2796': {
      'vi': 'XUÂN LIÊN VẪY GỌI - GÓP RỪNG CÙNG GAIA',
      'en': 'XUAN LIEN IS CALLING - CONTRIBUTING THE FOREST WITH GAIA',
      'ja': 'スアン・リアンが呼んでいます - ガイアで森林に貢献します',
    },
    'lpdrvplo': {
      'vi': 'Trồng rừng ở đâu?\nỞ đâu cũng có thể trồng rừng',
      'en': 'Where to plant forests?\nForests can be planted anywhere',
      'ja': 'どこに森林を植えるのか？\n森はどこにでも植えることができる',
    },
    'evz05cf6': {
      'vi': '1425',
      'en': '1425',
      'ja': '1425',
    },
    'j2x17yqw': {
      'vi': '/6500 GP mục tiêu',
      'en': '/6500 GP target',
      'ja': '/6500GP目標',
    },
    'spynkkdb': {
      'vi': '54',
      'en': '54',
      'ja': '54',
    },
    'oix8er31': {
      'vi': 'người đóng góp',
      'en': 'Contributors',
      'ja': '貢献者',
    },
    'kvu9e6x9': {
      'vi': 'Đã kết thúc',
      'en': 'Finished',
      'ja': '終了した',
    },
    '44zjlu9p': {
      'vi': 'TỦ SÁCH NHÂN ÁI',
      'en': 'HUMANITY BOOKCASE: NINH HAI HIGH SCHOOL',
      'ja': 'ヒューマニティ本棚: ニンハイ高校',
    },
    'd9zqivy2': {
      'vi': 'Dự án \"TỦ SÁCH NHÂN ÁI\" là dự án tặng tủ sách cho trẻ em',
      'en':
          'Project \"CHARITY BOOKCASE\" is a project to donate bookcases to children',
      'ja': 'プロジェクト「CHARITY BOOKCASE」は子どもたちに本棚を寄贈するプロジェクトです',
    },
    'cd0uaqk1': {
      'vi': '1250',
      'en': '1250',
      'ja': '1250',
    },
    'fhfo52l2': {
      'vi': '/3420 GP mục tiêu',
      'en': '/3420 GP target',
      'ja': '/3420 GPターゲット',
    },
    'prvof5l8': {
      'vi': '45',
      'en': '45',
      'ja': '45',
    },
    '57pqcjwd': {
      'vi': 'người đóng góp',
      'en': 'Contributors',
      'ja': '貢献者',
    },
    'eg9ma5u4': {
      'vi': 'TỦ SÁCH NHÂN ÁI: THPT LƯƠNG THẾ VINH',
      'en': 'HUMANITY BOOKCASE: LUONG THE VINH HIGH SCHOOL',
      'ja': 'ヒューマニティ本棚: ルオン・ザ・ヴィン高校',
    },
    'vz5fhgkb': {
      'vi':
          'Dự án \"TỦ SÁCH NHÂN ÁI\" là dự án tặng tủ sách cho trường THCS Lương  Thế Vinh tại xã Nhơn Hải, huyện Ninh Hải, tỉnh Ninh Thuận',
      'en':
          'Project \"CHARITY BOOKCASE\" is a project to donate bookcases to Luong The Vinh Secondary School in Nhon Hai commune, Ninh Hai district, Ninh Thuan province',
      'ja':
          'プロジェクト「CHARITY BOOKCASE」は、ニントゥアン省ニンハイ地区ニョンハイコミューンのルオン・ザ・ビン中学校に本棚を寄贈するプロジェクトです',
    },
    'cectllkg': {
      'vi': '850',
      'en': '850',
      'ja': '850',
    },
    '14dv9wxb': {
      'vi': '/3500 GP mục tiêu',
      'en': '/3500 GP mục tiêu',
      'ja': '/3500 GP モクティエ',
    },
    'zxpd1ncn': {
      'vi': '32',
      'en': '32',
      'ja': '32',
    },
    'ho122mh6': {
      'vi': 'người đóng góp',
      'en': 'Contributors',
      'ja': '貢献者',
    },
    '7re9w4ie': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホームページ',
    },
  },
  // Home
  {
    'szt8kti9': {
      'vi': 'Mạng xã hội',
      'en': 'Social Media',
      'ja': 'ソーシャルネットワ',
    },
    'y5u9jda9': {
      'vi': 'Truy lùng điểm xám',
      'en': 'Hunt for gray spots',
      'ja': '灰色の斑点を探す',
    },
    '3pkb62bz': {
      'vi': 'Giới thiệu bạn bè',
      'en': 'Introduce to friend',
      'ja': '友達に紹介',
    },
    'c55tus5s': {
      'vi': 'Trạm xanh đổi rác',
      'en': 'Green station for trash exchange',
      'ja': 'ゴミ交換所「みどりのステーション」',
    },
    'om8xlszo': {
      'vi': 'Hướng dẫn phân loại rác',
      'en': 'Instructions for classifying waste',
      'ja': '廃棄物の分別手順',
    },
    'ocq49wez': {
      'vi': 'Tại Trạm xanh',
      'en': 'At Green Station',
      'ja': '緑の駅で',
    },
    'hn3fy1on': {
      'vi': 'GIỚI THIỆU BẠN BÈ',
      'en': 'iNTRODUCE TO YOUR FRIEND',
      'ja': 'お友達に紹介してください',
    },
    '72ncyuv6': {
      'vi': 'Điểm thưởng NHÂN ĐÔI',
      'en': 'DOUBLE bonus points',
      'ja': 'ボーナスポイント2倍',
    },
    'o0hgdn46': {
      'vi': 'ĐỔI ĐIỂM',
      'en': 'EXCHANGE POINTS',
      'ja': '交換ポイント',
    },
    'vokt8nwa': {
      'vi': 'lấy',
      'en': 'take',
      'ja': '取る',
    },
    'efh1xt0h': {
      'vi': 'QUÀ XANH',
      'en': 'GREEN GIFT',
      'ja': 'グリーンギフト',
    },
    'o73h1z6w': {
      'vi': 'PODCAST',
      'en': 'PODCAST',
      'ja': 'ポッドキャスト',
    },
    '26rcybdd': {
      'vi': 'Xem Thêm',
      'en': 'See more',
      'ja': '詳細を見る',
    },
    'x6dkvzil': {
      'vi': '#8 Những nhân vật đổi mới thủ phủ thanh long',
      'en': '#8 Characters who innovated the dragon capital',
      'ja': '#8 竜都を革新した登場人物たち',
    },
    'gmdsyqgy': {
      'vi': '#7 EN Youth Water Innovation',
      'en': '#7 EN Youth Water Innovation',
      'ja': '#7 EN 青少年水イノベーション',
    },
    'iui9fivf': {
      'vi': '#6 EN Vietnamese Gen Z-ers: Action for A Future Wort',
      'en': '#6 EN Vietnamese Gen Z-ers: Action for A Future Wort',
      'ja': '#6 JP ベトナムの Z 世代: 未来の麦汁のための行動',
    },
    'zq3qp5or': {
      'vi': '#9 Những nhân vật đổi mới thủ phủ thanh long',
      'en': '#9 Characters who innovated the THANH LONG capital',
      'ja': '#9 タンロンの首都を革新したキャラクターたち',
    },
    'wfag6bwb': {
      'vi': '#10Những nhân vật đổi mới thủ phủ thanh long',
      'en': '#10 Characters who innovated the THANH LONG capital',
      'ja': '#10 タンロンの首都を革新したキャラクターたち',
    },
    'ngbpwr1d': {
      'vi': '#11 Những nhân vật đổi mới thủ phủ thanh long',
      'en': '#11 Characters who innovated the THANH LONG capital',
      'ja': '#11 タンロンの首都を革新したキャラクターたち',
    },
    'ac2hag78': {
      'vi': 'QUÀ XANH',
      'en': 'GREEN GIFT',
      'ja': 'グリーンギフト',
    },
    'cccjgwma': {
      'vi': 'ĐA DẠNG',
      'en': 'DIVERSITY',
      'ja': '多様性',
    },
    'g91q6t9z': {
      'vi': 'QUÀ XANH',
      'en': 'GREEN GIFT',
      'ja': 'グリーンギフト',
    },
    'mo7kw4ng': {
      'vi': 'Ý NGHĨA',
      'en': 'MEANING',
      'ja': '意味',
    },
    'ce3d0459': {
      'vi': 'CHUNG TAY',
      'en': 'JOIN HANDS',
      'ja': '手と手',
    },
    'wx17n1mz': {
      'vi': 'ĐÓNG GÓP XANH',
      'en': 'GREEN CONTRIBUTION',
      'ja': '環境への貢献',
    },
    'z2cugm6d': {
      'vi': 'Xem Thêm',
      'en': 'See more',
      'ja': '詳細を見る',
    },
    '4uo16j0a': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホーム',
    },
  },
  // ChuyenDiem
  {
    'vkhv0ex0': {
      'vi': 'Chuyển điểm',
      'en': 'Point Transfer',
      'ja': 'ポイント移行',
    },
    'stm4hgco': {
      'vi': 'Số tài khoản EcoFuturia',
      'en': 'EcoFuturia account number',
      'ja': 'EcoFuturia アカウント番号',
    },
    '7q7xaq1o': {
      'vi': 'Điểm hiện có',
      'en': 'Existing points',
      'ja': '既存ポイント',
    },
    'hh287jrf': {
      'vi': 'Mã QR của bạn',
      'en': 'Your QR code',
      'ja': 'あなたのQRコード',
    },
    'lznytn96': {
      'vi': 'Thông tin người được chuyển điểm',
      'en': 'Information on the person whose points are transferred',
      'ja': 'ポイント移行される方の情報',
    },
    'd28dpq8t': {
      'vi': 'Số tài khoản/Điện thoại/Email',
      'en': 'Account number/Phone/Email',
      'ja': '口座番号/電話番号/メールアドレス',
    },
    'ya2130c6': {
      'vi': 'Hủy',
      'en': 'Cancel',
      'ja': 'キャンセル',
    },
    'nckazxqo': {
      'vi': 'Số điểm muốn chuyển mỗi người',
      'en': 'The number of points you want to transfer per person',
      'ja': '1人あたりの移行したいポイント数',
    },
    'qimkr9w8': {
      'vi': 'Nhập số điểm bạn muốn chuyển',
      'en': ' Number of points you want to transfer',
      'ja': '移行したいポイント数',
    },
    'a7ilvle6': {
      'vi': 'Lời nhắn xanh cho người được chuyển điểm',
      'en': 'Green message for the person whose points are transferred',
      'ja': 'ポイント移行対象者への緑色のメッセージ',
    },
    '0r4n038l': {
      'vi': 'Messages',
      'en': 'Messages',
      'ja': 'メッセージ',
    },
    '5zdxqz5z': {
      'vi': '   ',
      'en': '',
      'ja': '',
    },
    'oro7q89i': {
      'vi': 'Tiếp theo',
      'en': 'Next',
      'ja': '次',
    },
    'csthigi7': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホーム',
    },
  },
  // LoginPage
  {
    'r5mru2zq': {
      'vi': 'Create Account',
      'en': 'Create Account',
      'ja': 'アカウントを作成',
    },
    'k9nr60rj': {
      'vi': 'Create Account',
      'en': 'Create Account',
      'ja': 'アカウントを作成',
    },
    '0pi1bx6h': {
      'vi': 'Let\'s get started by filling out the form below.',
      'en': 'Let\'s get started by filling out the form below.',
      'ja': '以下のフォームに記入して始めましょう。',
    },
    'rnc8dz1l': {
      'vi': 'Email',
      'en': 'Email',
      'ja': 'Eメール',
    },
    '5pg3zbo4': {
      'vi': 'Password',
      'en': 'Password',
      'ja': 'パスワード',
    },
    'gdmd2jjz': {
      'vi': 'Confirm Password',
      'en': 'Confirm Password',
      'ja': 'パスワードを認証',
    },
    'rvtuiug5': {
      'vi': 'Get Started',
      'en': 'Get Started',
      'ja': '始めましょう',
    },
    'awimnz4p': {
      'vi': 'Log In',
      'en': 'Log In',
      'ja': 'ログイン',
    },
    'zpx8vf48': {
      'vi': 'Welcome Back',
      'en': 'Welcome Back',
      'ja': 'おかえり',
    },
    'lgevhoqc': {
      'vi': 'Fill out the information below in order to access your account.',
      'en': 'Fill out the information below in order to access your account.',
      'ja': 'アカウントにアクセスするには、以下の情報を入力してください。',
    },
    '3g1c1zsn': {
      'vi': 'Email',
      'en': 'Email',
      'ja': 'Eメール',
    },
    '6d9z215v': {
      'vi': 'Password',
      'en': 'Password',
      'ja': 'パスワード',
    },
    '87u5g4xz': {
      'vi': 'Sign In',
      'en': 'Sign In',
      'ja': 'サインイン',
    },
    '3bdebfrm': {
      'vi': 'Trang chủ ',
      'en': 'Home',
      'ja': 'ホームページ',
    },
  },
  // profileEdit
  {
    '3fze7zd9': {
      'vi': 'Your Name',
      'en': 'Your Name',
      'ja': 'あなたの名前',
    },
    'dk3ujxrs': {
      'vi': 'Phone Number',
      'en': 'Phone Number',
      'ja': '電話番号',
    },
    'r6gabmcl': {
      'vi': 'State',
      'en': 'State',
      'ja': '市',
    },
    '8t7b6cac': {
      'vi': 'State',
      'en': 'State',
      'ja': '市',
    },
    'v3rkux0a': {
      'vi': 'An Giang',
      'en': 'Alabama',
      'ja': '北海道',
    },
    'rtntri4c': {
      'vi': 'Bà Rịa-Vũng Tàu',
      'en': 'Alaska',
      'ja': '青森県',
    },
    'y68x53by': {
      'vi': 'Bắc Giang',
      'en': 'Arizona',
      'ja': '\t岩手県',
    },
    'zwticugz': {
      'vi': 'Bắc Kạn',
      'en': 'Arkansas',
      'ja': '秋田県',
    },
    '8uznlpdf': {
      'vi': 'Bạc Liêu',
      'en': 'California',
      'ja': '\t宮城県',
    },
    '9emfqph4': {
      'vi': 'Bắc Ninh',
      'en': '',
      'ja': '秋田県',
    },
    '00j5827i': {
      'vi': 'Bến Tre',
      'en': '',
      'ja': '\t山形県',
    },
    'ru7x3iil': {
      'vi': 'Bình Định',
      'en': '',
      'ja': '福島県',
    },
    'k6ojhj00': {
      'vi': 'Bình Dương',
      'en': '',
      'ja': '茨城県',
    },
    'kjrl5ylr': {
      'vi': 'Bình Phước',
      'en': '',
      'ja': '\t栃木県',
    },
    'e51a2igw': {
      'vi': 'Bình Thuận',
      'en': '',
      'ja': '\t群馬県',
    },
    'a26l8ngq': {
      'vi': 'Cà Mau',
      'en': '',
      'ja': '埼玉県',
    },
    '55bu6csa': {
      'vi': 'Cần Thơ',
      'en': '',
      'ja': '\t千葉県',
    },
    '1hc16tv6': {
      'vi': 'Cao Bằng',
      'en': '',
      'ja': '\t東京都',
    },
    '8rakyijl': {
      'vi': 'Đà Nẵng',
      'en': '',
      'ja': '神奈川県',
    },
    'krxz9ap3': {
      'vi': 'Đắk Lắk',
      'en': '',
      'ja': '新潟県',
    },
    '3s3ogwh9': {
      'vi': 'Đắk Nông',
      'en': '',
      'ja': '富山県',
    },
    '0z7anolr': {
      'vi': 'Điện Biên',
      'en': '',
      'ja': '石川県',
    },
    'zrr5cwyg': {
      'vi': 'Đồng Nai',
      'en': '',
      'ja': '福井県',
    },
    'k9z9tjrk': {
      'vi': 'Đồng Nai',
      'en': '',
      'ja': '山梨県',
    },
    'url2snaj': {
      'vi': 'Gia Lai',
      'en': '',
      'ja': '長野県',
    },
    '6kgwayvm': {
      'vi': 'Gia Lai',
      'en': '',
      'ja': '岐阜県',
    },
    'paovpe0d': {
      'vi': 'Hà Nam',
      'en': '',
      'ja': '\t静岡県',
    },
    '7x12ckun': {
      'vi': 'Hà Nội',
      'en': '',
      'ja': '愛知県',
    },
    'g3j0s0wl': {
      'vi': 'Hà Tĩnh',
      'en': '',
      'ja': '三重県',
    },
    'ft506754': {
      'vi': 'Hải Dương',
      'en': '',
      'ja': '\t滋賀県',
    },
    'yhsp8ngf': {
      'vi': 'Hải Phòng',
      'en': '',
      'ja': '京都府',
    },
    'vfdzgwii': {
      'vi': 'Hậu Giang',
      'en': '',
      'ja': '大阪府',
    },
    'gxu78yah': {
      'vi': 'TP. Hồ Chí Minh',
      'en': '',
      'ja': '兵庫県',
    },
    'rnzemd7b': {
      'vi': 'New Jersey',
      'en': '',
      'ja': '\t奈良県',
    },
    'hn6kc215': {
      'vi': 'New Mexico',
      'en': '',
      'ja': '和歌山県',
    },
    'l4chqrgz': {
      'vi': 'Hòa Bình',
      'en': '',
      'ja': '\t鳥取県',
    },
    'sfic14z1': {
      'vi': 'North Carolina',
      'en': '',
      'ja': '島根県',
    },
    'gku7bi3d': {
      'vi': 'Khánh Hòa',
      'en': '',
      'ja': '\t岡山県',
    },
    '6vfdm6j1': {
      'vi': 'Kiên Giang',
      'en': '',
      'ja': '\t広島県',
    },
    'wsvo6v5m': {
      'vi': 'Kon Tum',
      'en': '',
      'ja': '山口県',
    },
    '57wzn5od': {
      'vi': 'Lai Châu',
      'en': '',
      'ja': '\t徳島県',
    },
    'ljiq41r0': {
      'vi': 'Lâm Đồng',
      'en': '',
      'ja': '香川県',
    },
    '5wpnnxsy': {
      'vi': 'Lạng Sơn',
      'en': '',
      'ja': '\t愛媛県',
    },
    'tsokm11x': {
      'vi': 'Lào Cai',
      'en': '',
      'ja': '\t高知県',
    },
    'nr25kuos': {
      'vi': 'Long An',
      'en': '',
      'ja': '福岡県',
    },
    'w5tbhr5p': {
      'vi': 'Nam Định',
      'en': '',
      'ja': '福岡県',
    },
    '3vv6kfr5': {
      'vi': 'Nghệ An',
      'en': '',
      'ja': '\t長崎県',
    },
    'yusc4mba': {
      'vi': 'Ninh Bình',
      'en': '',
      'ja': '熊本県',
    },
    'ejfsiy1j': {
      'vi': 'Ninh Thuận',
      'en': '',
      'ja': '大分県',
    },
    'hjo0klqi': {
      'vi': 'Phú Thọ',
      'en': '',
      'ja': '\t宮崎県',
    },
    'mmqab0yb': {
      'vi': 'Phú Yên',
      'en': '',
      'ja': '鹿児島県',
    },
    'c3p7925y': {
      'vi': 'Quảng Bình',
      'en': '',
      'ja': '沖縄県',
    },
    'ktu4h8we': {
      'vi': 'Quảng Nam',
      'en': '',
      'ja': '',
    },
    'fevvhbsq': {
      'vi': 'Quảng Ngãi',
      'en': '',
      'ja': '',
    },
    '8dm4k4pn': {
      'vi': 'Quảng Ninh',
      'en': '',
      'ja': '',
    },
    'gicm68y0': {
      'vi': 'Mô tả',
      'en': 'Bio',
      'ja': 'バイオ',
    },
    '2tknojc9': {
      'vi': 'Lưu',
      'en': 'Save',
      'ja': 'Save',
    },
    '1c6ztzsv': {
      'vi': 'Thiết lập thông tin cá nhân',
      'en': 'Set up personal information',
      'ja': '個人情報の設定',
    },
  },
  // profilePage
  {
    'ehvfh3ol': {
      'vi': 'Thành tích tháng 4',
      'en': 'April achievements',
      'ja': '4月の成果',
    },
    'd4y9vni0': {
      'vi': 'Điểm tích lũy',
      'en': 'Accumulated points',
      'ja': '累計ポイント',
    },
    'hbh540za': {
      'vi': 'Hành động xanh',
      'en': 'Green action',
      'ja': 'グリーンアクション',
    },
    '4nkw13n3': {
      'vi': '0',
      'en': '0',
      'ja': '0',
    },
    'eh6l72o6': {
      'vi': 'Nhóm EcoFuturía',
      'en': 'EcoFuturía group',
      'ja': 'エコフューチュリアグループ',
    },
    'qbdzuns5': {
      'vi': 'Chưa tham gia bất kì nhóm nào',
      'en': 'Haven\'t joined any groups yet',
      'ja': 'まだグループに参加していません',
    },
    'smen2ueo': {
      'vi': 'Tham gia nhóm',
      'en': 'Join group',
      'ja': 'グループに参加',
    },
    '25xwex1a': {
      'vi': 'Lịch sử hoạt động',
      'en': 'Activity history',
      'ja': '活動履歴',
    },
    's7vjqtga': {
      'vi': 'Điểm tích lũy',
      'en': 'Accumulated points',
      'ja': '累計ポイント',
    },
    '49gsg3im': {
      'vi': 'Hành động xanh',
      'en': 'Green action',
      'ja': 'グリーンアクション',
    },
    'bbm2ndi8': {
      'vi': '0',
      'en': '0',
      'ja': '0',
    },
    '0om5n9r1': {
      'vi': 'Qùa xanh đã đổi',
      'en': 'The green gift has changed',
      'ja': 'グリーンギフトが変わりました',
    },
    'e71nqkxh': {
      'vi': 'Tài Khoản',
      'en': 'Account',
      'ja': 'アカウント',
    },
  },
  // profileOptions
  {
    'he6wz70z': {
      'vi': 'Đổi thông tin cá nhân',
      'en': 'Change personal information',
      'ja': '個人情報の変更',
    },
    'gwcfgk5j': {
      'vi': 'Quà xanh của tôi',
      'en': 'My green gift',
      'ja': '私の緑の贈り物',
    },
    'nzgjtk1u': {
      'vi': 'Giới thiệu EcoFuturía',
      'en': 'Introducing EcoFuturía',
      'ja': 'EcoFuturía の紹介',
    },
    'pb4ja5gw': {
      'vi': 'Đăng xuất',
      'en': 'Log out',
      'ja': 'ログアウト',
    },
    'i4qmoeot': {
      'vi': 'Cài đặt',
      'en': 'Setting',
      'ja': '設定',
    },
    'f62oax4p': {
      'vi': 'Tài Khoản',
      'en': 'Account',
      'ja': 'アカウント',
    },
  },
  // changePass
  {
    'm437aoz8': {
      'vi': 'Mật khẩu hiện tại',
      'en': '',
      'ja': '',
    },
    'q2bq5tvc': {
      'vi': 'Mật khẩu mới',
      'en': '',
      'ja': '',
    },
    'khgp8aik': {
      'vi': 'Nhập lại mật khẩu mới',
      'en': '',
      'ja': '',
    },
    'wbceh6as': {
      'vi': 'Cập nhật',
      'en': '',
      'ja': '',
    },
    'o1wqru8f': {
      'vi': 'Thay đổi mật khẩu',
      'en': '',
      'ja': '',
    },
    'sjp5357h': {
      'vi': 'Home',
      'en': '',
      'ja': '',
    },
  },
  // mygift
  {
    'bsywrzwa': {
      'vi': 'Quà xanh của tôi',
      'en': 'My green gift',
      'ja': '私の緑の贈り物',
    },
    'rlkdxys4': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホームページ',
    },
  },
  // gthieu
  {
    'e89upffe': {
      'vi': 'GIỚI THIỆU ECOFUTURÍA',
      'en': 'INTRODUCING ECOFUTURÍA',
      'ja': 'エコフトゥールサのご紹介',
    },
    '7j7fnvco': {
      'vi': 'TRIẾT LÝ HOẠT ĐỘNG',
      'en': 'OPERATIONAL PHILOSOPHY',
      'ja': '運営理念',
    },
    '9iw2g4l0': {
      'vi':
          'Chúng tôi tin rằng sự ghi nhận và tri ân cộng đồng là động lực khuyến khích mỗi cá nhân xanh hơn 1% mỗi ngày',
      'en':
          'We believe that community recognition and gratitude is the driving force that encourages each individual to be 1% greener every day',
      'ja': '私たちは、コミュニティの認識と感謝が、各個人が毎日 1% 環境に優しい生活を送れるよう促す原動力であると信じています。',
    },
    'pm2sgsjw': {
      'vi':
          'EcoFuturía là ứng dụng di động tặng điểm thưởng xanh cho mỗi hành động xanh. Với niềm tin vào mầm xanh phụng sự trong mỗi chúng ta - là lòng biết ơn với thiên nhiên và mong muốn hành động vì tương lai bền vững, EcoFuturía xin được ở lại trong chiếc điện thoại nhỏ bé để làm nhiệm vụ kết nối bạn bè với cộng đồng sống xanh ngoài kia, mong sao bạn sẽ tận hưởng một hành trình sống xanh thú vị, ý nghĩa và tràn đầy nhiệt huyết. ',
      'en':
          'EcoFuturía is a mobile app that gives green reward points for every green action. With the belief in the green germ that serves each of us - gratitude to nature and the desire to act for a sustainable future, EcoFuturía would like to stay in the small phone to do the task of connecting friends. With the green living community out there, I hope you will enjoy an exciting, meaningful and enthusiastic green living journey.',
      'ja':
          'EcoFuturía は、すべての環境に優しいアクションに対してグリーン報酬ポイントを与えるモバイル アプリです。 EcoFuturía は、自然への感謝と持続可能な未来に向けて行動したいという願望という、私たち一人ひとりに役立つ緑の芽への信念を持って、小さな電話の中にいて友人たちとつながる仕事をしたいと考えています。グリーン リビング コミュニティが存在するので、エキサイティングで有意義で熱心なグリーン リビングの旅を楽しんでいただければ幸いです。',
    },
    'ce2pmc3c': {
      'vi': 'SỨ MỆNH',
      'en': 'MISSION',
      'ja': 'ミッション',
    },
    'c0r3oy9m': {
      'vi':
          'EcoFuturía kết nối những hoạt động xanh, thôi thúc mỗi người hành động xanh ngay hôm nay, từ đó \"nhân đôi\" hiệu ứng xanh và lan tỏa trong cộng đồng.',
      'en':
          'EcoFuturía connects green activities, urging each person to act green today, thereby \"doubling\" the green effect and spreading it in the community.',
      'ja':
          'EcoFuturía はグリーン活動を結びつけ、今日から各人がグリーンに行動するよう促し、それによってグリーン効果を「倍増」させ、それをコミュニティに広めます。',
    },
    'h2zp9l9g': {
      'vi': 'MÔ TẢ TÍNH NĂNG',
      'en': 'FEATURE DESCRIPTION',
      'ja': '機能の説明',
    },
    'ofn5qn5x': {
      'vi':
          'Theo như dự án của chúng tôi, khi sử dụng ứng dụng bạn có thể: mời bạn bè tham gia, cùng nhận điểm GP hấp dẫn, tặng điểm cho ai đó để tri ân nổ lực sống xanh của họ, ủng hộ điểm GP cho các dự án cộng đồng, và đổi GP lấy những món quà xanh, tự thưởng cho chính mình.',
      'en':
          'According to our project, when using the application you can: invite friends to join, receive attractive GP points, give points to someone to appreciate their green living efforts, support GP points for others. community projects, and exchange GP for green gifts, reward yourself.',
      'ja':
          '私たちのプロジェクトによると、このアプリケーションを使用すると、友人を参加に招待したり、魅力的な GP ポイントを受け取ったり、グリーンな生活の取り組みを評価するために誰かにポイントを与えたり、他の人の GP ポイントをサポートしたりすることができます。コミュニティ プロジェクトに参加したり、GP をグリーン ギフトと交換したりして、自分へのご褒美にしましょう。',
    },
    'ki6n2v7v': {
      'vi': 'HỖ TRỢ',
      'en': 'SUPPORT',
      'ja': 'サポート',
    },
    'f4dzn4v6': {
      'vi':
          'Chúng tôi sẽ nỗ lực hoàn thiện sản phẩm từng ngày. Nếu gặp khó khăn trong quá trình sử dụng app, hãy kiên nhẫn và thông báo cho chúng tôi qua email: contact.EcoFuturía@gmail.com',
      'en':
          'We will strive to improve the product every day. If you have difficulty using the app, please be patient and notify us via email: contact.EcoFuturía@gmail.com',
      'ja':
          '日々製品の改善に努めてまいります。アプリの使用に問題がある場合は、しばらくお待ちください。contact.EcoFuturía@gmail.com まで電子メールでご連絡ください。',
    },
    'nz7p8oun': {
      'vi': 'Trải nghiệm ngay',
      'en': 'Experience now',
      'ja': '今すぐ体験してください',
    },
    'atz2s678': {
      'vi': 'Trang chủ ',
      'en': 'Home',
      'ja': 'ホームページ',
    },
  },
  // shopGift
  {
    '8hcujpfu': {
      'vi': 'Quà xanh',
      'en': 'Green gift',
      'ja': 'グリーンギフト',
    },
    '2y23u6k4': {
      'vi': '',
      'en': '',
      'ja': '',
    },
  },
  // chonNhom
  {
    'rcq4bbde': {
      'vi': 'Tìm kiếm',
      'en': 'Search',
      'ja': '検索',
    },
    'vv2lyb0e': {
      'vi': 'Danh sách hội nhóm',
      'en': 'List of groups',
      'ja': 'グループ一覧',
    },
    'katzi4sx': {
      'vi': 'EcoFuturía',
      'en': 'EcoFuturía',
      'ja': 'エコフューチュリア',
    },
    'tfw6nclz': {
      'vi': '19 thành viên',
      'en': '19 members',
      'ja': 'メンバー19名',
    },
    '9t189b4t': {
      'vi': 'Tham gia',
      'en': 'Join',
      'ja': '参加する',
    },
    'i6myozje': {
      'vi': 'Green DaNang',
      'en': 'Green DaNang',
      'ja': 'グリーン ダナン',
    },
    '6a6k871r': {
      'vi': '3 thành viên',
      'en': '3 members',
      'ja': 'メンバー3名',
    },
    '1fst8cg1': {
      'vi': 'Tham gia',
      'en': 'Join',
      'ja': '参加する',
    },
    'ojpr0tuc': {
      'vi': 'green Office',
      'en': 'green Office',
      'ja': 'グリーンオフィス',
    },
    'esoauvw9': {
      'vi': '3 thành viên',
      'en': '3 members',
      'ja': 'メンバー3名',
    },
    'p8etfb4c': {
      'vi': 'Tham gia',
      'en': 'Join',
      'ja': '参加する',
    },
    'k2fabbu6': {
      'vi': 'WildAct',
      'en': 'WildAct',
      'ja': 'ワイルドアクト',
    },
    'atd7mrxa': {
      'vi': '5 thành viên',
      'en': '5 members',
      'ja': 'メンバー5名',
    },
    'y8yj6t6s': {
      'vi': 'Tham gia',
      'en': 'Join',
      'ja': '参加する',
    },
    'o8i88201': {
      'vi': 'VINES',
      'en': 'VINES',
      'ja': 'ヴァインズ',
    },
    'vm81ypzq': {
      'vi': '8 thành viên',
      'en': '8 members',
      'ja': 'メンバー8名',
    },
    'lmupar68': {
      'vi': 'Tham gia',
      'en': 'Join',
      'ja': '参加する',
    },
    'pw4hwuwb': {
      'vi': 'Chọn nhóm',
      'en': 'Select group',
      'ja': 'グループを選択',
    },
    '1edzxxuh': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホームページ',
    },
  },
  // ranking
  {
    '86do217f': {
      'vi': 'Bảng xếp hạng điểm tích lũy',
      'en': 'Cumulative points rankings',
      'ja': '累計ポイントランキング',
    },
    '2t6qg3wv': {
      'vi': 'Xếp Hạng',
      'en': 'Ranking',
      'ja': 'ランキング',
    },
  },
  // changeProfile
  {
    'a59krpzx': {
      'vi': 'Your Name',
      'en': '',
      'ja': '',
    },
    '6rz5fz5q': {
      'vi': 'Phone Number',
      'en': '',
      'ja': '',
    },
    'y6mlokle': {
      'vi': 'State',
      'en': 'State',
      'ja': '市',
    },
    'ctgl65ec': {
      'vi': 'State',
      'en': 'State',
      'ja': '市',
    },
    'j9zbqhk2': {
      'vi': 'An Giang',
      'en': 'Alabama',
      'ja': '北海道',
    },
    'ml5id8is': {
      'vi': 'Bà Rịa-Vũng Tàu',
      'en': 'Alaska',
      'ja': '青森県',
    },
    'oakqbh3s': {
      'vi': 'Bắc Giang',
      'en': 'Arizona',
      'ja': '\t岩手県',
    },
    'ijn74yg8': {
      'vi': 'Bắc Kạn',
      'en': 'Arkansas',
      'ja': '秋田県',
    },
    'c42qqi38': {
      'vi': 'Bạc Liêu',
      'en': 'California',
      'ja': '\t宮城県',
    },
    'ye63dvt7': {
      'vi': 'Bắc Ninh',
      'en': '',
      'ja': '秋田県',
    },
    'tp7trcbv': {
      'vi': 'Bến Tre',
      'en': '',
      'ja': '\t山形県',
    },
    'xk36kchs': {
      'vi': 'Bình Định',
      'en': '',
      'ja': '福島県',
    },
    'w528ate2': {
      'vi': 'Bình Dương',
      'en': '',
      'ja': '茨城県',
    },
    'oa49puuq': {
      'vi': 'Bình Phước',
      'en': '',
      'ja': '\t栃木県',
    },
    'jyvzlaep': {
      'vi': 'Bình Thuận',
      'en': '',
      'ja': '\t群馬県',
    },
    'hm295h4l': {
      'vi': 'Cà Mau',
      'en': '',
      'ja': '埼玉県',
    },
    'xv5u7tf0': {
      'vi': 'Cần Thơ',
      'en': '',
      'ja': '\t千葉県',
    },
    'llmqpxqr': {
      'vi': 'Cao Bằng',
      'en': '',
      'ja': '\t東京都',
    },
    'jd8fmiwo': {
      'vi': 'Đà Nẵng',
      'en': '',
      'ja': '神奈川県',
    },
    '4e33jcvp': {
      'vi': 'Đắk Lắk',
      'en': '',
      'ja': '新潟県',
    },
    '312eg6va': {
      'vi': 'Đắk Nông',
      'en': '',
      'ja': '富山県',
    },
    'gnuf18xt': {
      'vi': 'Điện Biên',
      'en': '',
      'ja': '石川県',
    },
    '0okm5lpr': {
      'vi': 'Đồng Nai',
      'en': '',
      'ja': '福井県',
    },
    '8xy54c9h': {
      'vi': 'Đồng Nai',
      'en': '',
      'ja': '山梨県',
    },
    'cs18k2fm': {
      'vi': 'Gia Lai',
      'en': '',
      'ja': '長野県',
    },
    'i9cp7mf8': {
      'vi': 'Gia Lai',
      'en': '',
      'ja': '岐阜県',
    },
    'p1j72mkm': {
      'vi': 'Hà Nam',
      'en': '',
      'ja': '\t静岡県',
    },
    '4zq5q6b3': {
      'vi': 'Hà Nội',
      'en': '',
      'ja': '愛知県',
    },
    'iowatj1k': {
      'vi': 'Hà Tĩnh',
      'en': '',
      'ja': '三重県',
    },
    'swc1na8n': {
      'vi': 'Hải Dương',
      'en': '',
      'ja': '\t滋賀県',
    },
    'byi5300m': {
      'vi': 'Hải Phòng',
      'en': '',
      'ja': '京都府',
    },
    'zdjb4ou8': {
      'vi': 'Hậu Giang',
      'en': '',
      'ja': '大阪府',
    },
    '0mc4x29e': {
      'vi': 'TP. Hồ Chí Minh',
      'en': '',
      'ja': '兵庫県',
    },
    '5m5as6cz': {
      'vi': 'New Jersey',
      'en': '',
      'ja': '\t奈良県',
    },
    '504kmmft': {
      'vi': 'New Mexico',
      'en': '',
      'ja': '和歌山県',
    },
    '4762kvp2': {
      'vi': 'Hòa Bình',
      'en': '',
      'ja': '\t鳥取県',
    },
    'd19nr4mi': {
      'vi': 'North Carolina',
      'en': '',
      'ja': '島根県',
    },
    'hllyyupp': {
      'vi': 'Khánh Hòa',
      'en': '',
      'ja': '\t岡山県',
    },
    'fpju2q90': {
      'vi': 'Kiên Giang',
      'en': '',
      'ja': '\t広島県',
    },
    '5dp7ypl3': {
      'vi': 'Kon Tum',
      'en': '',
      'ja': '山口県',
    },
    'ahbpjgga': {
      'vi': 'Lai Châu',
      'en': '',
      'ja': '\t徳島県',
    },
    'bjfetk72': {
      'vi': 'Lâm Đồng',
      'en': '',
      'ja': '香川県',
    },
    '0e832ech': {
      'vi': 'Lạng Sơn',
      'en': '',
      'ja': '\t愛媛県',
    },
    '3ux7it6c': {
      'vi': 'Lào Cai',
      'en': '',
      'ja': '\t高知県',
    },
    '3pn49k5z': {
      'vi': 'Long An',
      'en': '',
      'ja': '福岡県',
    },
    'okzc7l70': {
      'vi': 'Nam Định',
      'en': '',
      'ja': '福岡県',
    },
    'uurvajhn': {
      'vi': 'Nghệ An',
      'en': '',
      'ja': '\t長崎県',
    },
    'gopdjgvf': {
      'vi': 'Ninh Bình',
      'en': '',
      'ja': '熊本県',
    },
    'jlg2lexp': {
      'vi': 'Ninh Thuận',
      'en': '',
      'ja': '大分県',
    },
    'z081r46y': {
      'vi': 'Phú Thọ',
      'en': '',
      'ja': '\t宮崎県',
    },
    'uov5m3ra': {
      'vi': 'Phú Yên',
      'en': '',
      'ja': '鹿児島県',
    },
    '8coqvhi6': {
      'vi': 'Quảng Bình',
      'en': '',
      'ja': '沖縄県',
    },
    'x3jur1no': {
      'vi': 'Quảng Nam',
      'en': '',
      'ja': '',
    },
    'k2ixem7y': {
      'vi': 'Quảng Ngãi',
      'en': '',
      'ja': '',
    },
    'rsai1bkl': {
      'vi': 'Quảng Ninh',
      'en': '',
      'ja': '',
    },
    'sbrm61sw': {
      'vi': 'Your bio',
      'en': '',
      'ja': '',
    },
    'tc5a7s1v': {
      'vi': 'Cập nhật',
      'en': '',
      'ja': '',
    },
    '45e6kbnt': {
      'vi': 'Chỉnh sửa thông tin cá nhân',
      'en': '',
      'ja': '',
    },
  },
  // podcastTheme
  {
    '6phl7sxi': {
      'vi': '100 điều nhỏ nhặt tớ làm cho Trái Đất',
      'en': '100 small things I do for the Earth',
      'ja': '地球のために私がしている 100 の小さなこと',
    },
    'aqlqj005': {
      'vi': 'Hẻm radio xanh',
      'en': 'Green radio alley',
      'ja': '緑のラジオ横丁',
    },
    'vs5lhbvm': {
      'vi': 'Rethink Your Business Models',
      'en': 'Rethink Your Business Models',
      'ja': 'ビジネスモデルを再考する',
    },
    '3y58g296': {
      'vi': 'EcoFuturia- Xanh shop',
      'en': 'EcoFuturia- Xanh shop',
      'ja': 'EcoFuturia-ザンショップ',
    },
    'npbxcali': {
      'vi': 'UNDP Viet Nam',
      'en': 'UNDP Viet Nam',
      'ja': 'ベトナムのUNDP',
    },
    '0vrugiao': {
      'vi': 'Podcast Series',
      'en': 'Podcast Series',
      'ja': 'ポッドキャストシリーズ',
    },
    'pidkb3vk': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホームページ',
    },
  },
  // podcast100dieu
  {
    '6s9aeq3b': {
      'vi': 'Podcast Series',
      'en': 'Podcast Series',
      'ja': 'ポッドキャストシリーズ',
    },
    '8j6xew74': {
      'vi': '100 ĐIỀU NHỎ NHẶT TỚ LÀM CHO TRÁI ĐẤT',
      'en': '100 SMALL THINGS I DO FOR THE EARTH',
      'ja': '地球のために私がしている 100 の小さなこと',
    },
    'knfe85tq': {
      'vi': '5 Tập',
      'en': '5 Vol',
      'ja': '5巻',
    },
    '8i36n2j3': {
      'vi': 'Hành động bổ sung: Hãy tưới cây vào buổi sáng sớm',
      'en': 'Additional action: Water your plants early in the morning',
      'ja': '追加のアクション: 早朝に植物に水をやる',
    },
    '9exc4jxa': {
      'vi': '28/04/2024 00:00:23',
      'en': '28/04/2024 00:00:23',
      'ja': '28/04/2024 00:00:23',
    },
    'uvnu8ayu': {
      'vi': 'Hành động 98-100: Hãy là một người tử tế',
      'en': 'Actions 98-100: Be a kind person',
      'ja': 'アクション 98 ～ 100: 親切な人になりましょう',
    },
    '3o5kzhla': {
      'vi': '28/04/2024 00:00:59',
      'en': '28/04/2024 00:00:59',
      'ja': '28/04/2024 00:00:59',
    },
    'kher2860': {
      'vi': 'Hành động 94-97 : Không bấm còi xe ầm ĩ',
      'en': 'Action 94-97: Do not honk loudly',
      'ja': 'アクション 94-97: 大声でクラクションを鳴らさない',
    },
    '6bjji3fy': {
      'vi': '28/04/2024 00:05:10',
      'en': '28/04/2024 00:05:10',
      'ja': '28/04/2024 00:05:10',
    },
    'frc0maqv': {
      'vi':
          'Hành động 84-89 : Tiết kiệm rác thôi cũng là cách để bảo  vệ môi trường',
      'en':
          'Action 84-89: Saving trash is also a way to protect the environment',
      'ja': '行動 84-89: ゴミを節約することも環境を保護する方法です',
    },
    '78pu8cwh': {
      'vi': '28/04/2024 00:17:30',
      'en': '28/04/2024 00:17:30',
      'ja': '28/04/2024 00:17:30',
    },
    's6njsc9s': {
      'vi': 'Hành động 66-70 : Tạm biệt những thói quen không bền vững',
      'en': 'Actions 66-70: Say goodbye to unsustainable habits',
      'ja': 'アクション 66 ～ 70: 持続不可能な習慣に別れを告げる',
    },
    'qng4o63v': {
      'vi': '28/04/2024 00:20:10',
      'en': '28/04/2024 00:20:10',
      'ja': '28/04/2024 00:20:10',
    },
    'mh3qvz05': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホームページ',
    },
  },
  // podcastHemxanhradio
  {
    's7iwml7y': {
      'vi': 'Podcast Series',
      'en': 'Podcast Series',
      'ja': 'ポッドキャストシリーズ',
    },
    'n6gz4l2c': {
      'vi': 'Hẻm xanh RADIO',
      'en': 'RADIO Green Alley',
      'ja': 'ラジオ グリーン アレー',
    },
    '0xsv09cw': {
      'vi': '2 Tập',
      'en': '2 Vol',
      'ja': '2巻',
    },
    'lmcbbjel': {
      'vi': 'Ngôi nhà số 2: Một vòng Trái Đất và khách mời Bính Bè',
      'en': 'House number 2: A round of the Earth and guest Binh Be',
      'ja': 'ハウス番号 2: 地球一周とゲストのビン ベ',
    },
    '249ozkbh': {
      'vi': '30/04/2024 06:20:15',
      'en': '30/04/2024 06:20:15',
      'ja': '30/04/2024 06:20:15',
    },
    'odcqy9gq': {
      'vi': 'Ngôi nhà số 1: Uống trà tám chuyện sống xanh',
      'en': 'House number 1: Drinking tea and gossiping about living green',
      'ja': 'ハウスナンバー 1: お茶を飲みながら緑の暮らしについて噂話をする',
    },
    'vtulyiil': {
      'vi': '01/05/2024 15:15:59',
      'en': '01/05/2024 15:15:59',
      'ja': '01/05/2024 15:15:59',
    },
    '4h8na8hn': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホームページ',
    },
  },
  // podcastRethink
  {
    'syfmkn73': {
      'vi': 'Podcast Series',
      'en': 'Podcast Series',
      'ja': 'ポッドキャストシリーズ',
    },
    'wgskrjyt': {
      'vi': 'Podcast Series',
      'en': 'Podcast Series',
      'ja': 'ポッドキャストシリーズ',
    },
    '5h2c8y4g': {
      'vi': '5 Tập',
      'en': '5 Vol',
      'ja': '5巻',
    },
    '2k67fhra': {
      'vi': 'Tập 5: Diệu Anh - Papa\'s Dreamer',
      'en': 'Episode 5: Dieu Anh - Papa\'s Dreamer',
      'ja': 'エピソード 5: デュー・アン - パパの夢想家',
    },
    '1l4sjkq6': {
      'vi': '02/05/2024 13:54:37',
      'en': '02/05/2024 13:54:37',
      'ja': '02/05/2024 13:54:37',
    },
    'qviun22x': {
      'vi': 'Tập 4: Lại đây Refill Station - Nguyễn Dạ Quyên',
      'en': 'Episode 4: Come here Refill Station - Nguyen Da Quyen',
      'ja': 'エピソード 4: こっちに来てください 補給ステーション - グエン・ダ・クエン',
    },
    '38iis0xi': {
      'vi': '28/04/2024 00:00:59',
      'en': '28/04/2024 00:00:59',
      'ja': '28/04/2024 00:00:59',
    },
    '73cqlcpo': {
      'vi': '28/04/2024 00:00:59',
      'en': '28/04/2024 00:00:59',
      'ja': '28/04/2024 00:00:59',
    },
    'ih7z37ox': {
      'vi': '28/04/2024 00:05:10',
      'en': '28/04/2024 00:05:10',
      'ja': '28/04/2024 00:05:10',
    },
    'bz6xn3jh': {
      'vi': 'Tập 2: Re.socks - Hoàng Qúy Bình',
      'en': 'Episode 2: Re.socks - Hoang Quy Binh',
      'ja': 'エピソード 2: Re.socks - ホアン・クイビン',
    },
    'jwhoh8tg': {
      'vi': '28/04/2024 00:17:30',
      'en': '28/04/2024 00:17:30',
      'ja': '28/04/2024 00:17:30',
    },
    '9j7gzqwb': {
      'vi': 'Tập 1: Dòng Dòng Sài Gòn - Trần Kiều Anh',
      'en': 'Volume 1: The Saigon Line - Tran Kieu Anh',
      'ja': '第 1 巻: サイゴンライン - トラン・キエウ・アン',
    },
    'yo36ef09': {
      'vi': '28/04/2024 00:20:10',
      'en': '28/04/2024 00:20:10',
      'ja': '28/04/2024 00:20:10',
    },
    'vddbd8gq': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホームページ',
    },
  },
  // podcastEcoFTRshop
  {
    'gkzmkk1h': {
      'vi': 'Podcast Series',
      'en': 'Podcast Series',
      'ja': 'ポッドキャストシリーズ',
    },
    'ujkuncly': {
      'vi': 'EcoFuturia- Xanh shop',
      'en': 'EcoFuturia- Xanh shop',
      'ja': 'EcoFuturia-ザンショップ',
    },
    '6vjaa5xa': {
      'vi': '3 Tập',
      'en': '3 Vol',
      'ja': '3巻',
    },
    'v9hjnhi2': {
      'vi': 'Phụ lục C: Audio Book_Gieo mầm trên sa mạc',
      'en': 'Appendix C: Audio Book_Sowing seeds in the desert',
      'ja': '付録 C: オーディオブック_砂漠に種をまく',
    },
    'gipnuwn7': {
      'vi': '28/04/2024 00:00:23',
      'en': '28/04/2024 00:00:23',
      'ja': '28/04/2024 00:00:23',
    },
    'j1x8m6cz': {
      'vi': 'Phụ lục B: Audio Book_Gieo mầm trên sa mạc',
      'en': 'Appendix B: Audio Book_Sowing seeds in the desert',
      'ja': '付録 B: オーディオブック_砂漠に種をまく',
    },
    '7w2mjxth': {
      'vi': '28/04/2024 00:00:23',
      'en': '28/04/2024 00:00:23',
      'ja': '28/04/2024 00:00:23',
    },
    '8221wcz4': {
      'vi': 'Phụ lục A: Audio Book_Gieo mầm trên sa mạc',
      'en': 'Appendix A: Audio Book_Sowing seeds in the desert',
      'ja': '付録 A: オーディオブック_砂漠に種をまく',
    },
    '1afltgbw': {
      'vi': '28/04/2024 00:05:10',
      'en': '28/04/2024 00:05:10',
      'ja': '28/04/2024 00:05:10',
    },
    '8orjfssv': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホームページ',
    },
  },
  // podcastUDNPVietnam
  {
    'sq54moh1': {
      'vi': 'Podcast Series',
      'en': 'Podcast Series',
      'ja': 'ポッドキャストシリーズ',
    },
    'h7s9d5tl': {
      'vi': 'UNDP Viet nam - Hậu duệ Hai Bà Trưng',
      'en': 'UNDP Viet Nam - Descendants of Hai Ba Trung',
      'ja': 'UNDPベトナム - ハイ・バー・チュンの子孫',
    },
    '7ln5y1x7': {
      'vi': '4 Tập',
      'en': '4 Vol',
      'ja': '4 巻',
    },
    'hx585hhb': {
      'vi': '#8 Những nhân vật đổi mới trong phủ thanh long',
      'en': '#8 Innovative characters in the thanh long palace',
      'ja': '#8 タインロン宮殿の革新的なキャラクター',
    },
    '8llvca8y': {
      'vi': '02/05/2024 13:54:37',
      'en': '02/05/2024 13:54:37',
      'ja': '02/05/2024 13:54:37',
    },
    't7018bf4': {
      'vi': '#7 EN Your Water Innovation',
      'en': '#7 EN Your Water Innovation',
      'ja': '#7 JA 水のイノベーション',
    },
    'vcm1281g': {
      'vi': '28/04/2024 00:00:59',
      'en': '28/04/2024 00:00:59',
      'ja': '28/04/2024 00:00:59',
    },
    'c84b1rp7': {
      'vi': '#6 EN Vietnamese Gen Z-ers: Action for A Future Worth Living',
      'en': '#6 EN Vietnamese Gen Z-ers: Action for A Future Worth Living',
      'ja': '#6 JP ベトナムの Z 世代: 生きる価値のある未来のための行動',
    },
    'y65iirvv': {
      'vi': '28/04/2024 00:05:10',
      'en': '28/04/2024 00:05:10',
      'ja': '28/04/2024 00:05:10',
    },
    '9k5fi496': {
      'vi': '#5 EN The quiet guardians of Can Gio Forest',
      'en': '#5 EN The quiet guardians of Can Gio Forest',
      'ja': '#5 JP カンザーの森の静かな守り人',
    },
    '0tq15bip': {
      'vi': '28/04/2024 00:17:30',
      'en': '28/04/2024 00:17:30',
      'ja': '28/04/2024 00:17:30',
    },
    '6cdwt2vk': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホームページ',
    },
  },
  // mapXanh
  {
    'bo5a7pq9': {
      'vi': 'Tìm kiếm',
      'en': 'Search',
      'ja': '検索',
    },
    'i9aqub8l': {
      'vi': 'Bản đồ xanh',
      'en': 'Green map',
      'ja': 'グリーンマップ',
    },
    'nkax1inf': {
      'vi': 'Map xanh',
      'en': 'Green map',
      'ja': 'マップ',
    },
  },
  // doiQuaNgay
  {
    'ti2sap6s': {
      'vi': 'Điểm',
      'en': 'Points',
      'ja': 'ポイント',
    },
    'pxf5kjy3': {
      'vi': 'Hình thức nhận',
      'en': 'Receipt At',
      'ja': '受け取り場所',
    },
    'm6sehlpg': {
      'vi': 'Đổi quà tại Trạm Xanh',
      'en': 'Redeem gifts at Green Station',
      'ja': 'グリーンステーションでギフトを引き換える',
    },
    'xzq2zdxj': {
      'vi': 'Đổi quà ngay',
      'en': 'Exchange gifts now',
      'ja': 'Exchange gifts now',
    },
    'hnkrhndi': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホームページ',
    },
  },
  // GioiThieu
  {
    'bd2rrvk6': {
      'vi': 'GIỚI THIỆU BẠN BÈ',
      'en': 'INTRODUCE TO FRIENDS',
      'ja': '友達に紹介する',
    },
    'amxtkh40': {
      'vi': 'Chuyển GP cho bạn và người bạn giới thiệu',
      'en': 'Transfer GP to you and your referral',
      'ja': 'GP をあなたとあなたの紹介者に転送します',
    },
    '38dc58g6': {
      'vi': 'Gửi link đăng kí cho bạn bè nhé!',
      'en': 'Send the registration link to your friends!',
      'ja': '登録リンクを友達に送りましょう！',
    },
    'td8kk6ka': {
      'vi': 'Mã giới thiệu',
      'en': 'Referral code',
      'ja': '紹介コード',
    },
    'bzep4xgm': {
      'vi': 'Copy',
      'en': 'Copy',
      'ja': 'コピー',
    },
    '6bpwimka': {
      'vi': 'Link tải app',
      'en': 'Link to download the app',
      'ja': 'アプリをダウンロードするためのリンク',
    },
    'xg44psrj': {
      'vi': 'https://drive.google.com/drive......',
      'en':
          'https://drive.google.com/drive/folders/18UjQPlagMivbnt3K6He2mF1-SwngNCj9?usp=drive_link',
      'ja':
          'https://drive.google.com/drive/folders/18UjQPlagMivbnt3K6He2mF1-SwngNCj9?usp=drive_link',
    },
    '8etpehh9': {
      'vi': 'Copy',
      'en': 'Copy',
      'ja': 'コピー',
    },
    'aapro5xf': {
      'vi': 'Hoặc quét mã QR để tải app',
      'en': 'Or scan the QR code to download the app',
      'ja': 'または、QR コードをスキャンしてアプリをダウンロードします',
    },
    'gu9aj136': {
      'vi': 'Hướng dẫn bạn bè thực hiện các bước sau để cả 2 đều nhận thưởng',
      'en':
          'Instruct your friends to do the following steps so that you both receive rewards',
      'ja': '友達に次の手順を実行するように指示して、両方とも報酬を受け取ります',
    },
    'y205uos5': {
      'vi': '1. Tải app EcoFuturia',
      'en': '1. Download the EcoFuturia app',
      'ja': '1. EcoFuturia アプリをダウンロードする',
    },
    '1jrmy0y0': {
      'vi': '2. Đăng kí tài khoản',
      'en': '2. Register an account',
      'ja': '2. アカウントを登録する',
    },
    'nhp46rii': {
      'vi': '3. Nhập mã giới thiệu',
      'en': '3. Enter the referral code',
      'ja': '3.紹介コードを入力',
    },
    'pusfhv0c': {
      'vi': '4. Đăng nhập',
      'en': '4. Log in',
      'ja': '4. ログイン',
    },
    'us3412fg': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホームページ',
    },
  },
  // onboard
  {
    'oyd0z6j9': {
      'vi': 'GO GREEN',
      'en': 'GO GREEN',
      'ja': 'ゴーグリーン',
    },
    'tdqzui99': {
      'vi': 'Sống xanh dễ dàng hơn với các hoạt động thú vị',
      'en': 'Living green is easier with fun activities',
      'ja': '楽しいアクティビティで緑豊かな暮らしがもっと簡単に',
    },
    '7k937zhn': {
      'vi': 'Màu xanh tự  nhiên',
      'en': 'Natural green',
      'ja': '自然な緑',
    },
    '5jwqmrul': {
      'vi':
          'Màu xanh tự nhiên là biểu tượng của sức sống và sự phát triển bền vững, khuyến khích ứng dụng bảo vệ môi trường.',
      'en':
          'Natural green is a symbol of vitality and sustainable development, encouraging environmental protection applications.',
      'ja': '自然の緑は活力と持続可能な発展の象徴であり、環境保護への応用を促進します。',
    },
    'ba0d8q4j': {
      'vi': 'Bảo vệ môi trường',
      'en': 'Environmental protection',
      'ja': '環境保護',
    },
    'k5tj530o': {
      'vi':
          'Chúng ta cần hành động để thúc đẩy bảo vệ môi trường - vì đó là chìa khóa để bảo vệ hành tinh của chúng ta.',
      'en':
          'We need to take action to promote environmental protection - because it is key to protecting our planet.',
      'ja': '環境保護は地球を守る鍵となるため、私たちは環境保護を促進するための行動を起こす必要があります。',
    },
    'y9jax61m': {
      'vi': 'Bắt đầu nào ',
      'en': 'Let\'s start',
      'ja': 'はじめましょう',
    },
    'wz4oby56': {
      'vi': 'Trang chủ',
      'en': 'Home',
      'ja': 'ホーム',
    },
  },
  // Social
  {
    'unc01dwo': {
      'vi': 'Mạng xã hội',
      'en': 'Social Network',
      'ja': 'ソーシャルメディア',
    },
    'lgspzdpc': {
      'vi': 'Hoàng Bảo',
      'en': '',
      'ja': '',
    },
    'miey1wby': {
      'vi': 'Thích bởi Ecofuturia và 220 người khác',
      'en': 'Liked by Ecofuturia and 220 others',
      'ja': 'Ecofuturia 、他 220 人が「いいね！」',
    },
    'p63t0j4o': {
      'vi':
          '\"Chỉ khi nào cái cây cuối cùng bị đốn gục, con cá cuối cùng bị đánh bắt và dòng suối cuối cùng bị nhiễm độc, chúng ta mới nhận ra rằng tiền là thứ không thể ăn được\"',
      'en':
          'Only when the last tree is cut down, the last fish is caught, and the last stream is poisoned will we realize that money is something we cannot eat.',
      'ja': '最後の木が伐採され、最後の魚が捕獲され、最後の川が毒されたときに初めて、私たちはお金が食べられないものであることに気づきます。',
    },
    'pan8am3a': {
      'vi': 'Thảo Nhi',
      'en': '',
      'ja': '',
    },
    '9i7bus2h': {
      'vi': 'Thích bởi Ecofuturia và 220 người khác',
      'en': 'Liked by Ecofuturia and 220 others',
      'ja': 'Ecofuturia 、他 220 人が「いいね！」',
    },
    'rk53cmlf': {
      'vi': '\"Ngày Trái Đất 2024\"',
      'en': 'Earth Day 2024',
      'ja': '2024 年アースデイ',
    },
    'hrodfu40': {
      'vi': 'Quốc Khánh',
      'en': 'Earth Day 2024',
      'ja': '2024 年アースデイ',
    },
    'sn06zwia': {
      'vi': 'Thích bởi Ecofuturia và 220 người khác',
      'en': 'Liked by Ecofuturia and 220 others',
      'ja': 'Ecofuturia 、他 220 人が「いいね！」',
    },
    'p3aqysvu': {
      'vi': '\"Sự kiện bảo vệ môi trường diễn ra vào ngày 5 tháng 6 2024\"',
      'en': '\"Environmental protection event takes place on June 5, 2024\"',
      'ja': '「2024年6月5日に環境保護イベントを開催します」',
    },
  },
  // Miscellaneous
  {
    'b7z256ub': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'sb967i1b': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'loq21lor': {
      'vi': 'Cho phép \"Tetote\" truy cập vị trí của bạn',
      'en': '',
      'ja': '',
    },
    'o5mrrx1m': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    '45z28g9l': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'm977qmv7': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    '69eqev06': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'v40ps9xo': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'a3th5joa': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'fq5cxh2l': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'zw5iviqn': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    '7uijemeh': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'p2469hhz': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'b4ae5j30': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'nxba3s97': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    '8ufpsadm': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'zkyyd474': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    '58h0ggte': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'carbfv0k': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'arzas5lj': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'bra5j832': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'ungjfx37': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    '4659mk8n': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    '4pw27y0y': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    '6i50ug75': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'z90kqtqs': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    '2zbeqmmy': {
      'vi': '',
      'en': '',
      'ja': '',
    },
    'ztdcblzh': {
      'vi': '',
      'en': '',
      'ja': '',
    },
  },
].reduce((a, b) => a..addAll(b));
