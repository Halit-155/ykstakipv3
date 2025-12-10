import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// ============================================================
// 0. TEMA VE GÖRSEL YAPILANDIRMA
// ============================================================
class AppTheme {
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color primaryLight = Color(0xFF1976D2);
  static const Color accentColor = Color(0xFFFFC107);
  static const Color backgroundLight = Color(0xFFF5F7FA);
  static const Color cardColor = Colors.white;

  static const LinearGradient mainGradient = LinearGradient(
    colors: [primaryDark, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryDark,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryDark,
        secondary: accentColor,
        background: backgroundLight,
        surface: cardColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryDark,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryDark, width: 2)),
      ),
    );
  }
}

class ModernDashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;
  const ModernDashboardCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.color,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        color: Colors.white,
        shadowColor: color.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [color.withOpacity(0.1), Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: color.withOpacity(0.2),
                              shape: BoxShape.circle),
                          child: Icon(icon, size: 32, color: color)),
                      const SizedBox(height: 12),
                      Text(title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey.shade800)),
                    ]))));
  }
}

// ============================================================
// 1. GLOBAL VERİ DEPOSU VE MODELLER
// ============================================================
class VeriDeposu {
  static List<Gorev> kayitliProgram = [];
  static List<DenemeSonucu> denemeListesi = [];
  static List<PdfDeneme> kurumsalDenemeler = [];
  static List<KayitliProgramGecmisi> programArsivi = [];
  static List<SoruCozumKaydi> soruCozumListesi = [];
  static Map<String, bool> tamamlananKonular = {};
  static List<Rozet> tumRozetler = [];
  static List<Mesaj> mesajlar = [];

  static const List<String> aktiviteler = [
    "Konu Çalışma",
    "Soru Çözümü",
    "Tekrar",
    "Deneme",
    "Video İzle",
    "Konu + Soru",
    "Özet Çıkarma",
    "Fasikül Bitirme",
    "MEB Kitabı Okuma"
  ];

  static const List<String> calismaStilleri = [
    "30+5 (30 Dk Ders, 5 Dk Mola)",
    "35+5 (35 Dk Ders, 5 Dk Mola)",
    "40+5 (40 Dk Ders, 5 Dk Mola)",
    "45+5 (45 Dk Ders, 5 Dk Mola)",
    "50+5 (50 Dk Ders, 5 Dk Mola)",
    "60+10 (60 Dk Ders, 10 Dk Mola)",
    "Pomodoro (25+5+25+5+25+30)"
  ];

  static List<Ogrenci> ogrenciler = [
    Ogrenci(
        id: "101",
        tcNo: "11111111111",
        sifre: "123456",
        ad: "Ahmet Yılmaz",
        sinif: "12-A",
        puan: 1250,
        atananOgretmenId: "t1",
        fotoUrl: "",
        girisSayisi: 45,
        hedefUniversite: "Boğaziçi",
        hedefBolum: "Bilgisayar",
        hedefPuan: 520),
    Ogrenci(
        id: "102",
        tcNo: "22222222222",
        sifre: "123456",
        ad: "Ayşe Demir",
        sinif: "12-B",
        puan: 2400,
        atananOgretmenId: "t1",
        fotoUrl: "",
        girisSayisi: 82,
        hedefUniversite: "İstanbul",
        hedefBolum: "Hukuk",
        hedefPuan: 460),
    Ogrenci(
        id: "103",
        tcNo: "33333333333",
        sifre: "123456",
        ad: "Mehmet Çelik",
        sinif: "12-A",
        puan: 850,
        atananOgretmenId: "t1",
        fotoUrl: "",
        girisSayisi: 12,
        hedefUniversite: "Erzurum Atatürk",
        hedefBolum: "Tıp",
        hedefPuan: 490),
    Ogrenci(
        id: "104",
        tcNo: "44444444444",
        sifre: "123456",
        ad: "Zeynep Kaya",
        sinif: "11-C",
        puan: 1800,
        atananOgretmenId: "t2",
        fotoUrl: "",
        girisSayisi: 60,
        hedefUniversite: "ODTÜ",
        hedefBolum: "Mimarlık",
        hedefPuan: 480),
  ];
  static List<Ogretmen> ogretmenler = [
    Ogretmen(
        id: "t1",
        tcNo: "33333333333",
        sifre: "123456",
        ad: "Mustafa Hoca",
        brans: "Matematik"),
    Ogretmen(
        id: "t2",
        tcNo: "44444444444",
        sifre: "123456",
        ad: "Elif Hoca",
        brans: "Edebiyat"),
  ];
  static List<OkulDersi> okulNotlari = [
    OkulDersi(ad: "Matematik", yazili1: 60),
  ];

  static void baslat() {
    if (tumRozetler.isNotEmpty) return;
    kurumsalDenemeler.add(PdfDeneme("Türkiye Geneli TYT-1",
        DateTime.now().subtract(const Duration(days: 5)), "dosya.pdf"));

    // --- GENİŞLETİLMİŞ ROZET LİSTESİ ---
    tumRozetler.addAll([
      // SORU KATEGORİSİ
      Rozet(
          id: "soru_100",
          ad: "Isınma Turu",
          aciklama: "100 Soru barajı!",
          kategori: "Soru",
          puanDegeri: 50,
          ikon: Icons.directions_run,
          renk: Colors.lime,
          hedefSayi: 100,
          mevcutSayi: 0),
      Rozet(
          id: "soru_500",
          ad: "Soru Avcısı",
          aciklama: "500 Soru!",
          kategori: "Soru",
          puanDegeri: 150,
          ikon: Icons.my_location,
          renk: Colors.cyan,
          hedefSayi: 500,
          mevcutSayi: 0),
      Rozet(
          id: "soru_1000",
          ad: "Problem Çözücü",
          aciklama: "1000 Soru!",
          kategori: "Soru",
          puanDegeri: 300,
          ikon: Icons.psychology,
          renk: Colors.orange,
          hedefSayi: 1000,
          mevcutSayi: 0),
      Rozet(
          id: "soru_5000",
          ad: "YKS Makinesi",
          aciklama: "5000 Soru!",
          kategori: "Soru",
          puanDegeri: 1000,
          ikon: Icons.smart_toy,
          renk: Colors.purple,
          hedefSayi: 5000,
          mevcutSayi: 0),
      Rozet(
          id: "soru_10000",
          ad: "Bilgi Üstadı",
          aciklama: "10.000 Soru!",
          kategori: "Soru",
          puanDegeri: 2500,
          ikon: Icons.auto_awesome,
          renk: Colors.deepPurpleAccent,
          hedefSayi: 10000,
          mevcutSayi: 0),
      Rozet(
          id: "soru_25000",
          ad: "Büyük Üstad",
          aciklama: "25.000 Soru!",
          kategori: "Soru",
          puanDegeri: 5000,
          ikon: Icons.whatshot,
          renk: Colors.red,
          hedefSayi: 25000,
          mevcutSayi: 0),

      // KONU KATEGORİSİ
      Rozet(
          id: "konu_1",
          ad: "İlk Adım",
          aciklama: "İlk konu bitti.",
          kategori: "Konu",
          puanDegeri: 20,
          ikon: Icons.flag,
          renk: Colors.greenAccent,
          hedefSayi: 1,
          mevcutSayi: 0),
      Rozet(
          id: "konu_10",
          ad: "Çırak",
          aciklama: "10 Konu bitti.",
          kategori: "Konu",
          puanDegeri: 100,
          ikon: Icons.construction,
          renk: Colors.lightGreen,
          hedefSayi: 10,
          mevcutSayi: 0),
      Rozet(
          id: "konu_25",
          ad: "Kalfa",
          aciklama: "25 Konu bitti.",
          kategori: "Konu",
          puanDegeri: 250,
          ikon: Icons.handyman,
          renk: Colors.teal,
          hedefSayi: 25,
          mevcutSayi: 0),
      Rozet(
          id: "konu_50",
          ad: "Usta",
          aciklama: "50 Konu bitti.",
          kategori: "Konu",
          puanDegeri: 500,
          ikon: Icons.engineering,
          renk: Colors.blue,
          hedefSayi: 50,
          mevcutSayi: 0),
      Rozet(
          id: "konu_100",
          ad: "Müfredat Bükücü",
          aciklama: "100 Konu!",
          kategori: "Konu",
          puanDegeri: 1500,
          ikon: Icons.library_books,
          renk: Colors.indigo,
          hedefSayi: 100,
          mevcutSayi: 0),

      // DENEME KATEGORİSİ
      Rozet(
          id: "deneme_1",
          ad: "Meydan Okuma",
          aciklama: "İlk deneme.",
          kategori: "Deneme",
          puanDegeri: 50,
          ikon: Icons.timer,
          renk: Colors.amber.shade300,
          hedefSayi: 1,
          mevcutSayi: 0),
      Rozet(
          id: "deneme_5",
          ad: "Tecrübeli Aday",
          aciklama: "5 Deneme.",
          kategori: "Deneme",
          puanDegeri: 150,
          ikon: Icons.history_edu,
          renk: Colors.orangeAccent,
          hedefSayi: 5,
          mevcutSayi: 0),
      Rozet(
          id: "deneme_10",
          ad: "Sınav Kurdu",
          aciklama: "10 Deneme.",
          kategori: "Deneme",
          puanDegeri: 300,
          ikon: Icons.verified_user,
          renk: Colors.deepOrange,
          hedefSayi: 10,
          mevcutSayi: 0),
      Rozet(
          id: "deneme_20",
          ad: "Profesyonel",
          aciklama: "20 Deneme.",
          kategori: "Deneme",
          puanDegeri: 750,
          ikon: Icons.workspace_premium,
          renk: Colors.brown,
          hedefSayi: 20,
          mevcutSayi: 0),
      Rozet(
          id: "deneme_50",
          ad: "Yenilmez",
          aciklama: "50 Deneme!",
          kategori: "Deneme",
          puanDegeri: 2000,
          ikon: Icons.military_tech,
          renk: Colors.redAccent,
          hedefSayi: 50,
          mevcutSayi: 0),

      // SEVİYE (XP) KATEGORİSİ
      Rozet(
          id: "puan_500",
          ad: "Başlangıç",
          aciklama: "500 XP.",
          kategori: "Seviye",
          puanDegeri: 0,
          ikon: Icons.start,
          renk: Colors.blueGrey,
          hedefSayi: 500,
          mevcutSayi: 0),
      Rozet(
          id: "puan_2500",
          ad: "Bronz Lig",
          aciklama: "2500 XP.",
          kategori: "Seviye",
          puanDegeri: 0,
          ikon: Icons.emoji_events,
          renk: Colors.brown.shade300,
          hedefSayi: 2500,
          mevcutSayi: 0),
      Rozet(
          id: "puan_5000",
          ad: "Gümüş Lig",
          aciklama: "5000 XP.",
          kategori: "Seviye",
          puanDegeri: 0,
          ikon: Icons.star,
          renk: Colors.grey.shade400,
          hedefSayi: 5000,
          mevcutSayi: 0),
      Rozet(
          id: "puan_10000",
          ad: "Altın Lig",
          aciklama: "10.000 XP.",
          kategori: "Seviye",
          puanDegeri: 0,
          ikon: Icons.diamond,
          renk: Colors.amber,
          hedefSayi: 10000,
          mevcutSayi: 0),
      Rozet(
          id: "puan_25000",
          ad: "Platin Lig",
          aciklama: "25.000 XP.",
          kategori: "Seviye",
          puanDegeri: 0,
          ikon: Icons.api,
          renk: Colors.cyanAccent,
          hedefSayi: 25000,
          mevcutSayi: 0),
      Rozet(
          id: "puan_50000",
          ad: "Grandmaster",
          aciklama: "50.000 XP.",
          kategori: "Seviye",
          puanDegeri: 0,
          ikon: Icons.workspace_premium,
          renk: Colors.deepPurple.shade900,
          hedefSayi: 50000,
          mevcutSayi: 0),
    ]);
  }

