# Flutter Project Architecture
**Target**: Struktur Kode Bersih, Terorganisir, dan Ramah Mahasiswa Semester 5  
**Lokasi Project**: `flutter_application_2/lib/`

---

## 1. Filosofi & Pendekatan Arsitektur

Berdasarkan analisis file latihan sebelumnya (`main.dart` dan `tugas_muhammad yusuf affandi_24670009.dart`), kamu sudah memahami widget dasar seperti `Container`, `Column`, `Row`, `Text`, `BoxDecoration`, dan navigasi `Navigator.push`.

Tantangan saat membuat aplikasi besar dari Figma adalah **menghindari menumpuk semua kode dalam 1 file besar** (*spaghetti code*). 

Oleh karena itu, arsitektur yang kita gunakan menganut prinsip **Feature-First / Component-Driven**:
1. **Pemisahan File Berdasarkan Layar (Screen)**: Setiap halaman (Login, Home, Detail, dll.) berada di filenya masing-masing.
2. **Pemisahan Konstanta (Constants)**: Warna dan gaya teks dikumpulkan di satu file agar tidak perlu menulis ulang `Color(0xFF...)` berulang kali.
3. **Komponen Reusable (Reusable Widgets)**: Komponen yang dipakai berulang kali (seperti Tombol Custom, Input Field, Counter) dipisah ke folder `widgets/`.
4. **State Management Sederhana**: Menggunakan `StatefulWidget` bawaan Flutter. Sangat stabil, mudah dipahami alurnya, dan tidak memerlukan package pihak ketiga yang membingungkan saat ditanya dosen.

---

## 2. Struktur Folder & File yang Direkomendasikan

```
flutter_application_2/
├── asset/                          <-- Gambar produk, logo, dan avatar
│   ├── logo.png
│   ├── yusuf.jpeg
│   ├── banner_promo.png
│   ├── rasa_coklat.png
│   ├── rasa_strawberi.png
│   ├── rasa_taro.png
│   ├── rasa_matcha.png
│   └── rasa_tiramisu.png
│
├── lib/
│   ├── main.dart                   <-- Entry point & inisialisasi tema
│   │
│   ├── core/                       <-- Konstanta global
│   │   ├── app_colors.dart         <-- Definisi semua warna Figma
│   │   ├── app_text_styles.dart    <-- Definisi ukuran & ketebalan font
│   │   └── app_theme.dart          <-- ThemeData Material Flutter
│   │
│   ├── models/                     <-- Model data (Struktur Object)
│   │   ├── product_model.dart      <-- Blueprint menu (nama, rasa, harga, gambar)
│   │   ├── topping_model.dart      <-- Blueprint topping (nama, harga, terpilih)
│   │   ├── order_model.dart        <-- Blueprint pesanan aktif
│   │   ├── user_model.dart         <-- Blueprint profil & akun pengguna
│   │   └── notification_model.dart <-- Blueprint notifikasi & badge status
│   │
│   ├── services/                   <-- Lapisan Layanan Bisnis & Sesi
│   │   ├── auth_service.dart       <-- Pengelola sesi login, register, & logout
│   │   └── notification_service.dart<-- Pengelola notifikasi pesanan & promo
│   │
│   ├── data/                       <-- Data tiruan lokal (Dummy Data)
│   │   └── dummy_data.dart         <-- List data master produk, topping, & initial order
│   │
│   ├── screens/                    <-- Halaman-halaman aplikasi (Feature-First)
│   │   ├── onboarding/
│   │   │   └── onboarding_screen.dart  <-- Layar "ENJOY YOUR FOOD"
│   │   ├── auth/
│   │   │   ├── login_screen.dart       <-- Layar Login form
│   │   │   └── register_screen.dart    <-- Layar Register
│   │   ├── main_nav_screen.dart        <-- Shell navigasi BottomNavigationBar
│   │   ├── home/
│   │   │   └── home_screen.dart        <-- Beranda (Banner Carousel, Best Seller)
│   │   ├── menu/
│   │   │   ├── menu_catalog_screen.dart <-- Halaman daftar varian rasa donut
│   │   │   └── product_detail_screen.dart<-- Halaman pilih topping & jumlah
│   │   ├── order/
│   │   │   ├── payment_success_screen.dart <-- Halaman sukses bayar
│   │   │   └── my_order_screen.dart        <-- Halaman riwayat pesanan (My Order)
│   │   └── profile/
│   │       └── profile_screen.dart         <-- Profil Yusuf Affandi & Setting
│   │
│   └── widgets/                    <-- Komponen umum yang dipakai lintas halaman
│       ├── catalog_item_card.dart  <-- Card donut katalog varian rasa
│       ├── promo_banner_slider.dart<-- Carousel banner promo dengan dot indicator
│       ├── quantity_counter.dart   <-- Tombol counter jumlah (+/-)
│       └── topping_selector.dart   <-- Pemilih topping donat
```

