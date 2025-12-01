/// API Configuration
/// Backend URL ve endpoint'leri tanımlar
class ApiConfig {
  // Base URL - Backend'in çalıştığı adres
  // Web için localhost, mobil emülatör için 10.0.2.2 kullan
  static const String baseUrl = 'http://127.0.0.1:8080';
  
  // User endpoints
  static const String userAdd = '/user/add';
  static const String userGet = '/user/get';
  static const String userUpdate = '/user/update';
  static const String userDelete = '/user/delete';

  // Favori endpoints
  static const String favoriAdd = '/favori/add';
  static const String favoriGet = '/favori/get';
  static const String favoriDelete = '/favori/delete';

  // Adres endpoints
  static const String adresAdd = '/adres/add';
  static const String adresGet = '/adres/get';
  static const String adresUpdate = '/adres/update';
  static const String adresDelete = '/adres/delete';

  // Otomobil endpoints
  static const String otomobilAdd = '/otomobil/add';
  static const String otomobilGet = '/otomobil/get';
  static const String otomobilUpdate = '/otomobil/update';
  static const String otomobilDelete = '/otomobil/delete';

  // Motosiklet endpoints
  static const String motosikletAdd = '/motosiklet/add';
  static const String motosikletGet = '/motosiklet/get';
  static const String motosikletUpdate = '/motosiklet/update';
  static const String motosikletDelete = '/motosiklet/delete';

  // Karavan endpoints
  static const String karavanAdd = '/karavan/add';
  static const String karavanGet = '/karavan/get';
  static const String karavanUpdate = '/karavan/update';
  static const String karavanDelete = '/karavan/delete';

  // Tır endpoints
  static const String tirAdd = '/tir/add';
  static const String tirGet = '/tir/get';
  static const String tirUpdate = '/tir/update';
  static const String tirDelete = '/tir/delete';

  // Konut endpoints
  static const String konutAdd = '/konut/add';
  static const String konutGet = '/konut/get';
  static const String konutUpdate = '/konut/update';
  static const String konutDelete = '/konut/delete';

  // Arsa endpoints
  static const String arsaAdd = '/arsa/add';
  static const String arsaGet = '/arsa/get';
  static const String arsaUpdate = '/arsa/update';
  static const String arsaDelete = '/arsa/delete';

  // Turistik Tesis endpoints
  static const String turistikAdd = '/turistik/add';
  static const String turistikGet = '/turistik/get';
  static const String turistikUpdate = '/turistik/update';
  static const String turistikDelete = '/turistik/delete';

  // Devre Mülk endpoints
  static const String devreAdd = '/devre/add';
  static const String devreGet = '/devre/get';
  static const String devreUpdate = '/devre/update';
  static const String devreDelete = '/devre/delete';
}

