class AppStrings {
  //api key
  static String loginApi = 'login';
  static String getProductListApi = 'ecoshark_producttypes';
  static String searchProductApi = 'ecoshark_products/search_products';
  static String addInventoryApi = 'ecoshark_products/add_inventory';
  static String uploadDocumentApi = 'document/uploaddocumentwithoutticketno';
  static String getUndeliveredOrdersApi = 'ecoshark_orders/get_orders';
  static String getOrderDetailsByIdApi =
      'ecoshark_orders/get_order_details_by_id';
  static String getPackageOrderItemInventory =
      'ecoshark_orders/get_package_order_item_inventory';
  static String getInventoryByDeviceIdApi =
      'ecoshark_orders/get_inventory_by_device_id';
  static String assignInventoryToOrderItemApi =
      'ecoshark_orders/assign_inventory_to_order_item';

  //login
  static String login = 'LOGIN';
  static String loginDes = 'Please Login to continue';
  static String neoloopID = 'Enter Neoloop ID';
  static String password = 'Password';
  static String forgotPassword = 'Forgot password?';
  static String signIn = 'Sign In';
  static String serviceAppFor = 'Service app for';

  //forgotPass
  static String forgotPass = 'FORGOT PASSWORD';
  static String submit = 'Submit';

  //ProdukteingangProduktion
  static String searchText = 'Search Product type or choose below';

  //process one
  //page one
  static String selectProduct = 'Select product';

  //que/filed page
  static String stockPlaceHolder = 'Unbeschädigt';
  static String stockLable =
      'Bitte geben Sie hier die Anzahl Stück der unbeschädigten Ware ein:';
  static String stockLocation = 'Bitte an folgenden Lagerplatz einlagern: ';
  static String damagedStockPlaceHolder = 'Beschädigt';
  static String damagedStockLable =
      'Bitte geben Sie hier die Anzahl Stück der beschädigten Ware ein:';

  //me tab
  static String anrede = 'Anrede';
  static String vorname = 'Vorname';
  static String nachname = 'Nachname';
  static String eMail = 'E-Mail';
  static String strabe = 'Straße';
  static String nr = 'Nr.';
  static String plz = 'PLZ';
  static String stadt = 'Stadt';
  static String landDesWohnsitzes = 'Land des Wohnsitzes';
  static String telefonnummer = 'Telefonnummer';
  static String benutzerNr = 'Benutzer Nr.';
  static String personlicheDaten = 'PERSÖNLICHE DATEN';
  static String offiziellerWohnsitz = 'OFFIZIELLER WOHNSITZ';
  static String mehrInfo = 'MEHR INFO';

  //process two
  static String customerName = 'Kunde ';
  static String orderNumber = 'Bestellnummer ';
  static String orderStatus = 'Bestellstatus ';
  static String orderDate = 'Bestelldatum ';
  static String orderTotal = 'Gesamtbetrag ';

  //undamged storage
  static String lagerplatz = "Lagerplatz";
  static String brutto = "Brutto:";
  static String produktPaket = "Produkt/Paket";
  static String produktIstAn = "Produkt ist an:";
  static String deviceID = "Device ID:";

  //quantity
  static String menge = "Menge";

  //product button
  static String produktZuweisen = "Produkt zuweisen";

  //package button
  static String offnen = "Öffnen";

  //product name
  static String produktname = "Produktname";

  //oder details
  static String bestelldetails = "Bestelldetails";

  //package details
  static String paketdetails = "Paketdetails ";

  //packageName
  static String paket = "Paket";
  static String produkt = "Produkt";

  //scan the device
  static String scannenSieDasGerat = "Scannen Sie das Produkt";
  static String hinzufugen = " Hinzufügen ";
  static String scanStarten = " Scan starten ";
  //restart scan
  static String erneutScannen = " Erneut scannen ";

  //product or package and their type
  static String productTypeEinzelprufung = 'product-Einzelprufung';
  static String productTypeMassenErfassung = 'product-Massen Erfassung';
  static String packageTypeEinzelprufung = 'package-Einzelprufung';
  static String packageTypeMassenErfassung = 'package-Massen Erfassung';
}
