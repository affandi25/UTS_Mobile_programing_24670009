import os
import base64

def get_base64_image(image_path):
    if os.path.exists(image_path):
        with open(image_path, "rb") as f:
            encoded = base64.b64encode(f.read()).decode("utf-8")
            ext = os.path.splitext(image_path)[1].replace(".", "").lower()
            if ext == "jpg":
                ext = "jpeg"
            return f"data:image/{ext};base64,{encoded}"
    return ""

img_onboarding = get_base64_image(r"screenshots\01_onboarding.png")
img_login = get_base64_image(r"screenshots\02_login.png")
img_home = get_base64_image(r"screenshots\03_home_utama.png")
img_menu = get_base64_image(r"screenshots\04_katalog_menu.png")
img_order = get_base64_image(r"screenshots\05_detail_order.png")
img_profile = get_base64_image(r"screenshots\06_profil_mahasiswa.png")

html_content = f"""<!DOCTYPE html>
<html lang="id">
<head>
<meta charset="UTF-8">
<title>Laporan UTS Mobile Programming - Muhammad Yusuf Affandi (24670009)</title>
<style>
  @page {{
    size: A4 portrait;
    margin: 10mm 12mm 10mm 12mm;
  }}
  * {{
    box-sizing: border-box;
    margin: 0;
    padding: 0;
  }}
  body {{
    font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, Helvetica, Arial, sans-serif;
    color: #1E293B;
    background-color: #FFFFFF;
    line-height: 1.35;
    font-size: 8.8pt;
  }}
  .page {{
    page-break-after: always;
    height: 275mm;
    max-height: 275mm;
    overflow: hidden;
    position: relative;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }}
  .page:last-child {{
    page-break-after: avoid;
  }}
  .content-wrap {{
    flex: 1;
  }}
  
  /* Header Kop Kampus */
  .header-table {{
    width: 100%;
    border-bottom: 2px double #1E3A8A;
    padding-bottom: 5px;
    margin-bottom: 8px;
    text-align: center;
  }}
  .kampus-title h1 {{
    font-size: 11.5pt;
    font-weight: 800;
    color: #1E3A8A;
    letter-spacing: 0.5px;
    text-transform: uppercase;
    margin-bottom: 1px;
  }}
  .kampus-title h2 {{
    font-size: 10pt;
    font-weight: 700;
    color: #2563EB;
    margin-bottom: 1px;
  }}
  .kampus-title p {{
    font-size: 8pt;
    color: #475569;
  }}

  /* Student Bio Card */
  .bio-box {{
    background: #F8FAFC;
    border: 1px solid #CBD5E1;
    border-left: 4px solid #D4A017;
    border-radius: 5px;
    padding: 6px 10px;
    margin-bottom: 8px;
  }}
  .bio-grid {{
    width: 100%;
    border-collapse: collapse;
  }}
  .bio-grid td {{
    padding: 1.5px 3px;
    font-size: 8.5pt;
    vertical-align: top;
  }}
  .bio-grid td.label {{
    font-weight: 600;
    color: #475569;
    width: 135px;
  }}
  .bio-grid td.colon {{
    width: 8px;
    text-align: center;
  }}
  .bio-grid td.value {{
    color: #0F172A;
    font-weight: 500;
  }}

  /* Section Titles */
  h2.section-header {{
    font-size: 10.5pt;
    color: #1E3A8A;
    border-bottom: 1px solid #CBD5E1;
    padding-bottom: 3px;
    margin-top: 6px;
    margin-bottom: 6px;
    display: flex;
    align-items: center;
  }}
  h2.section-header span.badge {{
    background: #D4A017;
    color: white;
    font-size: 8pt;
    padding: 1.5px 5px;
    border-radius: 3px;
    margin-right: 6px;
    font-weight: bold;
  }}
  h3.sub-header {{
    font-size: 9.2pt;
    color: #2563EB;
    margin-top: 5px;
    margin-bottom: 2px;
    font-weight: 700;
  }}
  p, li {{
    font-size: 8.5pt;
    text-align: justify;
    margin-bottom: 4px;
    line-height: 1.35;
  }}
  ul, ol {{
    margin-left: 16px;
    margin-bottom: 5px;
  }}

  /* Tables */
  .table-custom {{
    width: 100%;
    border-collapse: collapse;
    margin: 6px 0 6px 0;
    font-size: 8pt;
  }}
  .table-custom th {{
    background: #1E3A8A;
    color: #FFFFFF;
    padding: 4px 6px;
    text-align: left;
    font-weight: 600;
    border: 1px solid #94A3B8;
  }}
  .table-custom td {{
    padding: 3.5px 6px;
    border: 1px solid #CBD5E1;
    vertical-align: top;
    line-height: 1.25;
  }}
  .table-custom tr:nth-child(even) {{
    background: #F8FAFC;
  }}

  /* Code Blocks */
  pre.code-snippet {{
    background: #0F172A;
    color: #F8FAFC;
    padding: 4px 8px;
    border-radius: 4px;
    font-family: 'Consolas', 'Courier New', monospace;
    font-size: 7.2pt;
    line-height: 1.25;
    margin: 3px 0 5px 0;
    overflow-x: hidden;
    white-space: pre-wrap;
    word-break: break-all;
    border-left: 3px solid #D4A017;
  }}
  code.inline {{
    background: #F1F5F9;
    color: #BE185D;
    padding: 0.5px 3px;
    border-radius: 2px;
    font-family: 'Consolas', monospace;
    font-size: 8pt;
    font-weight: 600;
  }}

  /* Screenshot Showcase */
  .screenshot-grid {{
    display: table;
    width: 100%;
    margin-top: 4px;
    margin-bottom: 6px;
  }}
  .screenshot-row {{
    display: table-row;
  }}
  .screenshot-cell {{
    display: table-cell;
    width: 33.33%;
    padding: 4px 6px;
    text-align: center;
    vertical-align: top;
  }}
  .phone-frame {{
    background: #FFFFFF;
    border: 1px solid #CBD5E1;
    border-radius: 8px;
    padding: 2px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.06);
    display: inline-block;
  }}
  .phone-frame img {{
    width: 100%;
    max-width: 145px;
    height: auto;
    border-radius: 6px;
    display: block;
  }}
  .screenshot-title {{
    font-weight: 700;
    font-size: 8pt;
    color: #1E3A8A;
    margin-top: 3px;
  }}
  .screenshot-desc {{
    font-size: 7.2pt;
    color: #64748B;
    line-height: 1.2;
    margin-top: 1px;
  }}

  /* Callout */
  .callout {{
    background: #EFF6FF;
    border-left: 3px solid #2563EB;
    padding: 5px 8px;
    border-radius: 4px;
    margin: 5px 0;
    font-size: 8pt;
    line-height: 1.3;
  }}
  .callout-title {{
    font-weight: bold;
    color: #1E40AF;
    margin-bottom: 2px;
  }}

  /* Footer */
  .page-footer {{
    border-top: 1px solid #E2E8F0;
    padding-top: 3px;
    text-align: center;
    font-size: 7.5pt;
    color: #94A3B8;
  }}
</style>
</head>
<body>

  <!-- ==================== HALAMAN 1 ==================== -->
  <div class="page">
    <div class="content-wrap">
      <div class="header-table">
        <div class="kampus-title">
          <h1>FAKULTAS TEKNIK DAN INFORMATIKA</h1>
          <h2>UNIVERSITAS PGRI SEMARANG</h2>
          <p>UJIAN TENGAH SEMESTER (UTS) GASAL TAHUN AKADEMIK 2026/2027</p>
          <p style="font-weight: 700; color: #1E3A8A; margin-top: 1px;">LAPORAN RESMI PENJELASAN APLIKASI MOBILE PROGRAMMING</p>
        </div>
      </div>

      <div class="bio-box">
        <table class="bio-grid">
          <tr>
            <td class="label">Mata Kuliah / SKS</td>
            <td class="colon">:</td>
            <td class="value">Mobile Programming (3 SKS)</td>
            <td class="label">Nama Mahasiswa</td>
            <td class="colon">:</td>
            <td class="value"><strong>Muhammad Yusuf Affandi</strong></td>
          </tr>
          <tr>
            <td class="label">Dosen Pengampu</td>
            <td class="colon">:</td>
            <td class="value">Aris Tri Joko Harjanto, S.Kom., M.Kom.</td>
            <td class="label">NIM</td>
            <td class="colon">:</td>
            <td class="value"><strong>24670009</strong></td>
          </tr>
          <tr>
            <td class="label">Program Studi / Kelas</td>
            <td class="colon">:</td>
            <td class="value">Informatika / Semester V / Kelas A/F</td>
            <td class="label">Repository GitHub</td>
            <td class="colon">:</td>
            <td class="value">affandi25/UTS_Mobile_programing_24670009</td>
          </tr>
          <tr>
            <td class="label">Hari, Tanggal Ujian</td>
            <td class="colon">:</td>
            <td class="value">Kamis, 29 Oktober 2026</td>
            <td class="label">Sifat Ujian</td>
            <td class="colon">:</td>
            <td class="value">Open Book / Project Assignment (Blended)</td>
          </tr>
        </table>
      </div>

      <!-- POIN 1 -->
      <h2 class="section-header"><span class="badge">POIN 1</span> NAMA DAN TUJUAN APLIKASI</h2>
      <h3 class="sub-header">1.1. Identitas &amp; Nama Aplikasi</h3>
      <p>
        Aplikasi mobile yang dibangun bernama <strong>"Sweet Dessert &amp; Donut App" (SweetBite Mobile)</strong>. Aplikasi ini merupakan sistem digital pemesanan makanan/dessert modern (F&amp;B) spesialis donat gulung dengan berbagai pilihan topping dan rasa premium, dirancang berbasis <strong>Flutter</strong> dengan antarmuka presisi tinggi sesuai standar UI/UX modern.
      </p>
      <h3 class="sub-header">1.2. Tujuan Pengembangan Aplikasi</h3>
      <ul>
        <li><strong>Solusi Pemesanan Praktis (F&amp;B)</strong>: Memberikan kemudahan bagi konsumen (khususnya mahasiswa dan masyarakat) untuk menjelajahi katalog donat, mengecek promo kupon diskon, kustomisasi topping, serta memilih metode pembayaran secara instan tanpa perlu antre di gerai fisik.</li>
        <li><strong>Antarmuka Menarik &amp; Responsif (Rich Aesthetics)</strong>: Menyajikan visual hangat bergaya <em>warm gold</em> dan navy yang estetik, navigasi intuitif, serta tata letak responsif di smartphone.</li>
        <li><strong>Pemenuhan Capaian Pembelajaran Mobile Programming</strong>: Mengimplementasikan seluruh materi kuliah Flutter: UI Dasar, Layouting (Row &amp; Column), Spacing terukur, Media Gambar lokal dengan BoxFit, dan Navigasi LIFO Stack (Navigator.push &amp; pop).</li>
      </ul>

      <!-- POIN 2 -->
      <h2 class="section-header"><span class="badge">POIN 2</span> PENJELASAN FITUR-FITUR APLIKASI</h2>
      <table class="table-custom">
        <thead>
          <tr>
            <th style="width: 20%;">Fitur Utama</th>
            <th style="width: 25%;">Halaman / File Dart</th>
            <th>Fungsi &amp; Perilaku Interaktif</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><strong>1. Onboarding Screen</strong></td>
            <td><code class="inline">OnboardingScreen</code><br>(<small>screens/onboarding/onboarding_screen.dart</small>)</td>
            <td>Menyambut pengguna pertama kali dengan latar gradien emas hangat (#D4A017), logo lingkaran donat, tagline <em>"ENJOY YOUR FOOD"</em>, dan tombol <em>"GET STARTED"</em> menuju halaman Login.</td>
          </tr>
          <tr>
            <td><strong>2. Autentikasi Pengguna</strong></td>
            <td><code class="inline">LoginScreen</code> &amp; <code class="inline">RegisterScreen</code><br>(<small>screens/auth/login_screen.dart</small>)</td>
            <td>Form input Username &amp; Password (dengan toggle visibility sandi), tombol Submit Navy (#2A5EB0), opsi social login (Google, Apple, Facebook), serta navigasi silang ke registrasi akun.</td>
          </tr>
          <tr>
            <td><strong>3. Beranda (Home Dashboard)</strong></td>
            <td><code class="inline">HomeScreen</code><br>(<small>screens/home/home_screen.dart</small>)</td>
            <td>Pusat aktivitas aplikasi: Sapaan <em>"Hallo, Yusuf Affandi!"</em>, foto profil mahasiswa asli, Live Search Bar, Quick Actions pintasan menu, Banner Carousel promo diskon, dan donat Best Seller.</td>
          </tr>
          <tr>
            <td><strong>4. Katalog Varian Rasa</strong></td>
            <td><code class="inline">MenuCatalogScreen</code><br>(<small>screens/menu/menu_catalog_screen.dart</small>)</td>
            <td>Daftar 6 varian donat gulung (Coklat, Strawberry, Taro, Matcha, Tiramisu, Mix Rasa) dilengkapi live filter pencarian real-time, rating 4.8 bintang, harga transparan, dan tombol pesan langsung.</td>
          </tr>
          <tr>
            <td><strong>5. Detail &amp; Pesanan Saya</strong></td>
            <td><code class="inline">MyOrderScreen</code><br>(<small>screens/order/my_order_screen.dart</small>)</td>
            <td>Kustomisasi pesanan: memilih topping tambahan (Oreo, Keju, Chocochip), counter kuantitas (+/-), opsi dompet digital DANA resmi, status delivery, dan rincian total pembayaran.</td>
          </tr>
          <tr>
            <td><strong>6. Profil Mahasiswa</strong></td>
            <td><code class="inline">ProfileScreen</code><br>(<small>screens/profile/profile_screen.dart</small>)</td>
            <td>Menampilkan identitas mahasiswa (Muhammad Yusuf Affandi, NIM 24670009, UPGRIS), avatar foto profil mahasiswa asli, pengaturan akun, serta tombol Keluar (Logout) yang membersihkan stack sesi.</td>
          </tr>
        </tbody>
      </table>
    </div>

    <div class="page-footer">
      Laporan UTS Mobile Programming &bull; FTI Universitas PGRI Semarang &bull; Mahasiswa: Muhammad Yusuf Affandi (NIM: 24670009) &bull; Halaman 1 dari 4
    </div>
  </div>

  <!-- ==================== HALAMAN 2 ==================== -->
  <div class="page">
    <div class="content-wrap">
      <h2 class="section-header"><span class="badge">POIN 3</span> PENJELASAN WIDGET DAN MATERI FLUTTER YANG DITERAPKAN</h2>
      <p>
        Berikut adalah penjelasan konkret implementasi seluruh materi wajib UTS Mobile Programming pada kode sumber proyek:
      </p>

      <h3 class="sub-header">3.1. UI Dasar Flutter (Text, TextStyle, Icon, Color, Container)</h3>
      <ul>
        <li><strong>Text &amp; TextStyle</strong>: Mengatur tipografi seluruh antarmuka (<code class="inline">fontSize</code>, <code class="inline">fontWeight: FontWeight.bold/w900</code>, <code class="inline">letterSpacing</code>, <code class="inline">color</code>, <code class="inline">textAlign</code>).
          <pre class="code-snippet">// Text & TextStyle pada Header Onboarding & Beranda
const Text(
  'ENJOY YOUR FOOD',
  textAlign: TextAlign.center,
  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: 2.0, color: AppColors.textDark),
)</pre>
        </li>
        <li><strong>Icon</strong>: Pustaka <em>Material Icons</em> komunikatif: <code class="inline">Icons.home_filled</code>, <code class="inline">Icons.grid_view_rounded</code>, <code class="inline">Icons.receipt_long_rounded</code>, <code class="inline">Icons.person_outline_rounded</code>, <code class="inline">Icons.search</code>, <code class="inline">Icons.star_rounded</code>, <code class="inline">Icons.lock_outline</code>.</li>
        <li><strong>Color</strong>: Terpusat di <code class="inline">core/app_colors.dart</code>: Gold Primer (<code class="inline">#D4A017</code>), Navy Button (<code class="inline">#2A5EB0</code>), Background (<code class="inline">#FDFBF7</code>), Gray Input (<code class="inline">#F1F3F6</code>), Dark Text (<code class="inline">#1E2022</code>).</li>
        <li><strong>Container</strong>: Pembungkus serbaguna dengan <code class="inline">BoxDecoration</code>, <code class="inline">borderRadius</code>, <code class="inline">boxShadow</code>, border, dan <code class="inline">LinearGradient</code> untuk menghasilkan efek visual modern.</li>
      </ul>

      <h3 class="sub-header">3.2. Layouting (Row, Column, dan Kombinasi Keduanya)</h3>
      <ul>
        <li><strong>Column</strong>: Menyusun elemen vertikal: susunan form input login, alur sambutan onboarding, dan seksi konten beranda.</li>
        <li><strong>Row</strong>: Menyusun elemen horizontal: header nama &amp; avatar profil, rating bintang &amp; harga donat, serta counter jumlah <code class="inline">[-] [+]</code>.</li>
        <li><strong>Kombinasi Row &amp; Column</strong>: Diterapkan pada kartu donat Best Seller dan kartu Katalog Menu: induk kartu memakai <code class="inline">Row</code> (memisahkan foto produk dan rincian info), lalu di dalamnya disusun memakai <code class="inline">Column</code> (Nama &rarr; Rating &rarr; Harga &rarr; Tombol PESAN).
          <pre class="code-snippet">// Kombinasi Row dan Column pada Kartu Menu Katalog
Card(
  child: Row(
    children: [
      ClipRRect(child: Image.asset(item.image, width: 85, height: 85, fit: BoxFit.cover)),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Row(children: [const Icon(Icons.star, color: Colors.amber, size: 14), const Text(' 4.8')]),
            Text('Rp ${{item.price}}', style: const TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ],
  ),
)</pre>
        </li>
      </ul>

      <h3 class="sub-header">3.3. Spacing (Margin, Padding, dan SizedBox)</h3>
      <ul>
        <li><strong>Margin</strong>: Memberikan jarak luar antar elemen kartu, contoh: <code class="inline">margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)</code> pada item katalog agar tidak berhimpitan.</li>
        <li><strong>Padding</strong>: Memberikan ruang lapang di dalam kontainer, contoh: <code class="inline">padding: const EdgeInsets.symmetric(horizontal: 32.0)</code> pada onboarding dan form input.</li>
        <li><strong>SizedBox</strong>: Pemisah jarak tetap yang efisien, contoh: <code class="inline">SizedBox(height: 18)</code> untuk jarak vertikal antar form input, dan <code class="inline">SizedBox(width: 12)</code> untuk jarak horizontal antar tombol.</li>
      </ul>

      <h3 class="sub-header">3.4. Pengelolaan Gambar (Image.asset, Ukuran, dan BoxFit)</h3>
      <ul>
        <li><strong>Image.asset()</strong>: Memanggil aset gambar lokal dari folder <code class="inline">asset/</code> yang terdaftar pada <code class="inline">pubspec.yaml</code>.</li>
        <li><strong>Pengaturan Ukuran &amp; BoxFit</strong>: Menggunakan <code class="inline">width</code> &amp; <code class="inline">height</code> eksplisit dengan <code class="inline">BoxFit.cover</code> (pada kartu donat dan avatar profil agar proporsional memenuhi kontainer) dan <code class="inline">BoxFit.contain</code> (pada logo onboarding agar gambar tidak terpotong).</li>
        <li><strong>ClipRRect &amp; ClipOval</strong>: Menghasilkan sudut gambar melengkung halus (<code class="inline">BorderRadius.circular(16)</code>) dan avatar bundar sempurna.
          <pre class="code-snippet">// Penggunaan Image.asset() dengan BoxFit dan Dimensi
ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: Image.asset('asset/bestseller_tiramizu.png', width: 110, height: 110, fit: BoxFit.cover),
)</pre>
        </li>
      </ul>

      <h3 class="sub-header">3.5. Manajemen Navigasi Multi-Halaman (Navigator.push &amp; Navigator.pop)</h3>
      <p>
        Mengintegrasikan <strong>7 halaman lengkap</strong> menggunakan konsep tumpukan riwayat (<em>LIFO Stack Navigation</em>):
      </p>
      <ul>
        <li><code class="inline">Navigator.push()</code>: Menumpuk halaman baru ke atas riwayat (Beranda &rarr; Menu &rarr; Detail Pesanan &rarr; Profil).</li>
        <li><code class="inline">Navigator.pop()</code>: Mencabut halaman teratas saat tombol panah kembali diklik, mengembalikan user ke halaman sebelumnya.</li>
        <li><code class="inline">Navigator.popUntil()</code>: Langsung kembali ke Beranda utama (<code class="inline">route.isFirst</code>) saat ikon Beranda ditekan.</li>
        <li><code class="inline">Navigator.pushReplacement()</code> / <code class="inline">pushAndRemoveUntil()</code>: Digunakan saat Onboarding, Login, dan Logout.</li>
      </ul>
    </div>

    <div class="page-footer">
      Laporan UTS Mobile Programming &bull; FTI Universitas PGRI Semarang &bull; Mahasiswa: Muhammad Yusuf Affandi (NIM: 24670009) &bull; Halaman 2 dari 4
    </div>
  </div>

  <!-- ==================== HALAMAN 3 ==================== -->
  <div class="page">
    <div class="content-wrap">
      <h2 class="section-header"><span class="badge">POIN 4</span> SCREENSHOT TAMPILAN APLIKASI LENGKAP</h2>
      <p>
        Dokumentasi tangkapan layar (<em>screenshot</em>) otentik dari seluruh halaman aplikasi <em>Sweet Dessert &amp; Donut App</em> yang telah dijalankan dan dirender secara langsung:
      </p>

      <!-- BARIS 1 SCREENSHOT -->
      <div class="screenshot-grid">
        <div class="screenshot-row">
          <div class="screenshot-cell">
            <div class="phone-frame">
              <img src="{img_onboarding}" alt="Halaman Onboarding">
            </div>
            <div class="screenshot-title">1. Halaman Onboarding</div>
            <div class="screenshot-desc">Splash screen, gradien gold, logo lingkaran, tagline "ENJOY YOUR FOOD", dan CTA Get Started.</div>
          </div>
          <div class="screenshot-cell">
            <div class="phone-frame">
              <img src="{img_login}" alt="Halaman Login">
            </div>
            <div class="screenshot-title">2. Halaman Login</div>
            <div class="screenshot-desc">Form autentikasi Username, Password, tombol Submit Navy, social login, dan link ke Register.</div>
          </div>
          <div class="screenshot-cell">
            <div class="phone-frame">
              <img src="{img_home}" alt="Halaman Utama / Beranda">
            </div>
            <div class="screenshot-title">3. Halaman Utama (Beranda)</div>
            <div class="screenshot-desc">Header sapaan Yusuf, avatar mahasiswa, search bar, banner promo diskon, dan katalog Best Seller.</div>
          </div>
        </div>
      </div>

      <!-- BARIS 2 SCREENSHOT -->
      <div class="screenshot-grid">
        <div class="screenshot-row">
          <div class="screenshot-cell">
            <div class="phone-frame">
              <img src="{img_menu}" alt="Halaman Katalog Menu">
            </div>
            <div class="screenshot-title">4. Halaman Katalog Menu</div>
            <div class="screenshot-desc">Daftar 6 varian donat gulung dengan live filter pencarian, bintang rating 4.8, harga, dan tombol pesan.</div>
          </div>
          <div class="screenshot-cell">
            <div class="phone-frame">
              <img src="{img_order}" alt="Halaman Detail &amp; Pesanan">
            </div>
            <div class="screenshot-title">5. Halaman Detail &amp; Pesanan</div>
            <div class="screenshot-desc">Detail produk, toping oreo, integrasi wallet DANA, counter jumlah, status delivery, dan total biaya.</div>
          </div>
          <div class="screenshot-cell">
            <div class="phone-frame">
              <img src="{img_profile}" alt="Halaman Profil Mahasiswa">
            </div>
            <div class="screenshot-title">6. Halaman Profil Pengguna</div>
            <div class="screenshot-desc">Identitas Muhammad Yusuf Affandi (NIM 24670009), foto profil, biodata lengkap, dan tombol keluar.</div>
          </div>
        </div>
      </div>
    </div>

    <div class="page-footer">
      Laporan UTS Mobile Programming &bull; FTI Universitas PGRI Semarang &bull; Mahasiswa: Muhammad Yusuf Affandi (NIM: 24670009) &bull; Halaman 3 dari 4
    </div>
  </div>

  <!-- ==================== HALAMAN 4 ==================== -->
  <div class="page">
    <div class="content-wrap">
      <h2 class="section-header"><span class="badge">POIN 5</span> PENJELASAN ALUR NAVIGASI DAN PENGIRIMAN DATA ANTARHALAMAN</h2>

      <h3 class="sub-header">5.1. Alur Transisi &amp; Logika Tumpukan LIFO (Last-In, First-Out)</h3>
      <div class="callout">
        <div class="callout-title">Peta Alur Transisi Halaman:</div>
        <strong>[Onboarding]</strong> &rarr; <em>pushReplacement</em> &rarr; <strong>[Login / Register]</strong> &rarr; <em>pushReplacement</em> &rarr; <strong>[Beranda (HomeScreen - Root Stack)]</strong><br>
        &bull; Dari <strong>Beranda</strong> &rarr; <em>push</em> &rarr; <strong>[Katalog Menu]</strong> / <strong>[Pesanan Saya]</strong> / <strong>[Profil Pengguna]</strong><br>
        &bull; Dari <strong>Katalog Menu</strong> &rarr; <em>push</em> &rarr; <strong>[Detail &amp; Pesanan Saya]</strong><br>
        &bull; Tombol panah atas (&larr;) &rarr; <code class="inline">Navigator.pop(context)</code> &rarr; Kembali ke halaman sebelumnya secara berurutan.<br>
        &bull; Tab bawah Beranda &rarr; <code class="inline">Navigator.popUntil(context, (r) =&gt; r.isFirst)</code> &rarr; Langsung ke Beranda tanpa duplikasi.
      </div>

      <table class="table-custom">
        <thead>
          <tr>
            <th style="width: 25%;">Aksi Navigasi</th>
            <th style="width: 32%;">Metode Flutter</th>
            <th>Efek Terhadap Tumpukan Route (Stack)</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Mulai Aplikasi (Get Started)</td>
            <td><code class="inline">Navigator.pushReplacement()</code></td>
            <td>Mengganti Onboarding dengan LoginScreen; mencegah user kembali ke splash screen.</td>
          </tr>
          <tr>
            <td>Submit Login Berhasil</td>
            <td><code class="inline">Navigator.pushReplacement()</code></td>
            <td>Menjadikan HomeScreen sebagai rute dasar (<code class="inline">route.isFirst</code>).</td>
          </tr>
          <tr>
            <td>Buka Menu / Detail / Profil</td>
            <td><code class="inline">Navigator.push()</code></td>
            <td>Menumpuk halaman baru ke atas riwayat (mempertahankan urutan LIFO stack).</td>
          </tr>
          <tr>
            <td>Klik Tombol Panah Kembali (&larr;)</td>
            <td><code class="inline">Navigator.pop(context)</code></td>
            <td>Mencabut layar paling atas dan kembali ke layar persis di bawahnya.</td>
          </tr>
          <tr>
            <td>Klik Tab Beranda di Nav Bawah</td>
            <td><code class="inline">Navigator.popUntil((r) =&gt; r.isFirst)</code></td>
            <td>Mencabut seluruh layar di atas tumpukan hingga tersisa Beranda dasar.</td>
          </tr>
          <tr>
            <td>Keluar Akun (Logout)</td>
            <td><code class="inline">Navigator.pushAndRemoveUntil()</code></td>
            <td>Menghapus seluruh tumpukan rute dan membuka LoginScreen sebagai layar bersih.</td>
          </tr>
        </tbody>
      </table>

      <h3 class="sub-header">5.2. Pengiriman Data Antarhalaman (Data Passing via Constructor)</h3>
      <p>Pengiriman data antarhalaman dilakukan secara terstruktur melalui parameter konstruktor widget:</p>
      <ul>
        <li><strong>Pengiriman Search Query Beranda &rarr; Menu</strong>:<br>
          Saat user mencari kata kunci pada Search Bar Beranda, query teks dikirimkan ke <code class="inline">MenuCatalogScreen(initialQuery: queryTeks)</code>. Pada method <code class="inline">initState()</code>, nilai tersebut langsung menyaring daftar varian donat secara otomatis.
          <pre class="code-snippet">// Pengiriman Search Query dari HomeScreen ke MenuCatalogScreen
Navigator.push(context, MaterialPageRoute(builder: (_) => MenuCatalogScreen(initialQuery: searchController.text)));</pre>
        </li>
        <li><strong>Pengiriman Item Terpilih Beranda/Menu &rarr; Detail Pesanan (MyOrderScreen)</strong>:<br>
          Menekan tombol <em>"PESAN"</em> mengirimkan data nama produk, harga, dan thumbnail gambar ke konstruktor <code class="inline">MyOrderScreen</code> untuk ditampilkan pada ringkasan pesanan dan dihitung subtotalsnya.
        </li>
        <li><strong>Sinkronisasi State Menu Bawah (<code class="inline">AppBottomNavBar</code>)</strong>:<br>
          Menerima parameter <code class="inline">currentIndex</code> (0: Beranda, 1: Menu, 2: Pesanan, 3: Profil) untuk mengaktifkan warna emas primer pada ikon yang sedang aktif.
        </li>
      </ul>

      <!-- KESIMPULAN -->
      <h2 class="section-header"><span class="badge">RINGKASAN</span> KESIMPULAN CAPAIAN PROYEK UTS</h2>
      <p>
        Aplikasi <strong>Sweet Dessert &amp; Donut App (SweetBite Mobile)</strong> telah selesai dikembangkan secara menyeluruh dengan memenuhi 100% spesifikasi soal Ujian Tengah Semester (UTS) Gasal TA 2026/2027:
      </p>
      <ol style="margin-bottom: 2px;">
        <li><strong>UI Dasar</strong>: Implementasi Text, TextStyle, Icon, Color, dan Container dengan desain modern dan palet warna harmonis.</li>
        <li><strong>Layouting</strong>: Pemanfaatan kombinasi Row dan Column secara efektif dalam menampilkan katalog donat dan dashboard belanja.</li>
        <li><strong>Spacing</strong>: Penerapan konsisten Margin, Padding, dan SizedBox menghasilkan tata letak yang proporsional dan rapi.</li>
        <li><strong>Image</strong>: Pemanggilan aset lokal dengan <code class="inline">Image.asset()</code>, dimensi terukur, serta <code class="inline">BoxFit.cover</code> dan <code class="inline">contain</code> yang optimal.</li>
        <li><strong>Navigation</strong>: Menghubungkan 7 halaman lengkap melalui <code class="inline">Navigator.push()</code> dan <code class="inline">Navigator.pop()</code> berlogika LIFO stack murni, disertai passing data antarhalaman yang dinamis.</li>
      </ol>
    </div>

    <div class="page-footer">
      Laporan UTS Mobile Programming &bull; FTI Universitas PGRI Semarang &bull; Mahasiswa: Muhammad Yusuf Affandi (NIM: 24670009) &bull; Halaman 4 dari 4
    </div>
  </div>

</body>
</html>
"""

output_html_path = r"d:\semester 5\mobile programing\latihan 2\flutter_application_2\LAPORAN_UTS_24670009.html"
with open(output_html_path, "w", encoding="utf-8") as f:
    f.write(html_content)

print("HTML report successfully updated at:", output_html_path)