  static List<String> getZayifKonular(String ogrenciId) {
    Map<String, List<int>> analiz = {};
    for (var kayit in soruCozumListesi.where((k) => k.ogrenciId == ogrenciId)) {
      String anahtar = "${kayit.ders} - ${kayit.konu}";
      if (!analiz.containsKey(anahtar)) analiz[anahtar] = [0, 0];
      analiz[anahtar]![0] += kayit.dogru;
      analiz[anahtar]![1] += kayit.yanlis;
    }
    List<String> zayiflar = [];
    analiz.forEach((konu, degerler) {
      int dogru = degerler[0];
      int yanlis = degerler[1];
      int toplam = dogru + yanlis;
      if (toplam > 10 && (dogru / toplam) * 100 < 60) zayiflar.add(konu);
    });
    return zayiflar;
  }

  static double getSinifOrtalamasi(String teacherId) {
    return 0;
  }

  static Map<String, String> getIstatistikler() {
    return {
      "Öğrenci": "${ogrenciler.length}",
      "Soru": "${soruCozumListesi.length}"
    };
  }

  static void soruEkle(SoruCozumKaydi k) {
    soruCozumListesi.add(k);
    puanEkle(k.ogrenciId, (k.dogru + k.yanlis) ~/ 5); // Her 5 soruda 1 puan
    rozetleriGuncelle();
  }

  static void odevAta(String ogrenciId, String ders, String konu, String not) {
    kayitliProgram.add(Gorev(
        hafta: 1,
        gun: "Pazartesi",
        saat: "Ekstra",
        ders: ders,
        konu: konu,
        aciklama: "ÖĞRETMEN ÖDEVİ: $not"));
  }

  static void programiKaydet(List<Gorev> program, String tur) {
    kayitliProgram = List.from(program);
    programArsivi.add(KayitliProgramGecmisi(
        tarih: DateTime.now(), tur: tur, programVerisi: List.from(program)));
    puanEkle("101", 100); // Program hazırlama ödülü
  }

  static void arsivdenProgramiYukle(KayitliProgramGecmisi kayit) {
    kayitliProgram = List.from(kayit.programVerisi);
  }

  static void arsivSil(KayitliProgramGecmisi kayit) {
    programArsivi.remove(kayit);
  }

  static void denemeEkle(DenemeSonucu d) {
    denemeListesi.add(d);
    puanEkle(d.ogrenciId, 50);
    rozetleriGuncelle();
  }

  static void dersEkle(OkulDersi d) {
    okulNotlari.add(d);
  }

  static void konuDurumDegistir(String k, bool v) {
    tamamlananKonular[k] = v;
    if (v) puanEkle("101", 10);
    rozetleriGuncelle();
  }

  static void mesajGonder(String g, String a, String i) {
    mesajlar
        .add(Mesaj(gonderen: g, aliciId: a, icerik: i, tarih: DateTime.now()));
  }

  static void kullaniciSil(String id, bool isOgrenci) {
    if (isOgrenci)
      ogrenciler.removeWhere((e) => e.id == id);
    else
      ogretmenler.removeWhere((e) => e.id == id);
  }

  static void puanEkle(String id, int p) {
    var o =
        ogrenciler.firstWhere((e) => e.id == id, orElse: () => ogrenciler[0]);
    o.puan += p;
    rozetleriGuncelle();
  }

  static void rozetleriGuncelle() {
    // Verileri hesapla
    int toplamSoru =
        soruCozumListesi.fold(0, (sum, item) => sum + item.dogru + item.yanlis);
    int bitenKonu = tamamlananKonular.values.where((e) => e).length;
    int denemeSayisi = denemeListesi.length;
    int toplamPuan = ogrenciler[0].puan;

    for (var r in tumRozetler) {
      if (r.kategori == "Soru") r.mevcutSayi = toplamSoru;
      if (r.kategori == "Konu") r.mevcutSayi = bitenKonu;
      if (r.kategori == "Deneme") r.mevcutSayi = denemeSayisi;
      if (r.kategori == "Seviye") r.mevcutSayi = toplamPuan;

      if (r.mevcutSayi >= r.hedefSayi && !r.kazanildi) {
        r.kazanildi = true;
        if (r.kategori != "Seviye")
          puanEkle("101", r.puanDegeri); // Rozet kazanınca ekstra puan
      }
    }
  }

  static void ogrenciGuncelle(String id, String ad, String sinif, String no,
      String foto, String uni, String bolum, int puan) {
    int idx = ogrenciler.indexWhere((o) => o.id == id);
    if (idx != -1) {
      var o = ogrenciler[idx];
      o.ad = ad;
      o.sinif = sinif;
      o.id = no;
      o.fotoUrl = foto;
      o.hedefUniversite = uni;
      o.hedefBolum = bolum;
      o.hedefPuan = puan;
    } else {
      ogrenciler.add(Ogrenci(
          id: no,
          tcNo: no,
          ad: ad,
          sinif: sinif,
          puan: 0,
          girisSayisi: 0,
          fotoUrl: foto,
          hedefUniversite: uni,
          hedefBolum: bolum,
          hedefPuan: puan));
    }
  }

  static String yeniKayit(
      String rol, String ad, String tc, String sifre, String detay) {
    if (ogrenciler.any((o) => o.tcNo == tc) ||
        ogretmenler.any((t) => t.tcNo == tc)) return "Kayıtlı!";
    if (rol == "Öğrenci")
      ogrenciler.add(Ogrenci(
          id: tc.substring(8),
          tcNo: tc,
          sifre: sifre,
          ad: ad,
          sinif: detay,
          puan: 0,
          girisSayisi: 0));
    else
      ogretmenler.add(Ogretmen(
          id: "t${tc.substring(8)}",
          tcNo: tc,
          sifre: sifre,
          ad: ad,
          brans: detay));
    return "Başarılı";
  }

  static dynamic girisKontrol(String tc, String sifre, String rol) {
    if (rol == "Öğrenci") {
      try {
        return ogrenciler.firstWhere((o) => o.tcNo == tc && o.sifre == sifre);
      } catch (e) {
        return null;
      }
    } else {
      try {
        return ogretmenler.firstWhere((t) => t.tcNo == tc && t.sifre == sifre);
      } catch (e) {
        return null;
      }
    }
  }

  static void girisSayaciArtir(String id, bool isOgrenci) {
    if (isOgrenci)
      ogrenciler.firstWhere((e) => e.id == id).girisSayisi++;
    else
      ogretmenler.firstWhere((e) => e.id == id).girisSayisi++;
  }

  static void pdfDenemeEkle(String baslik) {
    kurumsalDenemeler.add(PdfDeneme(baslik, DateTime.now(), "dosya.pdf"));
  }
}

// MODELLER
class Ogrenci {
  String id, tcNo, sifre, ad, sinif, fotoUrl, hedefUniversite, hedefBolum;
  int puan, girisSayisi, hedefPuan;
  String? atananOgretmenId;
  Ogrenci(
      {required this.id,
      this.tcNo = "",
      this.sifre = "123456",
      required this.ad,
      required this.sinif,
      this.puan = 0,
      this.girisSayisi = 0,
      this.atananOgretmenId,
      this.fotoUrl = "",
      this.hedefUniversite = "Hedef Yok",
      this.hedefBolum = "",
      this.hedefPuan = 0});
}

class Ogretmen {
  String id, tcNo, sifre, ad, brans;
  int girisSayisi;
  Ogretmen(
      {required this.id,
      this.tcNo = "",
      this.sifre = "123456",
      required this.ad,
      required this.brans,
      this.girisSayisi = 0});
}

class PdfDeneme {
  String baslik;
  DateTime tarih;
  String dosyaYolu;
  PdfDeneme(this.baslik, this.tarih, this.dosyaYolu);
}

class Mesaj {
  String gonderen, aliciId, icerik;
  DateTime tarih;
  Mesaj(
      {required this.gonderen,
      required this.aliciId,
      required this.icerik,
      required this.tarih});
}

class Gorev {
  int hafta;
  String gun, saat, ders, konu, aciklama;
  bool yapildi;
  Gorev(
      {required this.hafta,
      required this.gun,
      required this.saat,
      required this.ders,
      required this.konu,
      this.aciklama = "",
      this.yapildi = false});
}

class DenemeSonucu {
  String ogrenciId, tur;
  DateTime tarih;
  double toplamNet;
  Map<String, double> dersNetleri;
  DenemeSonucu(
      {required this.ogrenciId,
      required this.tur,
      required this.tarih,
      required this.toplamNet,
      required this.dersNetleri});
}

class OkulDersi {
  String ad;
  double yazili1, yazili2, performans;
  OkulDersi(
      {required this.ad,
      this.yazili1 = 0,
      this.yazili2 = 0,
      this.performans = 0});
  double get ortalama {
    int b = 0;
    if (yazili1 > 0) b++;
    if (yazili2 > 0) b++;
    if (performans > 0) b++;
    return b == 0 ? 0 : (yazili1 + yazili2 + performans) / b;
  }
}

class KayitliProgramGecmisi {
  DateTime tarih;
  String tur;
  List<Gorev> programVerisi;
  KayitliProgramGecmisi(
      {required this.tarih, required this.tur, required this.programVerisi});
}

class SoruCozumKaydi {
  String ogrenciId, ders, konu;
  int dogru, yanlis;
  DateTime tarih;
  SoruCozumKaydi(
      {required this.ogrenciId,
      required this.ders,
      required this.konu,
      required this.dogru,
      required this.yanlis,
      required this.tarih});
}

class DersGiris {
  String n;
  int soruSayisi;
  TextEditingController d = TextEditingController(),
      y = TextEditingController();
  double net = 0;
  DersGiris(this.n, this.soruSayisi);
}

class KonuDetay {
  String ad;
  int agirlik;
  KonuDetay(this.ad, this.agirlik);
}

class Rozet {
  String id, ad, aciklama, kategori;
  int puanDegeri, hedefSayi, mevcutSayi;
  IconData ikon;
  Color renk;
  bool kazanildi;
  Rozet(
      {required this.id,
      required this.ad,
      required this.aciklama,
      required this.kategori,
      required this.puanDegeri,
      required this.ikon,
      required this.renk,
      required this.hedefSayi,
      required this.mevcutSayi,
      this.kazanildi = false});
}

