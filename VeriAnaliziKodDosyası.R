View(odev)

# Eksik Değerlerimizi Medyan ile Dolduruyoruz.

set.seed(432)  
sum(is.na(odev)) 

odev$GSYH[is.na(odev$GSYH)] <- median(odev$GSYH, na.rm = TRUE)
odev$Urban[is.na(odev$Urban)] <- median(odev$Urban, na.rm = TRUE)
odev$CO2[is.na(odev$CO2)] <- median(odev$CO2, na.rm = TRUE)
odev$Healthy[is.na(odev$Healthy)] <- median(odev$Healthy, na.rm = TRUE)

print("Eksik Veriler Ortalama ile Doldurulmuş Veri Seti:")
print(odev)

#Veri Özeti

summary(odev)

View(odev)

# Verimizdeki değişkenlerin dağılımını kontrol ediyoruz.

#Histogram
hist(odev$GSYH, main="GSYH Histogram", col="darkblue")
hist(odev$Urban, main="Kentleşme Histogram", col="yellow")
hist(odev$CO2, main="Karbon Emisyonu Histogram", col="black")
hist(odev$Healthy, main="Sağlık Harcamaları Histogram", col="red")

#QQ-Plot
qqnorm(odev$GSYH); qqline(odev$GSYH, col="red")
qqnorm(odev$Urban); qqline(odev$Urban, col="red")
qqnorm(odev$CO2); qqline(odev$CO2, col="red")
qqnorm(odev$Healthy); qqline(odev$Healthy, col="red")

#Shapiro testi
shapiro.test(odev$GSYH)
shapiro.test(odev$Urban)
shapiro.test(odev$CO2)
shapiro.test(odev$Healthy)


#Verimizdeki değişkenlerin aykırı değerlerini boxplot ile görüntülüyoruz.Aynı zamanda verilerimizin hangi değerler arasında dağıldığını da görüntülüyoruz.

boxplot(odev$GSYH, main = "GSYH Boxplot", col = "gray",outline=F)
boxplot(odev$Urban, main = "Urban Boxplot", col = "gray",outline=F)
boxplot(odev$CO2, main = "CO2 Boxplot", col = "gray",outline=F)
boxplot(odev$Healthy, main = "Healthy Boxplot", col = "gray",outline=F)


# IQR Yöntemi ile Aykırı Değerleri Hesaplayıp,Çıkan Aykırı Değerleri Medyan Değeriyle Değiştiriyoruz.

### --- GSYH ---
Q1 <- quantile(odev$GSYH, 0.25)
Q3 <- quantile(odev$GSYH, 0.75)
IQR <- Q3 - Q1

alt_sinir <- Q1 - 1.5 * IQR
ust_sinir <- Q3 + 1.5 * IQR

sum(odev$GSYH < alt_sinir | odev$GSYH > ust_sinir) #Aykırı değer bulunmuyor.



### --- Urban ---
Q1 <- quantile(odev$Urban, 0.25)
Q3 <- quantile(odev$Urban, 0.75)
IQR <- Q3 - Q1

alt_sinir <- Q1 - 1.5 * IQR
ust_sinir <- Q3 + 1.5 * IQR


sum(odev$Urban < alt_sinir | odev$Urban > ust_sinir)

median_clean <- median(odev$Urban[odev$Urban >= alt_sinir & odev$Urban <= ust_sinir], na.rm = TRUE)

odev$Urban <- ifelse(odev$Urban < alt_sinir | odev$Urban > ust_sinir,
                     median_clean, odev$Urban)


### --- CO2 ---
Q1 <- quantile(odev$CO2, 0.25)
Q3 <- quantile(odev$CO2, 0.75)
IQR <- Q3 - Q1

alt_sinir <- Q1 - 1.5 * IQR
ust_sinir <- Q3 + 1.5 * IQR

sum(odev$CO2 < alt_sinir | odev$CO2 > ust_sinir)

median_clean <- median(odev$CO2[odev$CO2 >= alt_sinir & odev$CO2 <= ust_sinir], na.rm = TRUE)

odev$CO2 <- ifelse(odev$CO2 < alt_sinir | odev$CO2 > ust_sinir,
                   median_clean, odev$CO2)


### --- Healthy ---
Q1 <- quantile(odev$Healthy, 0.25)
Q3 <- quantile(odev$Healthy, 0.75)
IQR <- Q3 - Q1