---

## 3. Penjelasan Layer & Alur Kerja

### 3.1. Core Layer (`lib/core/`)
Menyimpan variabel yang tidak berubah.
* `app_colors.dart`:
  ```dart
  import 'package:flutter/material.dart';

  class AppColors {
    static const Color primaryGold = Color(0xFFD19025);
    static const Color goldMedium = Color(0xFFD9AC40);
    static const Color scaffoldBg = Color(0xFFFFFDF9);
    static const Color navyButton = Color(0xFF2A5EB0);
    static const Color textDark = Color(0xFF1D1B20);
    static const Color grayInput = Color(0xFFD9D9D9);
  }
  ```
  Dengan cara ini, jika di kemudian hari ingin mengganti warna tema, cukup ubah di satu tempat saja!

### 3.2. Model Layer (`lib/models/`)
Mendefinisikan tipe data agar kode lebih terstruktur dan *type-safe*:
```dart
class ProductModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imagePath;
  final String description;

  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imagePath,
    required this.description,
  });
}
```

### 3.3. Navigation Layer
Navigasi antar halaman menggunakan `Navigator.push` standar yang sudah kamu pelajari di latihan sebelumnya:
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const LoginScreen()),
);
```
Untuk halaman utama, kita menggunakan `MainNavigationScreen` yang mengelola `BottomNavigationBar` dengan `IndexedStack` atau pergantian `currentIndex`, sehingga tab Home, Katalog, Order, dan Profil berpindah dengan sangat responsif.

---

## 4. Keuntungan Arsitektur Ini untuk Tugas Kuliah
1. **Tidak Membingungkan**: Lapisan kode terorganisir (UI terpisah dari Service dan Model).
2. **Mudah Dipresentasikan**: Sangat jelas saat kamu menjelaskan ke dosen: *"Ini bagian view-nya pak, ini datanya, dan ini service API-nya"*.
3. **Mudah Diuji Coba**: Setiap layar bisa dibuka dan ditest secara independen.

---

## 5. Integrasi Client-Server: Flutter $\leftrightarrow$ Laravel REST API $\leftrightarrow$ MySQL

```
┌─────────────────────────────────┐
│     FLUTTER MOBILE CLIENT       │
│  (UI Screens & Widgets)         │
└────────────────┬────────────────┘
                 │ HTTP (JSON) via ApiService
                 ▼
┌─────────────────────────────────┐
│     LARAVEL REST API SERVER     │
│  (Routes, Controllers, Auth)    │
└────────────────┬────────────────┘
                 │ Eloquent ORM
                 ▼