// --- TAM VE EKSİKSİZ MÜFREDAT ---
final Map<String, List<KonuDetay>> dersKonuAgirliklari = {
  // TYT
  "TYT Türkçe": [
    KonuDetay("Sözcükte Anlam", 3),
    KonuDetay("Cümlede Anlam", 3),
    KonuDetay("Paragraf", 25),
    KonuDetay("Ses Bilgisi", 1),
    KonuDetay("Yazım Kuralları", 2),
    KonuDetay("Noktalama İşaretleri", 2),
    KonuDetay("Sözcükte Yapı", 1),
    KonuDetay("İsimler", 1),
    KonuDetay("Sıfatlar", 1),
    KonuDetay("Zamirler", 1),
    KonuDetay("Zarflar", 1),
    KonuDetay("Edat-Bağlaç-Ünlem", 1),
    KonuDetay("Fiiller", 1),
    KonuDetay("Ek Fiil", 1),
    KonuDetay("Fiilimsi", 1),
    KonuDetay("Fiil Çatısı", 1),
    KonuDetay("Cümlenin Ögeleri", 1),
    KonuDetay("Cümle Türleri", 1),
    KonuDetay("Anlatım Bozuklukları", 1)
  ],
  "TYT Matematik": [
    KonuDetay("Temel Kavramlar", 2),
    KonuDetay("Sayı Basamakları", 1),
    KonuDetay("Bölme ve Bölünebilme", 1),
    KonuDetay("EBOB - EKOK", 1),
    KonuDetay("Rasyonel Sayılar", 1),
    KonuDetay("Basit Eşitsizlikler", 1),
    KonuDetay("Mutlak Değer", 1),
    KonuDetay("Üslü Sayılar", 1),
    KonuDetay("Köklü Sayılar", 1),
    KonuDetay("Çarpanlara Ayırma", 1),
    KonuDetay("Oran Orantı", 1),
    KonuDetay("Sayı Problemleri", 4),
    KonuDetay("Kesir Problemleri", 1),
    KonuDetay("Yaş Problemleri", 1),
    KonuDetay("İşçi Problemleri", 1),
    KonuDetay("Hareket Problemleri", 1),
    KonuDetay("Yüzde Kar Zarar Problemleri", 2),
    KonuDetay("Karışım Problemleri", 1),
    KonuDetay("Grafik Problemleri", 1),
    KonuDetay("Kümeler", 1),
    KonuDetay("Fonksiyonlar", 2),
    KonuDetay("Polinomlar", 1),
    KonuDetay("2. Dereceden Denklemler", 1),
    KonuDetay("Karmaşık Sayılar", 1),
    KonuDetay("Permütasyon", 1),
    KonuDetay("Kombinasyon", 1),
    KonuDetay("Binom", 1),
    KonuDetay("Olasılık", 1),
    KonuDetay("Veri İstatistik", 1),
    KonuDetay("Mantık", 1)
  ],
  "TYT Geometri": [
    KonuDetay("Doğruda ve Üçgende Açılar", 2),
    KonuDetay("Dik ve Özel Üçgenler", 1),
    KonuDetay("İkizkenar ve Eşkenar Üçgen", 1),
    KonuDetay("Açıortay", 1),
    KonuDetay("Kenarortay", 1),
    KonuDetay("Eşlik ve Benzerlik", 1),
    KonuDetay("Üçgende Alan", 1),
    KonuDetay("Açı-Kenar Bağıntıları", 1),
    KonuDetay("Çokgenler", 1),
    KonuDetay("Dörtgenler", 1),
    KonuDetay("Deltoid", 1),
    KonuDetay("Paralelkenar", 1),
    KonuDetay("Eşkenar Dörtgen", 1),
    KonuDetay("Dikdörtgen", 1),
    KonuDetay("Kare", 1),
    KonuDetay("Yamuk", 1),
    KonuDetay("Çember ve Daire", 2),
    KonuDetay("Analitik Geometri", 1),
    KonuDetay("Katı Cisimler", 2)
  ],
  "TYT Fizik": [
    KonuDetay("Fizik Bilimine Giriş", 1),
    KonuDetay("Madde ve Özellikleri", 1),
    KonuDetay("Hareket ve Kuvvet", 2),
    KonuDetay("İş, Güç ve Enerji", 1),
    KonuDetay("Isı, Sıcaklık ve Genleşme", 1),
    KonuDetay("Elektrostatik", 1),
    KonuDetay("Elektrik ve Manyetizma", 1),
    KonuDetay("Basınç ve Kaldırma Kuvveti", 1),
    KonuDetay("Dalgalar", 1),
    KonuDetay("Optik", 2)
  ],
  "TYT Kimya": [
    KonuDetay("Kimya Bilimi", 1),
    KonuDetay("Atom ve Periyodik Sistem", 1),
    KonuDetay("Kimyasal Türler Arası Etkileşimler", 1),
    KonuDetay("Maddenin Halleri", 1),
    KonuDetay("Doğa ve Kimya", 1),
    KonuDetay("Kimyanın Temel Kanunları", 1),
    KonuDetay("Kimyasal Hesaplamalar", 1),
    KonuDetay("Karışımlar", 1),
    KonuDetay("Asitler, Bazlar ve Tuzlar", 1),
    KonuDetay("Kimya Her Yerde", 1)
  ],
  "TYT Biyoloji": [
    KonuDetay("Canlıların Ortak Özellikleri", 1),
    KonuDetay("Canlıların Temel Bileşenleri", 1),
    KonuDetay("Hücre", 1),
    KonuDetay("Canlıların Sınıflandırılması", 1),
    KonuDetay("Üreme", 1),
    KonuDetay("Kalıtım", 1),
    KonuDetay("Ekosistem Ekolojisi", 1)
  ],
  "TYT Tarih": [
    KonuDetay("Tarih Bilimi", 1),
    KonuDetay("İlk Çağ Uygarlıkları", 1),
    KonuDetay("İslamiyet Öncesi Türk Tarihi", 1),
    KonuDetay("İslam Tarihi ve Uygarlığı", 1),
    KonuDetay("Türk İslam Devletleri", 1),
    KonuDetay("Türkiye Tarihi", 1),
    KonuDetay("Beylikten Devlete Osmanlı", 1),
    KonuDetay("Dünya Gücü Osmanlı", 1),
    KonuDetay("Osmanlı Kültür ve Medeniyeti", 1),
    KonuDetay("Yeni Çağ'da Avrupa", 1),
    KonuDetay("Yakın Çağ'da Avrupa", 1),
    KonuDetay("En Uzun Yüzyıl", 1),
    KonuDetay("20. yy Başlarında Osmanlı", 1),
    KonuDetay("1. Dünya Savaşı", 1),
    KonuDetay("Kurtuluş Savaşı Hazırlık", 1),
    KonuDetay("Kurtuluş Savaşı Cepheler", 1),
    KonuDetay("İlke ve İnkılaplar", 1),
    KonuDetay("Dış Politika", 1)
  ],
  "TYT Coğrafya": [
    KonuDetay("Doğa ve İnsan", 1),
    KonuDetay("Dünya'nın Şekli ve Hareketleri", 1),
    KonuDetay("Coğrafi Konum", 1),
    KonuDetay("Harita Bilgisi", 1),
    KonuDetay("Atmosfer ve İklim", 1),
    KonuDetay("Sıcaklık", 1),
    KonuDetay("Basınç ve Rüzgarlar", 1),
    KonuDetay("Nem ve Yağış", 1),
    KonuDetay("İklim Tipleri", 1),
    KonuDetay("İç ve Dış Kuvvetler", 1),
    KonuDetay("Su - Toprak - Bitki", 1),
    KonuDetay("Nüfus", 1),
    KonuDetay("Göç", 1),
    KonuDetay("Yerleşme", 1),
    KonuDetay("Bölgeler", 1),
    KonuDetay("Ulaşım Yolları", 1),
    KonuDetay("Çevre ve İnsan", 1),
    KonuDetay("Doğal Afetler", 1)
  ],
  "TYT Felsefe": [
    KonuDetay("Felsefeye Giriş", 1),
    KonuDetay("Bilgi Felsefesi", 1),
    KonuDetay("Varlık Felsefesi", 1),
    KonuDetay("Ahlak Felsefesi", 1),
    KonuDetay("Sanat Felsefesi", 1),
    KonuDetay("Din Felsefesi", 1),
    KonuDetay("Siyaset Felsefesi", 1),
    KonuDetay("Bilim Felsefesi", 1)
  ],
  "TYT Din": [
    KonuDetay("İnanç", 1),
    KonuDetay("İbadet", 1),
    KonuDetay("Ahlak", 1),
    KonuDetay("Hz. Muhammed", 1),
    KonuDetay("Vahiy ve Akıl", 1),
    KonuDetay("İslam ve Bilim", 1),
    KonuDetay("Anadolu'da İslam", 1),
    KonuDetay("İslam Düşüncesinde Yorumlar", 1)
  ],

  // AYT
  "AYT Matematik": [
    KonuDetay("Polinomlar", 1),
    KonuDetay("2. Dereceden Denklemler", 1),
    KonuDetay("Karmaşık Sayılar", 1),
    KonuDetay("Parabol", 1),
    KonuDetay("Eşitsizlikler", 1),
    KonuDetay("Logaritma", 2),
    KonuDetay("Diziler", 1),
    KonuDetay("Trigonometri", 4),
    KonuDetay("Limit ve Süreklilik", 2),
    KonuDetay("Türev", 4),
    KonuDetay("İntegral", 4)
  ],
  "AYT Fizik": [
    KonuDetay("Vektörler", 1),
    KonuDetay("Bağıl Hareket", 1),
    KonuDetay("Newton'un Hareket Yasaları", 1),
    KonuDetay("Bir Boyutta Sabit İvmeli Hareket", 1),
    KonuDetay("Atışlar", 1),
    KonuDetay("İş Güç Enerji", 1),
    KonuDetay("İtme ve Momentum", 1),
    KonuDetay("Tork ve Denge", 1),
    KonuDetay("Kütle Merkezi", 1),
    KonuDetay("Basit Makineler", 1),
    KonuDetay("Elektrik Alan ve Potansiyel", 1),
    KonuDetay("Paralel Levhalar", 1),
    KonuDetay("Sığaçlar", 1),
    KonuDetay("Manyetizma", 2),
    KonuDetay("Alternatif Akım ve Transformatörler", 1),
    KonuDetay("Çembersel Hareket", 2),
    KonuDetay("Basit Harmonik Hareket", 1),
    KonuDetay("Dalga Mekaniği", 1),
    KonuDetay("Atom Fiziği", 1),
    KonuDetay("Modern Fizik", 1)
  ],
  "AYT Kimya": [
    KonuDetay("Modern Atom Teorisi", 1),
    KonuDetay("Gazlar", 1),
    KonuDetay("Sıvı Çözeltiler", 1),
    KonuDetay("Kimyasal Tepkimelerde Enerji", 1),
    KonuDetay("Kimyasal Tepkimelerde Hız", 1),
    KonuDetay("Kimyasal Denge", 2),
    KonuDetay("Asit-Baz Dengesi", 2),
    KonuDetay("Çözünürlük Dengesi", 1),
    KonuDetay("Kimya ve Elektrik", 2),
    KonuDetay("Karbon Kimyasına Giriş", 1),
    KonuDetay("Organik Kimya", 4)
  ],
  "AYT Biyoloji": [
    KonuDetay("Sinir Sistemi", 1),
    KonuDetay("Endokrin Sistem", 1),
    KonuDetay("Duyu Organları", 1),
    KonuDetay("Destek ve Hareket Sistemi", 1),
    KonuDetay("Sindirim Sistemi", 1),
    KonuDetay("Dolaşım Sistemi", 1),
    KonuDetay("Solunum Sistemi", 1),
    KonuDetay("Üriner Sistem", 1),
    KonuDetay("Üreme Sistemi ve Embriyonik Gelişim", 1),
    KonuDetay("Komünite ve Popülasyon Ekolojisi", 1),
    KonuDetay("Nükleik Asitler", 1),
    KonuDetay("Protein Sentezi", 1),
    KonuDetay("Canlılarda Enerji Dönüşümleri", 2),
    KonuDetay("Bitki Biyolojisi", 2),
    KonuDetay("Canlılar ve Çevre", 1)
  ],
  "AYT Edebiyat": [
    KonuDetay("Güzel Sanatlar ve Edebiyat", 1),
    KonuDetay("Şiir Bilgisi", 3),
    KonuDetay("Edebi Sanatlar", 1),
    KonuDetay("Olay Çevresinde Oluşan Metinler", 1),
    KonuDetay("Öğretici Metinler", 1),
    KonuDetay("İslamiyet Öncesi Türk Edebiyatı", 1),
    KonuDetay("Geçiş Dönemi Eserleri", 1),
    KonuDetay("Halk Edebiyatı", 2),
    KonuDetay("Divan Edebiyatı", 4),
    KonuDetay("Tanzimat Edebiyatı", 2),
    KonuDetay("Servet-i Fünun Edebiyatı", 2),
    KonuDetay("Fecr-i Ati Edebiyatı", 1),
    KonuDetay("Milli Edebiyat", 2),
    KonuDetay("Cumhuriyet Dönemi Edebiyatı", 5),
    KonuDetay("Edebi Akımlar", 1)
  ],
  "AYT Tarih-1": [
    KonuDetay("Tarih Bilimi", 1),
    KonuDetay("İlk Çağ Uygarlıkları", 1),
    KonuDetay("İslamiyet Öncesi Türk Tarihi", 1),
    KonuDetay("İslam Tarihi", 1),
    KonuDetay("Türk İslam Tarihi", 1),
    KonuDetay("Osmanlı Tarihi", 2),
    KonuDetay("Milli Mücadele", 2),
    KonuDetay("Atatürkçülük", 1)
  ],
  "AYT Coğrafya-1": [
    KonuDetay("Biyoçeşitlilik", 1),
    KonuDetay("Ekosistem", 1),
    KonuDetay("Nüfus Politikaları", 1),
    KonuDetay("Yerleşmeler", 1),
    KonuDetay("Ekonomik Faaliyetler", 1),
    KonuDetay("Türkiye Ekonomisi", 1),
    KonuDetay("Bölgeler ve Ülkeler", 1),
    KonuDetay("Çevre ve Toplum", 1)
  ],
  "AYT Tarih-2": [
    KonuDetay("Tarih ve Zaman", 1),
    KonuDetay("İlk ve Orta Çağlarda Türk Dünyası", 1),
    KonuDetay("İslam Medeniyetinin Doğuşu", 1),
    KonuDetay("Türklerin İslamiyet'i Kabulü", 1),
    KonuDetay("Yerleşme ve Devletleşme Sürecinde Selçuklu", 1),
    KonuDetay("Beylikten Devlete Osmanlı", 1),
    KonuDetay("Dünya Gücü Osmanlı", 1),
    KonuDetay("Değişim Çağında Avrupa ve Osmanlı", 1),
    KonuDetay("Uluslararası İlişkilerde Denge Stratejisi", 1),
    KonuDetay("Devrimler Çağında Değişen Devlet-Toplum", 1),
    KonuDetay("Sermaye ve Emek", 1),
    KonuDetay("XIX. ve XX. Yüzyılda Değişen Gündelik Hayat", 1),
    KonuDetay("XX. Yüzyıl Başlarında Osmanlı Devleti ve Dünya", 1),
    KonuDetay("Milli Mücadele", 1),
    KonuDetay("Atatürkçülük ve Türk İnkılabı", 1),
    KonuDetay("İki Savaş Arasındaki Dönemde Türkiye ve Dünya", 1),
    KonuDetay("II. Dünya Savaşı Sürecinde Türkiye ve Dünya", 1),
    KonuDetay("II. Dünya Savaşı Sonrasında Türkiye ve Dünya", 1),
    KonuDetay("Toplumsal Devrim Çağında Dünya ve Türkiye", 1),
    KonuDetay("XXI. Yüzyılın Eşiğinde Türkiye ve Dünya", 1)
  ],
  "AYT Coğrafya-2": [
    KonuDetay("Ekosistemlerin İşleyişi", 1),
    KonuDetay("Nüfus Politikaları", 1),
    KonuDetay("Yerleşmeler", 1),
    KonuDetay("Ekonomik Faaliyetler ve Doğal Kaynaklar", 1),
    KonuDetay("Türkiye'de Ekonomi", 1),
    KonuDetay("Türkiye'nin İşlevsel Bölgeleri ve Kalkınma Projeleri", 1),
    KonuDetay("Hizmet Sektörü ve Ulaşım", 1),
    KonuDetay("Küresel Ticaret", 1),
    KonuDetay("Bölgeler ve Ülkeler", 1),
    KonuDetay("Çevre ve Toplum", 1)
  ],
  "AYT Felsefe Grubu": [
    KonuDetay("Mantığa Giriş", 1),
    KonuDetay("Klasik Mantık", 1),
    KonuDetay("Mantık ve Dil", 1),
    KonuDetay("Sembolik Mantık", 1),
    KonuDetay("Psikoloji Bilimini Tanıyalım", 1),
    KonuDetay("Psikolojinin Temel Süreçleri", 1),
    KonuDetay("Öğrenme Bellek Düşünme", 1),
    KonuDetay("Ruh Sağlığının Temelleri", 1),
    KonuDetay("Sosyolojiye Giriş", 1),
    KonuDetay("Birey ve Toplum", 1),
    KonuDetay("Toplumsal Yapı", 1),
    KonuDetay("Toplumsal Değişme ve Gelişme", 1),
    KonuDetay("Toplum ve Kültür", 1),
    KonuDetay("Toplumsal Kurumlar", 1)
  ],
  "AYT Din Kültürü": [
    KonuDetay("Dünya ve Ahiret", 1),
    KonuDetay("Kur'an'a Göre Hz. Muhammed", 1),
    KonuDetay("Kur'an'da Bazı Kavramlar", 1),
    KonuDetay("İnançla İlgili Meseleler", 1),
    KonuDetay("Yahudilik ve Hristiyanlık", 1),
    KonuDetay("İslam ve Bilim", 1),
    KonuDetay("Anadolu'da İslam", 1),
    KonuDetay("İslam Düşüncesinde Tasavvufi Yorumlar", 1),
    KonuDetay("Güncel Dini Meseleler", 1),
    KonuDetay("Hint ve Çin Dinleri", 1)
  ]
};