alt_sinir <- Q1 - 1.5 * IQR
ust_sinir <- Q3 + 1.5 * IQR

sum(odev$Healthy < alt_sinir | odev$Healthy > ust_sinir)

median_clean <- median(odev$Healthy[odev$Healthy >= alt_sinir & odev$Healthy <= ust_sinir], na.rm = TRUE)

odev$Healthy <- ifelse(odev$Healthy < alt_sinir | odev$Healthy > ust_sinir,
                       median_clean, odev$Healthy)


View(odev)

# ----------------- STANDARDİZASYON İŞLEMİ----------------- 
#Verimiz Farklı Birimlere Sahip Olduğundan Dolayı Standardizasyon İşlemi İle Değerlerin Ortalamalarını 0, Standart Sapmalarını 1 Yapıyoruz.

z_score_standardizasyon <- function(x) {
  mu <- mean(x, na.rm = TRUE)
  sigma <- sd(x, na.rm = TRUE)
  return((x - mu) / sigma)
}

sayisal_sutunlar <- c("GSYH", "Urban", "CO2", "Healthy")

odev_standardize <- odev
odev_standardize[sayisal_sutunlar] <- lapply(odev[sayisal_sutunlar], z_score_standardizasyon)

print("Orijinal Veri (İlk 5 Satır):")
print(head(odev))

print("Standardizasyon Sonrası Veri (İlk 5 Satır):")
print(head(odev_standardize))


View(odev_standardize)


# ----------------- KORELASYON MATRİSİ OLUŞTURMA -----------------

sayisal_veri <- odev_standardize[, c("GSYH", "Urban", "CO2", "Healthy")]

kor_matris <- cor(sayisal_veri)
print(kor_matris)

install.packages("ggcorrplot")
library(ggcorrplot)

ggcorrplot(kor_matris, method = "circle", lab = TRUE)


# ----------------- VIF -----------------

install.packages("car")
library(car)

model <- lm(GSYH ~ Urban + CO2 + Healthy, data = odev_standardize)
vif_values <- vif(model)

print("VIF Değerleri:")
print(vif_values)

high_vif <- vif_values[vif_values > 5]
print("Yüksek VIF Değerleri:")
print(high_vif)



View(odev_standardize)

#VERİMİZE K-MEANS ALGORİTMASINI UYGULUYORUZ.

install.packages("cluster")
install.packages("factoextra")
install.packages("tidyverse")
install.packages("caret")


library(tidyverse)  # Veri işleme ve görselleştirme
library(caret)      # Veri bölme ve model değerlendirme
library(cluster)    # Silhouette skoru hesaplamak için
library(factoextra) # K-means analizini görselleştirmek için


View(odev_standardize)

# 3 küme seçtik.
set.seed(123) 
kmeans_result <- kmeans(odev_standardize[, 3:6], centers = 3, nstart = 25)  
kmeans_result

#WSS değerlerini görüntüleme
wss <- numeric(10)  
for (k in 1:10) {
  kmeans_temp <- kmeans(odev_standardize[, 3:6], centers = k, nstart = 25)
  wss[k] <- kmeans_temp$tot.withinss 
}
wss



# WSS değerlerini grafikle gösterelim
plot(1:10, wss, type = "b", pch = 19, col = "red", 
     xlab = "K Değeri", ylab = "WSS (Within Sum of Squares)", 
     main = "Elbow Yöntemi")


#Küme Sonuçlarımız

fviz_cluster(kmeans_result, data = odev_standardize[, 3:6], #fviz_cluster:factoextra paketinden gelen bir fonksiyondur. Bu fonksiyon, k-means veya diğer kümeleme algoritmalarının sonuçlarını görselleştirmek için kullanılır.
             geom = "point", ellipse.type = "euclid", #ellipse.type = "euclid": Her bir küme etrafında Euclidean mesafesine dayalı bir elips çizer. 
             main = "K-means Kümeleme Sonuçları")


#Silhouette skoru
d <- dist(odev_standardize)
sil <- silhouette(kmeans_result$cluster, d)
plot(sil, col = 1:3, border = NA)


odev_standardize$cluster <- kmeans_result$cluster  
odev_standardize #hangi gözlemler hangi kümede yer alıyor?
head(odev_standardize)


View(odev_standardize)


#Küme frekansları
table(odev_standardize$cluster)