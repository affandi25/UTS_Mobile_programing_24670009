# Donut App (Mobile Programming)

Aplikasi pemesanan donat berbasis **Flutter** yang responsif, modern, dan rapi sesuai dengan rancangan UI/UX Figma prototype.

---

## 📱 Daftar Halaman & Fitur
1. **Onboarding Screen**: Sambutan awal dan tombol navigasi ke login/registrasi.
2. **Auth (Login & Register)**: Form login dan register dengan validasi serta navigasi mulus.
3. **Main Navigation**: Bottom navigation bar 4 tab:
   - **Beranda (Home)**: Banner promo saldo/diskon, kategori donat, best seller, dan promo hemat.
   - **Menu / Katalog**: Katalog lengkap donat dengan filter kategori, pencarian, dan tombol pesan.
   - **Pesanan Saya (My Order)**: Riwayat dan status pesanan aktif dengan tab filter status.
   - **Profil (Profile)**: Kartu identitas pengguna/mahasiswa, statistik pesanan, informasi akun, dan tombol logout.

---

## 🚀 Panduan Menjalankan Proyek

### 1. Prasyarat
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versi 3.19.0 ke atas / Dart 3.0+)
- Android Studio, VS Code, atau editor pilihan Anda
- Emulator Android, Perangkat Fisik, atau Browser (Chrome/Edge)

### 2. Langkah Menjalankan
1. **Clone repository ini:**
   ```bash
   git clone <URL_REPOSITORY>
   cd flutter_application_2
   ```

2. **Unduh dependencies:**
   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi:**
   - Di Emulator Android / Device:
     ```bash
     flutter run
     ```
   - Di Browser (Chrome):
     ```bash
     flutter run -d chrome
     ```
   - Di Windows Desktop:
     ```bash
     flutter run -d windows
     ```

---

## 🛠️ Struktur Direktori Utama
- `lib/main.dart`: Titik masuk aplikasi (*entry point*).
- `lib/core/`: Tema warna (`app_colors.dart`), tipografi (`app_text_styles.dart`), dan konfigurasi tema (`app_theme.dart`).
- `lib/data/`: Data dummy produk, promo, dan pesanan (`dummy_data.dart`).
- `lib/screens/`: Seluruh layar aplikasi (Auth, Onboarding, Home, Menu, Order, Profile, MainNav).
- `asset/`: Aset gambar lokal (ilustrasi donat, banner promo, avatar, logo).