final Map<String, Map<String, dynamic>> tumDerslerGlobal = {};
void _initMufredat() {
  if (tumDerslerGlobal.isEmpty) {
    dersKonuAgirliklari.forEach((key, value) {
      List<String> konuAdlari = value.map((e) => e.ad).toList();
      tumDerslerGlobal[key] = {"katsayi": 10, "konular": konuAdlari};
    });
  }
}

void main() {
  VeriDeposu.baslat();
  _initMufredat();
  runApp(const YksTakipApp());
}

class YksTakipApp extends StatelessWidget {
  const YksTakipApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bayburt YKS',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const GirisEkrani());
  }
}

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});
  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani>
    with SingleTickerProviderStateMixin {
  late TabController _tc;
  final _k = TextEditingController();
  final _s = TextEditingController();
  bool _g = true;
  @override
  void initState() {
    super.initState();
    _tc = TabController(length: 3, vsync: this);
  }

  void _giris() {
    String k = _k.text.trim(), s = _s.text.trim();
    int r = _tc.index;
    if (r == 2 && k == "Halit155" && s == "05376835") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (c) => const YoneticiPaneli()),
          (r) => false);
      return;
    }
    if (r == 1) {
      var t = VeriDeposu.girisKontrol(k, s, "Öğretmen");
      if (t != null) {
        VeriDeposu.girisSayaciArtir(t.id, false);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (c) => OgretmenPaneli(aktifOgretmenId: t.id)),
            (r) => false);
      }
      return;
    }
    if (r == 0) {
      var o = VeriDeposu.girisKontrol(k, s, "Öğrenci");
      if (o != null) {
        VeriDeposu.girisSayaciArtir(o.id, true);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (c) => OgrenciAnaEkrani(ogrenciId: o.id)),
            (r) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(gradient: AppTheme.mainGradient),
            child: Center(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(children: [
                      Hero(
                          tag: 'logo',
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: ClipOval(
                                  child: Image.asset('assets/logo.jpg',
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                      errorBuilder: (c, o, s) => const Icon(
                                          Icons.school,
                                          size: 64))))),
                      const SizedBox(height: 24),
                      const Text("BAYBURT YKS TAKİP",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const SizedBox(height: 40),
                      Card(
                          child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(children: [
                                TabBar(
                                    controller: _tc,
                                    labelColor: AppTheme.primaryDark,
                                    unselectedLabelColor: Colors.grey,
                                    indicatorColor: AppTheme.accentColor,
                                    tabs: const [
                                      Tab(text: 'Öğrenci'),
                                      Tab(text: 'Öğretmen'),
                                      Tab(text: 'Yönetici')
                                    ]),
                                const SizedBox(height: 24),
                                TextField(
                                    controller: _k,
                                    decoration: const InputDecoration(
                                        labelText: "TC No",
                                        prefixIcon: Icon(Icons.badge))),
                                const SizedBox(height: 16),
                                TextField(
                                    controller: _s,
                                    obscureText: _g,
                                    decoration: InputDecoration(
                                        labelText: "Şifre",
                                        prefixIcon: const Icon(Icons.lock),
                                        suffixIcon: IconButton(
                                            icon: Icon(_g
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () =>
                                                setState(() => _g = !_g)))),
                                const SizedBox(height: 20),
                                SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: _giris,
                                        child: const Text("GİRİŞ YAP"))),
                                TextButton(
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) =>
                                                const KayitEkrani())),
                                    child: const Text("Kayıt Ol"))
                              ])))
                    ])))));
  }
}

class KayitEkrani extends StatefulWidget {
  const KayitEkrani({super.key});
  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  String rol = "Öğrenci";
  final _tc = TextEditingController(),
      _ad = TextEditingController(),
      _sifre = TextEditingController(),
      _detay = TextEditingController();
  void _kayit() {
    if (_tc.text.length != 11) return;
    VeriDeposu.yeniKayit(rol, _ad.text, _tc.text, _sifre.text, _detay.text);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Kayıt Başarılı!"), backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Kayıt Ol")),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              DropdownButtonFormField(
                  value: rol,
                  items: ["Öğrenci", "Öğretmen"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => rol = v!)),
              TextField(
                  controller: _ad,
                  decoration: const InputDecoration(labelText: "Ad Soyad")),
              TextField(
                  controller: _tc,
                  decoration: const InputDecoration(labelText: "TC")),
              TextField(
                  controller: _sifre,
                  decoration: const InputDecoration(labelText: "Şifre")),
              TextField(
                  controller: _detay,
                  decoration: const InputDecoration(labelText: "Sınıf/Branş")),
              ElevatedButton(onPressed: _kayit, child: const Text("KAYDET"))
            ])));
  }
}

class KisiselBilgiEkrani extends StatefulWidget {
  final String ogrenciId;
  const KisiselBilgiEkrani({super.key, required this.ogrenciId});
  @override
  State<KisiselBilgiEkrani> createState() => _KisiselBilgiEkraniState();
}

