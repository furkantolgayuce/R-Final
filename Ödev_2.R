# ÖDEV 2
# SQLite kullanarak bir telefon defteri tasarlanacak.

# RSQLite kurulu değilse Aşağıdaki # kaldırın.
#install.packages("RSQLite")

# Kütüphaneyi içeri alalım.
library(RSQLite)

# Database olarak SQLite seçiyoruz.
surucu <- dbDriver(drvName = "SQLite")

# "surucu"'ye bağlanmak için veritabanı adı, kullanıcı adı ve şifre giriyoruz.
conn <- dbConnect(drv = surucu,
                  dbname = "phone_book",
                  user = "tolga",
                  password = "123456") 

# Tablo oluşturma.
isim <- c("Tolga","Çağatay","Gizem")
soyisim <- c("Yüce","Demir","Atalay")
numara <- c(05399351036, 05399361040, 05313454949)
adres <- c("Ortaçeşme Mahallesi Berk Sokak Beykoz İstanbul","Kozluk Mahallesi Numan Kahya Sokak İzmit Kocaeli","Ereğli")
# Yukarıda topladığımız verilerle frame oluşturalım.
mydata <- data.frame(isim,soyisim,numara,adres)

# Oluşturduğumuz frame ile "Rehber" adında Tablo oluşturalım. Bu tablonun isim, soyisim, numara ve adres sütunları olacak.
# Kodu tekrar çalıştırdığımda hata almamak adına "overwrite=TRUE" ekledim.
dbWriteTable(conn = conn, name = "Rehber", value = mydata, overwrite=TRUE)

# Rehber tablomuzu isim sütununa göre sıralayalım.
dbGetQuery(conn = conn, statement = "SELECT * FROM Rehber ORDER BY isim ")


# Rehber tablomuzdan ismi "Tolga" olanları çekelim.  
dbGetQuery(conn = conn, statement = "SELECT * FROM Rehber WHERE isim = 'Tolga'")

# Rehber içersine email sütunu ekleyelim.
dbGetQuery(conn = conn, statement = "ALTER TABLE Rehber ADD COLUMN email TEXT(255);")

# Yeni Bir kişi ekleyeim
dbGetQuery(conn = conn, statement = "INSERT INTO REHBER(isim, soyisim, numara, adres, email) values('Mehmet Hakan','Satman',05399876543,'Beyazıt', 'mhsatman@gmail.com')")

# Mevcut bir kişinin email adresini güncelleyelim.
dbGetQuery(conn = conn, statement = "UPDATE Rehber SET email = 'yucefurkantolga@gmail.com' where isim = 'Tolga'")


# Değişiklikleri kontrol edelim.
dbGetQuery(conn = conn, statement = "SELECT * FROM Rehber ORDER BY isim ")

# Veritabanı ile bağlantımızı sonlandıralım.
dbDisconnect(conn)