┌─────────────────────────────────┐
│     DATABASE RELASIONAL (MySQL) │
│  (Users, Cart, Orders, Notif)   │
└─────────────────────────────────┘
```

### 5.1. Service Layer (`lib/services/api_service.dart`)
Semua komunikasi jaringan dipusatkan pada satu file service agar aman dan mudah diganti:
* Menghubungkan endpoint autentikasi (`/api/login`, `/api/register`, `/api/logout`), keranjang belanja (`/api/cart`), transaksi (`/api/checkout`, `/api/orders`), notifikasi (`/api/notifications`), dan profil pengguna (`/api/profile`).
* Menyimpan token sesi autentikasi (`Bearer Token`).
* Master varian menu donat tetap menggunakan data lokal (`DummyData.products`) sehingga aplikasi sangat cepat dan andal.


### 5.2. Konfigurasi Base URL Jaringan
* **Android Emulator**: `http://10.0.2.2:8000/api` (alias localhost komputer di emulator Android).
* **Perangkat HP Fisik (Kabel / Wi-Fi)**: `http://192.168.X.X:8000/api` (IP lokal PC).
* **Chrome / Desktop**: `http://127.0.0.1:8000/api`.

### 5.3. Graceful Offline Fallback (*Zero-Crash Guarantee*)
Jika server Laravel sedang tidak dijalankan (`php artisan serve` mati), Flutter secara cerdas akan otomatis menggunakan data lokal (*Dummy Fallback*) sehingga aplikasi tidak pernah *force close* atau *blank screen* saat presentasi di depan dosen.