class _KisiselBilgiEkraniState extends State<KisiselBilgiEkrani> {
  late TextEditingController a, s, n, u, b, p;
  String f = "";
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    var o = VeriDeposu.ogrenciler.firstWhere((e) => e.id == widget.ogrenciId);
    a = TextEditingController(text: o.ad);
    s = TextEditingController(text: o.sinif);
    n = TextEditingController(text: o.id);
    u = TextEditingController(text: o.hedefUniversite);
    b = TextEditingController(text: o.hedefBolum);
    p = TextEditingController(text: o.hedefPuan.toString());
    f = o.fotoUrl;
  }

  void _save() {
    VeriDeposu.ogrenciGuncelle(widget.ogrenciId, a.text, s.text, n.text, f,
        u.text, b.text, int.tryParse(p.text) ?? 0);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (c) => OgrenciAnaEkrani(ogrenciId: n.text)));
  }

  Future<void> _fotoSec() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) setState(() => f = image.path);
    } catch (e) {}
  }

  ImageProvider _img() {
    if (f.isEmpty)
      return const NetworkImage(
          "https://cdn-icons-png.flaticon.com/512/3135/3135715.png");
    if (f.startsWith('http')) return NetworkImage(f);
    return FileImage(File(f));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Profil")),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              GestureDetector(
                  onTap: _fotoSec,
                  child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _img(),
                      child: f.isEmpty ? const Icon(Icons.camera_alt) : null)),
              TextField(
                  controller: a,
                  decoration: const InputDecoration(labelText: "Ad")),
              TextField(
                  controller: s,
                  decoration: const InputDecoration(labelText: "Sınıf")),
              TextField(
                  controller: n,
                  decoration: const InputDecoration(labelText: "No")),
              const Divider(),
              const Text("Hedeflerim",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextField(
                  controller: u,
                  decoration:
                      const InputDecoration(labelText: "Hedef Üniversite")),
              TextField(
                  controller: b,
                  decoration: const InputDecoration(labelText: "Hedef Bölüm")),
              TextField(
                  controller: p,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Hedef Puan")),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: const Text("KAYDET"))
            ])));
  }
}

// --------------------------------------------------------------------------------
// ÖĞRENCİ ANA EKRANI
// --------------------------------------------------------------------------------
class OgrenciAnaEkrani extends StatelessWidget {
  final String ogrenciId;
  const OgrenciAnaEkrani({super.key, required this.ogrenciId});
  ImageProvider _img(String url) {
    if (url.isEmpty)
      return const NetworkImage(
          "https://cdn-icons-png.flaticon.com/512/3135/3135715.png");
    if (url.startsWith('http')) return NetworkImage(url);
    return FileImage(File(url));
  }

  @override
  Widget build(BuildContext context) {
    var ogr = VeriDeposu.ogrenciler.firstWhere((e) => e.id == ogrenciId,
        orElse: () => VeriDeposu.ogrenciler[0]);
    var zayiflar = VeriDeposu.getZayifKonular(ogrenciId);
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: CustomScrollView(slivers: [
        SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
                    decoration:
                        const BoxDecoration(gradient: AppTheme.mainGradient),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Hero(
                              tag: 'p',
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: _img(ogr.fotoUrl))),
                          Text(ogr.ad,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          Text("${ogr.hedefUniversite} - ${ogr.hedefBolum}",
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontStyle: FontStyle.italic)),
                          Chip(
                              label: Text("Hedef: ${ogr.hedefPuan} Puan"),
                              backgroundColor: Colors.white,
                              labelStyle:
                                  const TextStyle(color: AppTheme.primaryDark))
                        ]))),
            actions: [
              IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) =>
                              KisiselBilgiEkrani(ogrenciId: ogrenciId)))),
              IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (c) => const GirisEkrani()),
                      (r) => false))
            ]),
        if (zayiflar.isNotEmpty)
          SliverToBoxAdapter(
              child: Card(
                  color: Colors.red[50],
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                      leading: const Icon(Icons.warning, color: Colors.red),
                      title: const Text("Zayıf Konular"),
                      subtitle: Text(zayiflar.join(", "))))),
        SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverGrid.count(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: [
                  _menuBtn(context, Icons.check_box, "KONU TAKİP", Colors.blue,
                      KonuTakipEkrani()),
                  _menuBtn(context, Icons.table_view, "PROGRAMIM",
                      Colors.blueGrey, TumProgramEkrani()),
                  _menuBtn(
                      context,
                      Icons.view_list,
                      "DENEME LİSTESİ",
                      Colors.deepPurple,
                      DenemeListesiEkrani(ogrenciId: ogrenciId)),
                  _menuBtn(context, Icons.bar_chart, "GRAFİK", Colors.purple,
                      BasariGrafigiEkrani(ogrenciId: ogrenciId)),
                  _menuBtn(context, Icons.check_circle, "GÜNLÜK TAKİP",
                      Colors.teal, GunlukTakipEkrani()),
                  _menuBtn(context, Icons.auto_awesome, "AI ASİSTAN",
                      Colors.indigoAccent, ProgramSihirbaziEkrani(mod: "AI")),
                  _menuBtn(context, Icons.edit_calendar, "MANUEL",
                      Colors.orange, ManuelProgramSihirbazi()),
                  _menuBtn(context, Icons.add_chart, "DENEME EKLE",
                      Colors.green, DenemeEkleEkrani(ogrenciId: ogrenciId)),
                  _menuBtn(context, Icons.school, "OKUL NOTLARI", Colors.brown,
                      OkulSinavlariEkrani()),
                  _menuBtn(context, Icons.format_list_numbered, "SORU TAKİP",
                      Colors.cyan, SoruTakipEkrani(ogrenciId: ogrenciId)),
                  _menuBtn(context, Icons.timer, "SAYAÇ", Colors.redAccent,
                      KronometreEkrani()),
                  _menuBtn(context, Icons.verified, "ROZETLERİM", Colors.amber,
                      RozetlerEkrani(ogrenci: ogr)),
                ]))
      ]),
    );
  }

  Widget _menuBtn(
      BuildContext context, IconData i, String t, Color c, Widget p) {
    return ModernDashboardCard(
        icon: i,
        title: t,
        color: c,
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (c) => p)));
  }
}

// --------------------------------------------------------------------------------
// YENİ: MANUEL PROGRAM SİHİRBAZI
// --------------------------------------------------------------------------------
class ManuelProgramSihirbazi extends StatefulWidget {
  const ManuelProgramSihirbazi({super.key});
  @override
  State<ManuelProgramSihirbazi> createState() => _MPSState();
}

class _MPSState extends State<ManuelProgramSihirbazi> {
  int _step = 0;
  String sinif = "12", alan = "Sayısal", stil = "30+5 (30 Dk Ders, 5 Dk Mola)";
  TimeOfDay basla = const TimeOfDay(hour: 18, minute: 0),
      bitis = const TimeOfDay(hour: 22, minute: 0);
  List<String> tatiller = [];
  Map<String, bool> dersler = {};

  @override
  void initState() {
    super.initState();
    _dersleriYenile();
  }

  void _dersleriYenile() {
    dersler.clear();
    dersKonuAgirliklari.forEach((k, v) {
      bool ekle = false;
      if (k.startsWith("TYT")) {
        ekle = true;
      } // TYT her zaman açık
      else if (sinif == "9" || sinif == "10") {
        ekle = false;
      } // 9-10 AYT görmez
      else {
        if (alan == "Sayısal" &&
            (k.contains("Matematik") ||
                k.contains("Fizik") ||
                k.contains("Kimya") ||
                k.contains("Biyoloji"))) ekle = true;
        if (alan == "Eşit Ağırlık" &&
            (k.contains("Matematik") ||
                k.contains("Edebiyat") ||
                k.contains("Tarih") ||
                k.contains("Coğrafya"))) ekle = true;
        if (alan == "Sözel" &&
            (k.contains("Edebiyat") ||
                k.contains("Tarih") ||
                k.contains("Coğrafya") ||
                k.contains("Felsefe") ||
                k.contains("Din"))) ekle = true;
      }
      if (ekle) dersler[k] = false; // Varsayılan: Seçili değil, öğrenci seçecek
    });
  }

  void _olustur() {
    List<String> secilenDersler = [];
    dersler.forEach((k, v) {
      if (v) secilenDersler.add(k);
    });

    if (secilenDersler.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Lütfen en az bir ders seçin!"),
          backgroundColor: Colors.red));
      return;
    }
    secilenDersler.shuffle();

    // Zamanlama
    int dersSuresi = 30;
    int molaSuresi = 5;
    if (stil.contains("35")) {
      dersSuresi = 35;
    } else if (stil.contains("40")) {
      dersSuresi = 40;
    } else if (stil.contains("45")) {
      dersSuresi = 45;
    } else if (stil.contains("50")) {
      dersSuresi = 50;
    } else if (stil.contains("60")) {
      dersSuresi = 60;
      molaSuresi = 10;
    } else if (stil.contains("Pomodoro")) {
      dersSuresi = 25;
      molaSuresi = 5;
    }

    int toplamDk =
        (bitis.hour * 60 + bitis.minute) - (basla.hour * 60 + basla.minute);
    int blokSayisi = toplamDk ~/ (dersSuresi + molaSuresi);
    if (blokSayisi < 1) blokSayisi = 1;

    List<Gorev> program = [];
    List<String> gunler = [
      "Pazartesi",
      "Salı",
      "Çarşamba",
      "Perşembe",
      "Cuma",
      "Cumartesi",
      "Pazar"
    ];
    int dersIndex = 0;

    // Mayıs Sonuna Kadar Hesapla
    DateTime now = DateTime.now();
    int examYear = now.month > 6 ? now.year + 1 : now.year;
    DateTime endOfMay = DateTime(examYear, 5, 31);
    int daysUntil = endOfMay.difference(now).inDays;
    int totalWeeks = (daysUntil / 7).ceil();
    if (totalWeeks < 1) totalWeeks = 1;

    for (int h = 1; h <= totalWeeks; h++) {
      for (var gun in gunler) {
        if (tatiller.contains(gun)) continue;
        for (int i = 0; i < blokSayisi; i++) {
          String ders = secilenDersler[dersIndex % secilenDersler.length];
          dersIndex++;

          // Konu Seçimi
          String konu = "Genel Tekrar";
          if (dersKonuAgirliklari.containsKey(ders)) {
            var konular = dersKonuAgirliklari[ders]!;
            int topicIndex = ((h / totalWeeks) * konular.length).floor();
            if (topicIndex >= konular.length) topicIndex = konular.length - 1;
            konu = konular[topicIndex].ad;
          }

          int startMin = (basla.hour * 60 + basla.minute) +
              (i * (dersSuresi + molaSuresi));
          int endMin = startMin + dersSuresi;
          String saatStr =
              "${(startMin ~/ 60).toString().padLeft(2, '0')}:${(startMin % 60).toString().padLeft(2, '0')} - ${(endMin ~/ 60).toString().padLeft(2, '0')}:${(endMin % 60).toString().padLeft(2, '0')}";
          program.add(Gorev(
              hafta: h,
              gun: gun,
              saat: saatStr,
              ders: ders,
              konu: konu,
              aciklama: "Çalışma"));
        }
      }
    }
    VeriDeposu.programiKaydet(program, "Manuel Program");
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => TumProgramEkrani()));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Programınız Oluşturuldu!"),
        backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Manuel Program Hazırlama")),
        body: Stepper(
            currentStep: _step,
            onStepContinue: () {
              if (_step < 3)
                setState(() => _step++);
              else
                _olustur();
            },
            onStepCancel: () {
              if (_step > 0) setState(() => _step--);
            },
            steps: [
              Step(
                  title: const Text("Sınıf & Alan"),
                  content: Column(children: [
                    DropdownButtonFormField(
                        value: sinif,
                        items: ["9", "10", "11", "12", "Mezun"]
                            .map((s) =>
                                DropdownMenuItem(value: s, child: Text(s)))
                            .toList(),
                        onChanged: (v) {
                          setState(() => sinif = v!);
                          _dersleriYenile();
                        }),
                    if (sinif != "9" && sinif != "10")
                      DropdownButtonFormField(
                          value: alan,
                          items: ["Sayısal", "Sözel", "Eşit Ağırlık", "Dil"]
                              .map((s) =>
                                  DropdownMenuItem(value: s, child: Text(s)))
                              .toList(),
                          onChanged: (v) {
                            setState(() => alan = v!);
                            _dersleriYenile();
                          })
                  ])),
              Step(
                  title: const Text("Zamanlama"),
                  content: Column(children: [
                    DropdownButtonFormField(
                        value: stil,
                        items: VeriDeposu.calismaStilleri
                            .map((s) =>
                                DropdownMenuItem(value: s, child: Text(s)))
                            .toList(),
                        onChanged: (v) {
                          setState(() => stil = v!);
                        }),
                    Row(children: [
                      TextButton(
                          onPressed: () async {
                            var t = await showTimePicker(
                                context: context, initialTime: basla);
                            if (t != null) setState(() => basla = t);
                          },
                          child: Text("Başla: ${basla.format(context)}")),
                      TextButton(
                          onPressed: () async {
                            var t = await showTimePicker(
                                context: context, initialTime: bitis);
                            if (t != null) setState(() => bitis = t);
                          },
                          child: Text("Bitir: ${bitis.format(context)}"))
                    ])
                  ])),
              Step(
                  title: const Text("Tatil Günleri"),
                  content: Wrap(
                      spacing: 5,
                      children: [
                        "Pazartesi",
                        "Salı",
                        "Çarşamba",
                        "Perşembe",
                        "Cuma",
                        "Cumartesi",
                        "Pazar"
                      ]
                          .map((g) => FilterChip(
                              label: Text(g),
                              selected: tatiller.contains(g),
                              onSelected: (v) => setState(() {
                                    v ? tatiller.add(g) : tatiller.remove(g);
                                  })))
                          .toList())),
              Step(
                  title: const Text("Dersleri Seçin"),
                  content: SizedBox(
                      height: 400,
                      child: ListView(
                          children: dersler.keys
                              .map((k) => CheckboxListTile(
                                  title: Text(k),
                                  value: dersler[k],
                                  onChanged: (v) =>
                                      setState(() => dersler[k] = v!)))
                              .toList())))
            ]));
  }
}

