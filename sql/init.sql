CREATE DATABASE IF NOT EXISTS LIBRARY_SYSTEM;

USE LIBRARY_SYSTEM;

CREATE TABLE IF NOT EXISTS LIBRARY_SYSTEM.library (
    library_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	libraryName NVARCHAR(60) NOT NULL,
	libraryCity NVARCHAR(60) NULL,
	libraryTelephone NVARCHAR(15) NULL,
	bookCount INT NULL
);

CREATE TABLE IF NOT EXISTS LIBRARY_SYSTEM.book (
    book_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	bookName NVARCHAR(60) NOT NULL,
	bookAuthor NVARCHAR(60) NULL,
	bookPublisher NVARCHAR(60) NULL,
	bookDate NVARCHAR(15) NULL,
	bookPage INT NULL,
	hostingLibrary_ID INT NULL,
	FOREIGN KEY (`hostingLibrary_ID`) REFERENCES `library`(`library_ID`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS LIBRARY_SYSTEM.person (
    person_ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	personName NVARCHAR(60) NOT NULL,
	personSurname NVARCHAR(60) NOT NULL,
	personUsername NVARCHAR(60) NOT NULL,
	personPassword NVARCHAR(10) NOT NULL,
	registeredLibrary_ID INT NULL,
	FOREIGN KEY (`registeredLibrary_ID`) REFERENCES `library`(`library_ID`) ON DELETE CASCADE,
	borrowedBook_ID INT NULL,
	FOREIGN KEY (`borrowedBook_ID`) REFERENCES `book`(`book_ID`) ON DELETE CASCADE
);

INSERT library (libraryName,libraryCity,libraryTelephone,bookCount) VALUES ('Maltepe Kütüphanesi','İstanbul','2161111111','15000');
INSERT library (libraryName,libraryCity,libraryTelephone,bookCount) VALUES ('Karşıyaka Kütüphanesi','İzmir','2321111111','21000');
INSERT library (libraryName,libraryCity,libraryTelephone,bookCount) VALUES ('Bodrum Kütüphanesi','Muğla','2521111111','10000');

INSERT book (bookName,bookAuthor,bookPublisher,bookDate,bookPage,hostingLibrary_ID) VALUES ('Güç ve Refah','Ronald Findley','Küre Yayınları','Mart 2013','735','1');
INSERT book (bookName,bookAuthor,bookPublisher,bookDate,bookPage,hostingLibrary_ID) VALUES ('Bütün Beyinli Çocuk','Tina Payne Bryson','Koridor Yayınevi','Mart 2011','247','1');
INSERT book (bookName,bookAuthor,bookPublisher,bookDate,bookPage,hostingLibrary_ID) VALUES ('Uçurtma Avcısı','Khaled Hosseini','Everest Yayınları','Mayıs 2013','374','2');
INSERT book (bookName,bookAuthor,bookPublisher,bookDate,bookPage,hostingLibrary_ID) VALUES ('Sosyal Psikoloji','Elliot Aronson','Kaknüs Yayınları','Mart 2016','1096','2');
INSERT book (bookName,bookAuthor,bookPublisher,bookDate,bookPage,hostingLibrary_ID) VALUES ('Kapital','Thomas Piketty','İş Bankası Kültür Yayınları','Ekim 2014','742','3');

INSERT person(personName,personSurname,personUsername,personPassword,registeredLibrary_ID,borrowedBook_ID) VALUES ('Ali','BİRİNCİ','ALİBİR','11111111','1','1');
INSERT person(personName,personSurname,personUsername,personPassword,registeredLibrary_ID,borrowedBook_ID) VALUES ('Veli','İKİİNCİ','VELİİKİ','22222222','1','2');
INSERT person(personName,personSurname,personUsername,personPassword,registeredLibrary_ID,borrowedBook_ID) VALUES ('Ayşe','ÜÇÜNCÜ','AYŞEÜÇ','33333333','2','3');
INSERT person(personName,personSurname,personUsername,personPassword,registeredLibrary_ID,borrowedBook_ID) VALUES ('Merve','DÖRDÜNCÜ','MERVEDÖRT','44444444','3','5');