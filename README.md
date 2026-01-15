# G20 Ülkeleri Ekonomik ve Çevresel Göstergeler Analizi

Bu proje, G20 ülkelerinin 2000-2023 yılları arasındaki GSYH, kentleşme, sağlık harcamaları ve CO2 emisyonları arasındaki ilişkileri incelemek amacıyla R programlama dili kullanılarak geliştirilmiştir. Çalışma kapsamında Makine Öğrenmesi tekniklerinden **K-Means Kümeleme Analizi** uygulanmıştır.

## 📌 Proje Kapsamı ve Benim Görevlerim
Bu çalışma bir grup projesi olarak yürütülmüştür. Proje sürecinde şahsım tarafından üstlenilen temel sorumluluklar şunlardır:

* **Literatür ve Metodoloji:** Giriş bölümünün ekip çalışmasıyla hazırlanması, literatür taraması kapsamında sekiz bilimsel makale alıntısının çalışmaya entegrasyonu ve metodolojik çerçevenin oluşturulması.
* **Veri Analizi ve Kodlama:** Analiz sürecinde kullanılan tüm R kod dosyalarının hazırlanması ve geliştirilen analiz uygulamasının teknik takibinin yapılması.
* **İstatistiksel Yorumlama:** Veri setindeki değişkenlerin analizi ve özet istatistiklerin teknik yorumlarının yapılması.
* **Veri Ön İşleme:** Değişkenlerin karşılaştırılabilir hale getirilmesi amacıyla **standardizasyon** işlemlerinin tanımlanması ve uygulanması.
* **Kümeleme Analizi (Clustering):** K-Means algoritması sonucunda elde edilen kümeler için değişken ortalamalarının incelenmesi; kümeler arası ve kümeler içi toplam kareler dağılımının (WSS/BSS) yorumlanması.
* **Sonuç Değerlendirme:** Oluşan kümelerde yer alan ülkelerin değişkenlere göre sınıflandırılarak stratejik sonuçların değerlendirilmesi.

## 🎯 Analiz Bulguları ve Sonuç
Elbow yöntemiyle belirlenen optimum 3 farklı küme yapısı şu bulguları ortaya koymuştur:

* **Küme 1 (Yüksek Refah ve Çevre Duyarlılığı):** ABD, Almanya, Japonya, Kanada, İtalya ve Fransa gibi ülkelerden oluşmaktadır. Bu küme yüksek GSYH ve sağlık/yaşam kalitesine sahip olup, CO2 emisyon ortalamalarının düşük olmasıyla çevreye duyarlı bir ekonomik yapı sergilemektedir.
* **Küme 2 (Gelişmekte Olan Ekonomiler):** Brezilya, Çin ve Meksika gibi ülkeleri kapsamaktadır. Sanayi yapıları gereği gelir, kentleşme ve emisyon oranları Küme 1'e göre daha düşük seviyededir.
* **Küme 3 (Yüksek Karbon Ayak İzi):** Hindistan ve Rusya'nın yer aldığı bu küme, enerji üretimindeki kömür bağımlılığı nedeniyle diğer kümelere kıyasla belirgin şekilde yüksek karbon emisyonu değerlerine sahiptir.

**Performans Notu:** Analizin genel ortalama silüet genişliği (Silhouette score) **0,38** olarak belirlenmiştir. Bu durum, veri setinde doğal bir kümeleme yapısı olduğunu ancak kümeler arasındaki sınırların geçişken özellikler taşıdığını göstermektedir.

## 🛠 Kullanılan Teknolojiler
* **Dil:** R
* **Kütüphaneler:** tidyverse, cluster, ggplot2, factoextra
* **Yöntem:** K-Means Clustering, Elbow Method, Silhouette Analysis, Data Standardization

## 📂 Dosya Yapısı
* `odev.xlsx`: Analizde kullanılan ham veri seti.
* `VeriAnaliziKodDosyasi.R`: Hazırladığım analiz ve görselleştirme kodları.
* `G20_Analiz_Raporu.pdf`: Detaylı proje raporu ve görev dağılım tablosu.