// --------------------------------------------------------------------------------
// MEVCUT YAPAY ZEKA ASİSTAN EKRANI (OTOMATİK DAĞITIM)
// --------------------------------------------------------------------------------
class ProgramSihirbaziEkrani extends StatefulWidget {
  const ProgramSihirbaziEkrani({super.key, this.mod = "Genel"});
  final String mod;
  @override
  State<ProgramSihirbaziEkrani> createState() => _PSEState();
}

class _PSEState extends State<ProgramSihirbaziEkrani> {
  int _step = 0;
  String sinif = "12",
      alan = "Sayısal",
      stil =
          "30+5 (30 Dk Ders, 5 Dk Mola)"; // DÜZELTİLDİ: Listede olan tam string
  TimeOfDay basla = const TimeOfDay(hour: 18, minute: 0),
      bitis = const TimeOfDay(hour: 22, minute: 0);
  List<String> tatiller = [];
  Map<String, bool> dersler = {};
  @override
  void initState() {
    super.initState();
    _dersleriYenile();
  }

  void _dersleriYenile() {
    dersler.clear();
    dersKonuAgirliklari.forEach((k, v) {
      bool ekle = false;
      if (k.startsWith("TYT")) {
        ekle = true;
      } else if (sinif == "9" || sinif == "10") {
        ekle = false;
      } else {
        if (alan == "Sayısal" &&
            (k.contains("Matematik") ||
                k.contains("Fizik") ||
                k.contains("Kimya") ||
                k.contains("Biyoloji"))) ekle = true;
        if (alan == "Eşit Ağırlık" &&
            (k.contains("Matematik") ||
                k.contains("Edebiyat") ||
                k.contains("Tarih") ||
                k.contains("Coğrafya"))) ekle = true;
        if (alan == "Sözel" &&
            (k.contains("Edebiyat") ||
                k.contains("Tarih") ||
                k.contains("Coğrafya") ||
                k.contains("Felsefe") ||
                k.contains("Din"))) ekle = true;
      }
      if (ekle) dersler[k] = true;
    });
  }

  // --- GELİŞMİŞ ALGORİTMA ---
  void _olustur() {
    List<List<Map<String, dynamic>>> program = [];
    List<String> gunler = [
      "Pazartesi",
      "Salı",
      "Çarşamba",
      "Perşembe",
      "Cuma",
      "Cumartesi",
      "Pazar"
    ];

    // Ağırlık Havuzu Oluşturma (Weight Pool)
    List<String> havuz = [];
    dersler.forEach((k, v) {
      if (v) {
        int agirlik = 1;
        // Senaryo 1 (TYT Odaklı)
        if (sinif == "9" || sinif == "10") {
          if (k.contains("Matematik"))
            agirlik = 40;
          else if (k.contains("Türkçe"))
            agirlik = 35;
          else if (k.contains("Fen"))
            agirlik = 15; // Toplam
          else
            agirlik = 10;
        }
        // Senaryo 2 (11-12. Sınıf)
        else {
          if (k.startsWith("AYT"))
            agirlik = 50; // AYT Öncelikli
          else if (k.contains("Matematik") || k.contains("Türkçe"))
            agirlik = 20;
          else
            agirlik = 5;
        }
        // Havuza Ekle
        for (int z = 0; z < agirlik; z++) havuz.add(k);
      }
    });
    havuz.shuffle();

    // Süre Hesapla
    int dersSuresi = 30;
    int molaSuresi = 5;
    if (stil.contains("35")) {
      dersSuresi = 35;
      molaSuresi = 5;
    } else if (stil.contains("40")) {
      dersSuresi = 40;
      molaSuresi = 5;
    } else if (stil.contains("45")) {
      dersSuresi = 45;
      molaSuresi = 5;
    } else if (stil.contains("50")) {
      dersSuresi = 50;
      molaSuresi = 5;
    } else if (stil.contains("60")) {
      dersSuresi = 60;
      molaSuresi = 10;
    } else if (stil.contains("Pomodoro")) {
      dersSuresi = 25;
      molaSuresi = 5;
    }

    int toplamDk =
        (bitis.hour * 60 + bitis.minute) - (basla.hour * 60 + basla.minute);
    int blokSayisi = toplamDk ~/ (dersSuresi + molaSuresi);
    if (blokSayisi < 1) blokSayisi = 1;

    // HESAPLAMA: BUGÜNDEN MAYIS SONUNA KADAR
    DateTime now = DateTime.now();
    int examYear = now.month > 6 ? now.year + 1 : now.year;
    DateTime endOfMay = DateTime(examYear, 5, 31);
    int daysUntil = endOfMay.difference(now).inDays;
    int totalWeeks = (daysUntil / 7).ceil();
    if (totalWeeks < 1) totalWeeks = 1;

    for (int h = 0; h < totalWeeks; h++) {
      // Tüm haftalar
      List<Map<String, dynamic>> hafta = [];
      for (var gun in gunler) {
        if (tatiller.contains(gun)) {
          hafta.add({'gun': gun, 'bloklar': []});
          continue;
        }
        List<Map<String, dynamic>> bloklar = [];
        for (int i = 0; i < blokSayisi; i++) {
          String ders = havuz.isNotEmpty
              ? havuz[Random().nextInt(havuz.length)]
              : "Serbest";

          // Konu Seçimi (Sırayla ve Süreye Yayılmış)
          String konu = "Genel Tekrar";
          if (dersKonuAgirliklari.containsKey(ders)) {
            var konular = dersKonuAgirliklari[ders]!;
            // Toplam haftaya yay:
            int topicIndex = ((h / totalWeeks) * konular.length).floor();
            if (topicIndex >= konular.length) topicIndex = konular.length - 1;
            konu = konular[topicIndex].ad;
          }

          String aktivite = (i % 2 == 0) ? "Konu Çalışma" : "Soru Çözümü";
          if (ders.contains("Matematik") && i % 3 == 0)
            aktivite = "Problem Çözümü"; // Matematik Özel Kural

          int startMin = (basla.hour * 60 + basla.minute) +
              (i * (dersSuresi + molaSuresi));
          int endMin = startMin + dersSuresi;

          String saatStr =
              "${(startMin ~/ 60).toString().padLeft(2, '0')}:${(startMin % 60).toString().padLeft(2, '0')} - ${(endMin ~/ 60).toString().padLeft(2, '0')}:${(endMin % 60).toString().padLeft(2, '0')}";

          if (widget.mod == "Manuel") {
            ders = "Ders Seç";
            konu = "Konu Seç";
            aktivite = "Aktivite Seç";
          }

          bloklar.add({
            'saat': saatStr,
            'ders': ders,
            'konu': konu,
            'aciklama': aktivite
          });
        }
        hafta.add({'gun': gun, 'bloklar': bloklar});
      }
      program.add(hafta);
    }

    // Veritabanına Kaydet
    VeriDeposu.kayitliProgram.clear();
    for (int i = 0; i < program.length; i++) {
      var h = program[i];
      int hNo = i + 1;
      for (var g in h) {
        for (var b in g['bloklar']) {
          VeriDeposu.kayitliProgram.add(Gorev(
              hafta: hNo,
              gun: g['gun'],
              saat: b['saat'],
              ders: b['ders'],
              konu: b['konu'],
              aciklama: b['aciklama']));
        }
      }
    }
    VeriDeposu.programArsivi.add(KayitliProgramGecmisi(
        tarih: DateTime.now(),
        tur: "${widget.mod} Program",
        programVerisi: List.from(VeriDeposu.kayitliProgram)));

    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (c) => TumProgramEkrani())); // Direkt Programa Git
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text("Program Hazırlandı! Düzenlemek için kutucuklara tıklayın."),
        backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("AI Sihirbazı")),
        body: Stepper(
            currentStep: _step,
            onStepContinue: () {
              if (_step < 3)
                setState(() => _step++);
              else
                _olustur();
            },
            onStepCancel: () {
              if (_step > 0) setState(() => _step--);
            },
            steps: [
              Step(
                  title: const Text("Sınıf & Alan"),
                  content: Column(children: [
                    DropdownButtonFormField(
                        value: sinif,
                        items: ["9", "10", "11", "12", "Mezun"]
                            .map((s) =>
                                DropdownMenuItem(value: s, child: Text(s)))
                            .toList(),
                        onChanged: (v) {
                          setState(() => sinif = v!);
                          _dersleriYenile();
                        }),
                    if (sinif != "9" && sinif != "10")
                      DropdownButtonFormField(
                          value: alan,
                          items: ["Sayısal", "Sözel", "Eşit Ağırlık", "Dil"]
                              .map((s) =>
                                  DropdownMenuItem(value: s, child: Text(s)))
                              .toList(),
                          onChanged: (v) {
                            setState(() => alan = v!);
                            _dersleriYenile();
                          })
                  ])),
              Step(
                  title: const Text("Zamanlama"),
                  content: Column(children: [
                    DropdownButtonFormField(
                        value: stil,
                        items: VeriDeposu.calismaStilleri
                            .map((s) =>
                                DropdownMenuItem(value: s, child: Text(s)))
                            .toList(),
                        onChanged: (v) => setState(() => stil = v!)),
                    Row(children: [
                      TextButton(
                          onPressed: () async {
                            var t = await showTimePicker(
                                context: context, initialTime: basla);
                            if (t != null) setState(() => basla = t);
                          },
                          child: Text("Başla: ${basla.format(context)}")),
                      TextButton(
                          onPressed: () async {
                            var t = await showTimePicker(
                                context: context, initialTime: bitis);
                            if (t != null) setState(() => bitis = t);
                          },
                          child: Text("Bitir: ${bitis.format(context)}"))
                    ])
                  ])),
              Step(
                  title: const Text("Tatil Günleri"),
                  content: Wrap(
                      spacing: 5,
                      children: [
                        "Pazartesi",
                        "Salı",
                        "Çarşamba",
                        "Perşembe",
                        "Cuma",
                        "Cumartesi",
                        "Pazar"
                      ]
                          .map((g) => FilterChip(
                              label: Text(g),
                              selected: tatiller.contains(g),
                              onSelected: (v) => setState(() {
                                    v ? tatiller.add(g) : tatiller.remove(g);
                                  })))
                          .toList())),
              Step(
                  title: const Text("Dersler (Filtrelenmiş)"),
                  content: SizedBox(
                      height: 300,
                      child: ListView(
                          children: dersler.keys
                              .map((k) => CheckboxListTile(
                                  title: Text(k),
                                  value: dersler[k],
                                  onChanged: (v) =>
                                      setState(() => dersler[k] = v!)))
                              .toList()))),
            ]));
  }
}