### 5.4. Alur Manajemen Sesi & Autentikasi Pengguna (Login & Session Flow)
1. **Input & Validasi Client**: Form [login_screen.dart](file:///d:/semester%205/mobile%20programing/latihan%202/flutter_application_2/lib/screens/login_screen.dart) memeriksa kelengkapan email & password.
2. **Autentikasi Server**: Mengirim `POST /api/login` ke Laravel, diverifikasi dengan data terenkripsi di tabel MySQL `users`.
3. **Penyimpanan Lokal (`SharedPreferences`)**: Token akses (Bearer Token) dan data profil user disimpan di memori HP lokal.
4. **Reaktivitas UI**:
   * Header [home_screen.dart](file:///d:/semester%205/mobile%20programing/latihan%202/flutter_application_2/lib/screens/home_screen.dart) otomatis menyapa nama user aktif (*"Hallo, [Nama]!"*).
   * Layar [profile_screen.dart](file:///d:/semester%205/mobile%20programing/latihan%202/flutter_application_2/lib/screens/profile_screen.dart) otomatis menampilkan biodata user yang sedang login.
5. **Auto-Login & Logout**:
   * **Auto-Login**: Saat aplikasi dibuka, splash screen memeriksa apakah token tersimpan di memori. Jika ada, langsung ke [MainNavigationScreen](file:///d:/semester%205/mobile%20programing/latihan%202/flutter_application_2/lib/screens/main_nav_screen.dart) tanpa perlu login ulang.
   * **Logout**: Menekan tombol *"Keluar"* di Profil menghapus token dari memori lokal dan mengembalikan pengguna ke halaman Login.

### 5.5. Arsitektur Reaktivitas Beranda (Home Screen Living System Architecture)
```
┌────────────────────────────────────────────────────────┐
│                   HOME SCREEN SHELL                    │
├────────────────────────────────────────────────────────┤
│ 1. Header & Sapaan  ◄─── Sesi User (SharedPreferences) │
│ 2. Lonceng Notif    ◄─── NotificationService (Unread)  │
│ 3. Search Bar       ───► Navigasi Katalog + Keyword    │
│ 4. Banner Promo     ───► CouponService (Klaim Voucher) │
│ 5. Quick Actions    ───► Tab Navigation & Outlet Info  │
│ 6. Best Seller List ◄─── Master Data Produk Lokal      │
└────────────────────────────────────────────────────────┘
```
* **State Lonceng Notifikasi**: Menggunakan *ValueNotifier* atau *Stateful Callback* agar saat pesanan dibuat di layar pembayaran, lonceng langsung mengupdate hitungan badge secara seketika (*reactive real-time*).
* **Interaktivitas Terhubung**: Semua aksi di Beranda terhubung langsung dengan tab Katalog, Keranjang, dan Pesanan Saya.

### 5.6. Arsitektur Katalog & Keranjang Belanja (Catalog & Cart System)
1. **Master Data Menu Lokal (`DummyData.products`)**:
   * Menyimpan 6 varian donat khas toko secara lokal dan terstruktur. Ringan, cepat, dan 100% aman dari resiko kegagalan koneksi API menu.
2. **Integrasi Pencarian Antar Halaman**:
   * Search Bar di Beranda mengirimkan query pencarian ke `MenuCatalogScreen(initialSearchQuery: ...)`.
3. **Pusat Keranjang Belanja (`CartService`)**:
   * Mengelola daftar item yang dipilih pembeli (multi-produk dengan topping masing-masing).
   * Badge keranjang di header Katalog dan Beranda selalu sinkron secara otomatis.

### 5.7. Arsitektur Pemesanan & Alur Checkout (Order & Checkout Pipeline)
```
┌─────────────────────────┐
│  ProductDetailScreen /  │ ── 1. Pilih Donat, Topping, Qty
│  Shopping Cart Sheet    │ ── 2. Ubah Alamat & Pilih Metode Bayar
└───────────┬─────────────┘ ── 3. Pasang Kupon Diskon Beranda
            │
            ▼ (Klik PESAN SEKARANG / CHECKOUT SEMUA)
┌─────────────────────────┐
│  PaymentSuccessScreen   │ ── 4. Simulasi Pembayaran (1.5s)
│  (Payment Gateway Mock) │ ── 5. Terbitkan No. Invoice (#ORD-YYYYMMDD-XXX)
└───────────┬─────────────┘
            │
            ├──────────────────────────────────────────┐
            ▼                                          ▼
┌─────────────────────────┐                ┌─────────────────────────┐
│  Pusat Notifikasi       │                │  My Order (Pesanan)     │
│  Lonceng Beranda (+1)   │                │  Insert Index 0         │
│  "Pesanan Sedang Dibuat"│                │  Status: "delivery"     │
└─────────────────────────┘                └─────────────────────────┘
```

### 5.8. Arsitektur Siklus Hidup Pesanan (Order Lifecycle & Detail Sheet Architecture)
```
  [Checkout Selesai]
          │
          ▼
   Status: Diproses (Kuning/Oranye - Dapur menyiapkan donat)
          │
          ▼
   Status: Sedang Diantar (delivery) (Hijau Terang - Kurir meluncur)
          │
          ▼ (Klik tombol "Pesanan Diterima")
   Status: Selesai (Hijau Sukses - Transaksi ditutup)
          │
          ├──► Update State Lokal & Database MySQL (`orders.status`)
          └──► Pemicu Notifikasi Lonceng: "Pesanan Telah Selesai!"
```
* **Order Detail Sheet**: Menampilkan invoice struk digital lengkap dengan rincian biaya donat, topping, diskon voucher, alamat tujuan, dan tombol pintas chat bantuan.

### 5.9. Arsitektur Manajemen Profil & Sinkronisasi Sesi (User Profile Architecture)
```
┌────────────────────────────────────────────────────────┐
│                   PROFILE SCREEN                       │
├────────────────────────────────────────────────────────┤
│ 1. Identitas Akun   ◄─── Sesi Login / MySQL Users      │
│ 2. Foto Profil      ───► Image Picker / File Storage   │
│ 3. Edit Biodata     ───► PUT /api/profile & Local Sync │
│ 4. Ubah Sandi       ───► Hash::check Verification      │
│ 5. Tombol Keluar    ───► POST /api/logout & Clear Auth │
└───────────────────────────┬────────────────────────────┘
                            │ (Perubahan Nama & Foto)
                            ▼
┌────────────────────────────────────────────────────────┐
│               HEADER BERANDA (HOME SCREEN)             │
│        Sapaan "Hallo, [Nama Baru]!" & Avatar Baru      │
└────────────────────────────────────────────────────────┘
```