// --------------------------------------------------------
// 1. PROGRAMIM EKRANI (HAFTALIK GÖRÜNÜM + DÜZENLEME)
// --------------------------------------------------------
class TumProgramEkrani extends StatefulWidget {
  const TumProgramEkrani({super.key});
  @override
  State<TumProgramEkrani> createState() => _TPEState();
}

class _TPEState extends State<TumProgramEkrani>
    with SingleTickerProviderStateMixin {
  late TabController _tc;
  int hSayisi = 1;
  @override
  void initState() {
    super.initState();
    if (VeriDeposu.kayitliProgram.isNotEmpty)
      hSayisi = VeriDeposu.kayitliProgram.map((e) => e.hafta).reduce(max);
    _tc = TabController(length: hSayisi, vsync: this);
  }

  void _edit(Gorev g) {
    String? d = dersKonuAgirliklari.containsKey(g.ders) ? g.ders : null,
        k = g.konu,
        a = g.aciklama;
    showDialog(
        context: context,
        builder: (c) => StatefulBuilder(
            builder: (c, st) => AlertDialog(
                    title: const Text("Düzenle"),
                    content: Column(mainAxisSize: MainAxisSize.min, children: [
                      DropdownButton<String>(
                          isExpanded: true,
                          value: d,
                          hint: const Text("Ders"),
                          items: dersKonuAgirliklari.keys
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (v) => st(() {
                                d = v;
                                k = null;
                              })),
                      if (d != null)
                        DropdownButton<String>(
                            isExpanded: true,
                            value:
                                (dersKonuAgirliklari[d]!.any((x) => x.ad == k))
                                    ? k
                                    : null,
                            hint: const Text("Konu"),
                            items: dersKonuAgirliklari[d]!
                                .map((e) => DropdownMenuItem(
                                    value: e.ad, child: Text(e.ad)))
                                .toList(),
                            onChanged: (v) => st(() => k = v)),
                      DropdownButton<String>(
                          isExpanded: true,
                          value: VeriDeposu.aktiviteler.contains(a) ? a : null,
                          hint: const Text("Aktivite"),
                          items: VeriDeposu.aktiviteler
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (v) => st(() => a = v))
                    ]),
                    actions: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              if (d != null) g.ders = d!;
                              if (k != null) g.konu = k!;
                              if (a != null) g.aciklama = a!;
                            });
                            Navigator.pop(c);
                          },
                          child: const Text("KAYDET"))
                    ])));
  }

  void _pdfKaydet() {
    showDialog(
        context: context,
        builder: (c) => const AlertDialog(
            title: Text("PDF Hazır"),
            content: Text("Program PDF olarak indirildi.")));
  }

  @override
  Widget build(BuildContext context) {
    if (VeriDeposu.kayitliProgram.isEmpty)
      return Scaffold(
          appBar: AppBar(title: const Text("Program")),
          body: const Center(child: Text("Henüz program yok.")));
    // TABLO GÖRÜNÜMÜ
    return Scaffold(
        appBar: AppBar(
            title: const Text("Programım"),
            actions: [
              IconButton(
                  icon: const Icon(Icons.picture_as_pdf),
                  onPressed: _pdfKaydet),
              IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Kaydedildi"))))
            ],
            bottom: TabBar(
                controller: _tc,
                isScrollable: true,
                tabs: List.generate(hSayisi, (i) => Tab(text: "${i + 1}.H")))),
        body: TabBarView(
            controller: _tc,
            children: List.generate(hSayisi, (i) {
              int hafta = i + 1;
              var p = VeriDeposu.kayitliProgram
                  .where((x) => x.hafta == hafta)
                  .toList();
              List<String> gunler = [
                "Pazartesi",
                "Salı",
                "Çarşamba",
                "Perşembe",
                "Cuma",
                "Cumartesi",
                "Pazar"
              ];

              int maxDersSayisi = 0;
              for (var g in gunler) {
                int c = p.where((x) => x.gun == g).length;
                if (c > maxDersSayisi) maxDersSayisi = c;
              }
              if (maxDersSayisi == 0) maxDersSayisi = 1;

              List<DataColumn> cols = [
                const DataColumn(
                    label: Text("GÜN",
                        style: TextStyle(fontWeight: FontWeight.bold)))
              ];
              for (int k = 1; k <= maxDersSayisi; k++)
                cols.add(DataColumn(
                    label: Text("$k. ETÜT",
                        style: const TextStyle(fontWeight: FontWeight.bold))));

              List<DataRow> rows = gunler.map((g) {
                var dersler = p.where((x) => x.gun == g).toList();
                List<DataCell> cells = [
                  DataCell(Text(g,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue)))
                ];

                for (int k = 0; k < maxDersSayisi; k++) {
                  if (k < dersler.length) {
                    var d = dersler[k];
                    cells.add(DataCell(InkWell(
                        onTap: () => _edit(d),
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(5)),
                            width: 140,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(d.saat,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                  Text(d.ders,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis),
                                  Text(d.konu,
                                      style: const TextStyle(fontSize: 10),
                                      overflow: TextOverflow.ellipsis),
                                  Text("(${d.aciklama})",
                                      style: const TextStyle(
                                          fontSize: 9,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey))
                                ])))));
                  } else {
                    cells.add(const DataCell(Text("-")));
                  }
                }
                return DataRow(cells: cells);
              }).toList();

              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                          columns: cols,
                          rows: rows,
                          columnSpacing: 10,
                          dataRowMinHeight: 60,
                          dataRowMaxHeight: 90)));
            })));
  }
}

// --------------------------------------------------------
// 3. DETAYLI DENEME EKLEME (TYT / AYT AYRI)
// --------------------------------------------------------
class DenemeEkleEkrani extends StatefulWidget {
  final String ogrenciId;
  const DenemeEkleEkrani({super.key, required this.ogrenciId});
  @override
  State<DenemeEkleEkrani> createState() => _DEEState();
}

class _DEEState extends State<DenemeEkleEkrani> {
  // TYT
  List<DersGiris> tytDersleri = [
    DersGiris("TYT Türkçe", 40),
    DersGiris("TYT Sosyal - Tarih", 5),
    DersGiris("TYT Sosyal - Coğrafya", 5),
    DersGiris("TYT Sosyal - Felsefe", 5),
    DersGiris("TYT Sosyal - Din", 5),
    DersGiris("TYT Matematik", 40),
    DersGiris("TYT Fen - Fizik", 7),
    DersGiris("TYT Fen - Kimya", 7),
    DersGiris("TYT Fen - Biyoloji", 6)
  ];
  // AYT
  List<DersGiris> aytDersleri = [
    DersGiris("AYT Matematik", 40),
    DersGiris("AYT Fizik", 14),
    DersGiris("AYT Kimya", 13),
    DersGiris("AYT Biyoloji", 13),
    DersGiris("AYT Edebiyat", 24),
    DersGiris("AYT Tarih-1", 10),
    DersGiris("AYT Coğrafya-1", 6),
    DersGiris("AYT Tarih-2", 11),
    DersGiris("AYT Coğrafya-2", 11),
    DersGiris("AYT Felsefe Gr", 12),
    DersGiris("AYT Din", 6)
  ];

  double _netHesapla(List<DersGiris> liste) {
    double toplam = 0;
    for (var d in liste) {
      double dogru = double.tryParse(d.d.text) ?? 0;
      double yanlis = double.tryParse(d.y.text) ?? 0;
      // VALIDATION: Doğru + Yanlış <= Soru Sayısı
      if (dogru + yanlis > d.soruSayisi) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Hata: ${d.n} dersinde soru sayısı (${d.soruSayisi}) aşıldı!"),
            backgroundColor: Colors.red));
        return -1; // Hata kodu
      }
      d.net = dogru - (yanlis / 4);
      toplam += d.net;
    }
    return toplam;
  }

  void _kaydet(String tur, List<DersGiris> liste) {
    double toplamNet = _netHesapla(liste);
    if (toplamNet == -1) return; // Hata varsa kaydetme

    Map<String, double> detaylar = {for (var item in liste) item.n: item.net};

    VeriDeposu.denemeEkle(DenemeSonucu(
        ogrenciId: widget.ogrenciId,
        tur: tur,
        tarih: DateTime.now(),
        toplamNet: toplamNet,
        dersNetleri: detaylar));

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text("$tur Denemesi Eklendi. Net: ${toplamNet.toStringAsFixed(2)}"),
        backgroundColor: Colors.green));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Deneme Ekle"),
            bottom: const TabBar(tabs: [Tab(text: "TYT"), Tab(text: "AYT")])),
        body: TabBarView(children: [
          _buildForm("TYT", tytDersleri),
          _buildForm("AYT", aytDersleri)
        ]),
      ),
    );
  }

  Widget _buildForm(String tur, List<DersGiris> dersler) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: dersler.length,
            itemBuilder: (c, i) {
              var d = dersler[i];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text("${d.n} (${d.soruSayisi})",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          flex: 2,
                          child: TextField(
                              controller: d.d,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: "D", isDense: true))),
                      const SizedBox(width: 10),
                      Expanded(
                          flex: 2,
                          child: TextField(
                              controller: d.y,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: "Y", isDense: true))),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                onPressed: () => _kaydet(tur, dersler),
                child:
                    Text("$tur KAYDET", style: const TextStyle(fontSize: 18))),
          ),
        )
      ],
    );
  }
}

// --------------------------------------------------------
// DİĞER MODÜLLER (GÜNLÜK TAKİP, SAYAC, ETC.)
// --------------------------------------------------------
class GunlukTakipEkrani extends StatefulWidget {
  const GunlukTakipEkrani({super.key});
  @override
  State<GunlukTakipEkrani> createState() => _GTEState();
}

class _GTEState extends State<GunlukTakipEkrani> {
  int h = 1, maxH = 1;
  String bugun = [
    "Pazartesi",
    "Salı",
    "Çarşamba",
    "Perşembe",
    "Cuma",
    "Cumartesi",
    "Pazar"
  ][DateTime.now().weekday - 1];
  @override
  void initState() {
    super.initState();
    if (VeriDeposu.kayitliProgram.isNotEmpty)
      maxH = VeriDeposu.kayitliProgram.map((e) => e.hafta).reduce(max);
  }

  @override
  Widget build(BuildContext context) {
    var list = VeriDeposu.kayitliProgram
        .where((x) => x.hafta == h && x.gun == bugun)
        .toList();
    return Scaffold(
        appBar: AppBar(title: Text("Bugün: $bugun")),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<int>(
                  value: h,
                  items: List.generate(
                      maxH,
                      (i) => DropdownMenuItem(
                          value: i + 1, child: Text("${i + 1}. Hafta"))),
                  onChanged: (v) => setState(() => h = v!))),
          Expanded(
              child: list.isEmpty
                  ? const Center(child: Text("Bugün ders yok."))
                  : ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (c, i) {
                        var g = list[i];
                        return CheckboxListTile(
                            title: Text(g.ders),
                            subtitle: Text(g.konu),
                            value: g.yapildi,
                            onChanged: (v) => setState(() => g.yapildi = v!));
                      }))
        ]));
  }
}

class OkulSinavlariEkrani extends StatefulWidget {
  const OkulSinavlariEkrani({super.key});
  @override
  State<OkulSinavlariEkrani> createState() => _OSEState();
}

class _OSEState extends State<OkulSinavlariEkrani> {
  void _ekle() {
    final c1 = TextEditingController();
    final c2 = TextEditingController();
    final c3 = TextEditingController();
    final c4 = TextEditingController();
    showDialog(
        context: context,
        builder: (c) => AlertDialog(
                title: const Text("Ekle"),
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextField(
                      controller: c1,
                      decoration: const InputDecoration(labelText: "Ders")),
                  TextField(
                      controller: c2,
                      decoration: const InputDecoration(labelText: "Y1")),
                  TextField(
                      controller: c3,
                      decoration: const InputDecoration(labelText: "Y2")),
                  TextField(
                      controller: c4,
                      decoration: const InputDecoration(labelText: "Perf"))
                ]),
                actions: [
                  TextButton(
                      onPressed: () {
                        VeriDeposu.dersEkle(OkulDersi(
                            ad: c1.text,
                            yazili1: double.tryParse(c2.text) ?? 0,
                            yazili2: double.tryParse(c3.text) ?? 0,
                            performans: double.tryParse(c4.text) ?? 0));
                        setState(() {});
                        Navigator.pop(c);
                      },
                      child: const Text("OK"))
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Notlar")),
        body: ListView.builder(
            itemCount: VeriDeposu.okulNotlari.length,
            itemBuilder: (c, i) {
              var d = VeriDeposu.okulNotlari[i];
              return ListTile(
                  title: Text(d.ad),
                  trailing:
                      CircleAvatar(child: Text(d.ortalama.toStringAsFixed(0))));
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: _ekle, child: const Icon(Icons.add)));
  }
}

class KronometreEkrani extends StatefulWidget {
  const KronometreEkrani({super.key});
  @override
  State<KronometreEkrani> createState() => _KREState();
}

class _KREState extends State<KronometreEkrani> {
  Timer? _t;
  int _s = 0;
  bool _run = false;
  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  void _toggle() {
    if (_run)
      _t?.cancel();
    else
      _t = Timer.periodic(
          const Duration(seconds: 1), (t) => setState(() => _s++));
    setState(() => _run = !_run);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Sayaç")),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("${_s ~/ 60}:${(_s % 60).toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 80)),
          IconButton(
              icon: Icon(_run ? Icons.pause : Icons.play_arrow, size: 60),
              onPressed: _toggle)
        ])));
  }
}

class BasariGrafigiEkrani extends StatelessWidget {
  final String ogrenciId;
  const BasariGrafigiEkrani({super.key, required this.ogrenciId});
  @override
  Widget build(BuildContext context) {
    var l = VeriDeposu.denemeListesi
        .where((d) => d.ogrenciId == ogrenciId)
        .toList();
    return Scaffold(
        appBar: AppBar(title: const Text("Grafik")),
        body: l.isEmpty
            ? const Center(child: Text("Veri Yok"))
            : CustomPaint(size: Size.infinite, painter: ChartPainter(l)));
  }
}

class ChartPainter extends CustomPainter {
  final List<DenemeSonucu> d;
  ChartPainter(this.d);
  @override
  void paint(Canvas c, Size s) {
    Paint p = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    Path t = Path();
    for (int i = 0; i < d.length; i++) {
      double x = i * (s.width / (d.length > 1 ? d.length - 1 : 1));
      double y = s.height - (d[i].toplamNet / 120 * s.height);
      if (i == 0)
        t.moveTo(x, y);
      else
        t.lineTo(x, y);
      c.drawCircle(Offset(x, y), 5, Paint()..color = Colors.red);
    }
    c.drawPath(t, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}

class DenemeListesiEkrani extends StatelessWidget {
  final String? ogrenciId;
  const DenemeListesiEkrani({super.key, this.ogrenciId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Denemeler")),
        body: ListView.builder(
            itemCount: VeriDeposu.denemeListesi.length,
            itemBuilder: (c, i) => ListTile(
                title: Text(VeriDeposu.denemeListesi[i].tur),
                subtitle:
                    Text("Net: ${VeriDeposu.denemeListesi[i].toplamNet}"))));
  }
}

// --- ROZETLER EKRANI (REKABETÇİ VE GELİŞMİŞ) ---
class RozetlerEkrani extends StatelessWidget {
  final Ogrenci ogrenci;
  const RozetlerEkrani({super.key, required this.ogrenci});

  @override
  Widget build(BuildContext context) {
    var soruRozetleri =
        VeriDeposu.tumRozetler.where((r) => r.kategori == "Soru").toList();
    var konuRozetleri =
        VeriDeposu.tumRozetler.where((r) => r.kategori == "Konu").toList();
    var denemeRozetleri =
        VeriDeposu.tumRozetler.where((r) => r.kategori == "Deneme").toList();
    var seviyeRozetleri =
        VeriDeposu.tumRozetler.where((r) => r.kategori == "Seviye").toList();
    var siraliOgrenciler = List<Ogrenci>.from(VeriDeposu.ogrenciler);
    siraliOgrenciler.sort((a, b) => b.puan.compareTo(a.puan));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Başarılarım ve Sıralama"),
          bottom: const TabBar(
              tabs: [Tab(text: "Koleksiyonum"), Tab(text: "Liderlik Tablosu")]),
        ),
        body: TabBarView(
          children: [
            // TAB 1: KOLEKSİYON
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildRozetSection("🏆 Seviye Rozetleri", seviyeRozetleri),
                _buildRozetSection("🎯 Soru Rozetleri", soruRozetleri),
                _buildRozetSection("📚 Konu Rozetleri", konuRozetleri),
                _buildRozetSection("📝 Deneme Rozetleri", denemeRozetleri),
              ],
            ),
            // TAB 2: LİDERLİK TABLOSU
            ListView.builder(
              itemCount: siraliOgrenciler.length,
              itemBuilder: (context, index) {
                var o = siraliOgrenciler[index];
                bool isMe = o.id == ogrenci.id;
                return Card(
                  color: isMe ? Colors.green.shade50 : Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: index == 0
                          ? Colors.amber
                          : (index == 1
                              ? Colors.grey
                              : (index == 2 ? Colors.brown : Colors.blue)),
                      child: Text("${index + 1}"),
                    ),
                    title: Text(o.ad,
                        style: TextStyle(
                            fontWeight:
                                isMe ? FontWeight.bold : FontWeight.normal)),
                    trailing: Text("${o.puan} XP",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRozetSection(String title, List<Rozet> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold))),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 0.8),
          itemCount: list.length,
          itemBuilder: (c, i) {
            var r = list[i];
            return Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: r.kazanildi
                      ? r.renk.withOpacity(0.2)
                      : Colors.grey.shade200,
                  child: Icon(r.ikon,
                      color: r.kazanildi ? r.renk : Colors.grey, size: 30),
                ),
                const SizedBox(height: 5),
                Text(r.ad,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: r.kazanildi ? Colors.black : Colors.grey)),
                Text("${r.mevcutSayi}/${r.hedefSayi}",
                    style: const TextStyle(fontSize: 10)),
                if (!r.kazanildi)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: LinearProgressIndicator(
                        value: min(1.0, r.mevcutSayi / r.hedefSayi),
                        minHeight: 4,
                        color: r.renk,
                        backgroundColor: Colors.grey.shade300),
                  )
              ],
            );
          },
        ),
        const Divider()
      ],
    );
  }
}

class YoneticiPaneli extends StatelessWidget {
  const YoneticiPaneli({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Yönetici")),
        body: ListView(
            children: VeriDeposu.ogrenciler
                .map((o) => ListTile(
                    title: Text(o.ad),
                    trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => VeriDeposu.kullaniciSil(o.id, true))))
                .toList()));
  }
}

class OgretmenPaneli extends StatelessWidget {
  final String aktifOgretmenId;
  const OgretmenPaneli({super.key, required this.aktifOgretmenId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Öğretmen")),
        body: ListView(
            children: VeriDeposu.ogrenciler
                .map((o) => ListTile(
                    title: Text(o.ad),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) =>
                                OgretmenOgrenciDetayEkrani(ogrenci: o)))))
                .toList()));
  }
}

class OgretmenOgrenciDetayEkrani extends StatelessWidget {
  final Ogrenci ogrenci;
  const OgretmenOgrenciDetayEkrani({super.key, required this.ogrenci});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(ogrenci.ad)),
        body: Center(child: Text("Detaylar...")));
  }
}

class KonuTakipEkrani extends StatefulWidget {
  final bool readOnly;
  const KonuTakipEkrani({super.key, this.readOnly = false});
  @override
  State<KonuTakipEkrani> createState() => _KTE();
}

class _KTE extends State<KonuTakipEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Konular")),
        body: ListView(
            children: dersKonuAgirliklari.keys
                .map((d) => ExpansionTile(
                    title: Text(d),
                    children: dersKonuAgirliklari[d]!
                        .map((k) => CheckboxListTile(
                            title: Text(k.ad),
                            value:
                                VeriDeposu.tamamlananKonular["$d - ${k.ad}"] ??
                                    false,
                            onChanged: widget.readOnly
                                ? null
                                : (v) => setState(() =>
                                    VeriDeposu.konuDurumDegistir(
                                        "$d - ${k.ad}", v!))))
                        .toList()))
                .toList()));
  }
}

class SoruTakipEkrani extends StatefulWidget {
  final String ogrenciId;
  const SoruTakipEkrani({super.key, required this.ogrenciId});
  @override
  State<SoruTakipEkrani> createState() => _STE();
}

class _STE extends State<SoruTakipEkrani> {
  String? d, k;
  final c1 = TextEditingController(), c2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Soru Takip")),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              DropdownButton<String>(
                  isExpanded: true,
                  value: d,
                  hint: const Text("Ders"),
                  items: dersKonuAgirliklari.keys
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() {
                        d = v;
                        k = null;
                      })),
              if (d != null)
                DropdownButton<String>(
                    isExpanded: true,
                    value: k,
                    hint: const Text("Konu"),
                    items: dersKonuAgirliklari[d]!
                        .map((e) =>
                            DropdownMenuItem(value: e.ad, child: Text(e.ad)))
                        .toList(),
                    onChanged: (v) => setState(() => k = v)),
              Row(children: [
                Expanded(
                    child: TextField(
                        controller: c1,
                        decoration: const InputDecoration(labelText: "Doğru"))),
                const SizedBox(width: 10),
                Expanded(
                    child: TextField(
                        controller: c2,
                        decoration: const InputDecoration(labelText: "Yanlış")))
              ]),
              ElevatedButton(
                  onPressed: () {
                    VeriDeposu.soruEkle(SoruCozumKaydi(
                        ogrenciId: widget.ogrenciId,
                        ders: d!,
                        konu: k!,
                        dogru: int.parse(c1.text),
                        yanlis: int.parse(c2.text),
                        tarih: DateTime.now()));
                    setState(() {});
                  },
                  child: const Text("EKLE")),
              Expanded(
                  child: ListView.builder(
                      itemCount: VeriDeposu.soruCozumListesi
                          .where((x) => x.ogrenciId == widget.ogrenciId)
                          .length,
                      itemBuilder: (c, i) => ListTile(
                          title: Text(VeriDeposu.soruCozumListesi[i].konu),
                          trailing: Text(
                              "D:${VeriDeposu.soruCozumListesi[i].dogru} Y:${VeriDeposu.soruCozumListesi[i].yanlis}"))))
            ])));
  }
}
