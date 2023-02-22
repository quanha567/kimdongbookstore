CREATE DATABASE KimDongBookStore
GO
USE KimDongBookStore
GO

CREATE TABLE KHACHHANG
(
	MAKH INT IDENTITY(1, 1) PRIMARY KEY,
	HOTEN NVARCHAR(100) NOT NULL,
	TAIKHOAN VARCHAR(50) NOT NULL,
	MATKHAU VARCHAR(50) NOT NULL,
	EMAIL VARCHAR(100) NOT NULL,
	DIACHI NVARCHAR(200) NOT NULL,
	DIENTHOAI VARCHAR(10) NOT NULL
)

CREATE TABLE DONDATHANG
(
	MADONHANG INT IDENTITY(1, 1) PRIMARY KEY,
	DATHANHTOAN BIT CHECK(DATHANHTOAN IN (0, 1)),
	TINHTRANGGIAOHANG NVARCHAR(100),
	NGAYDAT DATETIME,
	NGAYGIAO DATETIME,
	MAKH INT FOREIGN KEY REFERENCES KHACHHANG(MAKH),
)

CREATE TABLE CHUDE
(
	MACD INT IDENTITY(1, 1) PRIMARY KEY,
	TENCHUDE NVARCHAR(200) NOT NULL,
	ANHBIA VARCHAR(200),
	_ACTION VARCHAR(200) NOT NULL,
)

CREATE TABLE DANHMUC
(
	MADM INT IDENTITY(1, 1) PRIMARY KEY,
	TENDM NVARCHAR(200) NOT NULL
)

CREATE TABLE SACH
(
	MASACH INT IDENTITY(1, 1) PRIMARY KEY,
	TENSACH NVARCHAR(200) NOT NULL,
	GIABAN DECIMAL(18,0) NOT NULL,
	MOTA NVARCHAR(MAX) NOT NULL,
	ANHBIA VARCHAR(200) NOT NULL,
	NGAYCAPNHAT DATETIME DEFAULT CURRENT_TIMESTAMP,
	SOLUONGTON INT NOT NULL,
	MACD INT FOREIGN KEY REFERENCES CHUDE(MACD),
	MADM INT FOREIGN KEY REFERENCES DANHMUC(MADM),
	TACGIA NVARCHAR(200),
	SALE FLOAT,
	ISBN VARCHAR(100),
	DOITUONG NVARCHAR(100),
	KHUONKHO VARCHAR(50),
	SOTRANG INT,
	DINHDANG NVARCHAR(100),
	TRONGLUONG INT,
	BOSACH NVARCHAR(200)
)

CREATE TABLE TACGIA
(
	MATG INT IDENTITY(1, 1) PRIMARY KEY,
	TENTG NVARCHAR(200) NOT NULL,
	TIEUSU NVARCHAR(MAX)
)

CREATE TABLE VIETSACH
(
	MATG INT FOREIGN KEY REFERENCES TACGIA(MATG),
	MASACH INT FOREIGN KEY REFERENCES SACH(MASACH),
	PRIMARY KEY (MATG, MASACH)
)

CREATE TABLE CHITIETDONHANG
(
	MADONHANG INT FOREIGN KEY REFERENCES DONDATHANG(MADONHANG),
	MASACH INT FOREIGN KEY REFERENCES SACH(MASACH),
	SOLUONG INT NOT NULL,
	PRIMARY KEY (MADONHANG, MASACH)
)

CREATE TABLE ADMIN
(
	TAIKHOAN VARCHAR(50) PRIMARY KEY,
	MATKHAU  VARCHAR(50) NOT NULL,
	HOTEN NVARCHAR(50)
)

INSERT INTO CHUDE
	(TENCHUDE, ANHBIA, _ACTION)
VALUES(N'BỘ ẤN PHẨM KỈ NIỆM 65 NĂM THÀNH LẬP NHÀ XUẤT BẢN KIM ĐỒNG', NULL, 'ANPHAMKINIEM')
INSERT INTO CHUDE
	(TENCHUDE, ANHBIA, _ACTION)
VALUES(N'SÁCH MỚI', NULL, 'SACHMOI')
INSERT INTO CHUDE
	(TENCHUDE, ANHBIA, _ACTION)
VALUES(N'SÁCH BÁN CHẠY', NULL, 'SACHBANCHAY')
INSERT INTO CHUDE
	(TENCHUDE, ANHBIA, _ACTION)
VALUES(N'COMBO', 'banner_home_pro_3.webp', 'COMBO')
INSERT INTO CHUDE
	(TENCHUDE, ANHBIA, _ACTION)
VALUES(N'MANGA - COMIC', 'banner_home_pro_4.webp', 'MANGA')
INSERT INTO CHUDE
	(TENCHUDE, ANHBIA, _ACTION)
VALUES(N'DORAEMON', 'banner_home_pro_5.webp', 'DORAEMON')
INSERT INTO CHUDE
	(TENCHUDE, ANHBIA, _ACTION)
VALUES(N'WINGS BOOKS', 'banner_home_pro_6.webp', 'WINGSBOOK')
INSERT INTO CHUDE
	(TENCHUDE, ANHBIA, _ACTION)
VALUES(N'SHOP NOW', 'banner_home_pro_7.webp', 'SHOPNOW')

INSERT INTO DANHMUC
	(TENDM)
VALUES(N'Lịch sử truyền thống')
INSERT INTO DANHMUC
	(TENDM)
VALUES(N'Sách công cụ đoàn hội')
INSERT INTO DANHMUC
	(TENDM)
VALUES(N'Kiến thức - khoa học')
INSERT INTO DANHMUC
	(TENDM)
VALUES(N'Văn học Việt Nam')
INSERT INTO DANHMUC
	(TENDM)
VALUES(N'Văn học nước ngoài')
INSERT INTO DANHMUC
	(TENDM)
VALUES(N'Truyện tranh')
INSERT INTO DANHMUC
	(TENDM)
VALUES(N'Manga - Comic')
INSERT INTO DANHMUC
	(TENDM)
VALUES(N'WingsBook')
INSERT INTO DANHMUC
	(TENDM)
VALUES(N'Giải mã bản thân')

INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'MÊ CUNG THẦN NÔNG - PANS LABYRINTH (BÌA CỨNG) (TẶNG KÈM BOOKMARK) (KỈ NIỆM 65 NĂM NXB KIM ĐỒNG)',
		199000, 10, 'me-cung-than-nong---bia_9c9a681d700e49349dcbbabe0b0ab8ce_large.png',
		'978-604-2-23855-7', N'Guillermo del Toro Cornelia Funke', N'Tuổi mới lớn (15 – 18) Thanh niên (trên 18 tuổi)',
		'14x22.5 cm', 324, N'bìa mềm', 540, NULL, N'“Cháu không nên vào trong này. Cháu có thể đi lạc mất. Trước đây đã có chuyện như vậy xảy ra rồi. Một ngày nào đó, nếu cháu muốn, cô sẽ kể cho cháu nghe câu chuyện đó.”
Trong những câu chuyện cổ tích, luôn có người đàn ông và con sói, có quái thú và bậc cha mẹ đã qua đời, có cô gái và khu rừng.
Ofelia biết tất cả những điều này, giống như bất cứ cô bé nào với cái đầu đầy ắp các câu chuyện kể. Và cô nhìn ra ngay bản chất của tên Đại uý đang mỉm cười, trong bộ quân phục, đôi bốt bóng bẩy và găng tay không tì vết của hắn: một con sói.
Nhưng không gì có thể chuẩn bị tinh thần cho cô trước hiện thực đầy kích động ở căn nhà kì quái của Đại uý, nằm giữa một khu rừng rậm đang ẩn giấu nhiều thứ: vài câu chuyện được nhớ mang máng về những đứa trẻ mất tích, các chiến sĩ quân nổi dậy ẩn trốn khỏi quân đội, một mê cung, các quái vật và nàng tiên.
Chẳng có ai bảo vệ Ofelia khi mê cung mời gọi cô vào câu chuyện của bản thân mình, nơi quỷ quái và con người đan xen không thể tách rời, những câu chuyện thần thoại rộn ràng nhịp đập nhờ máu của kẻ sống…
Mê Cung Thần Nông là cuốn sách không dành cho những người yếu tim hay tinh thần kém vững vàng. Nó không dành cho những kẻ hoài nghi, không tin tưởng vào các câu chuyện cổ tích hay những thế lực hùng mạnh của cái thiện. Nó chỉ dành cho những tâm hồn quả cảm và gan dạ như bạn, người sẽ từ trên cao nhìn xuống cái ác dưới mọi hình dáng của nó.
Lấy cảm hứng từ bộ phim Pan’s Labyrinth được giới phê bình ca ngợi, kịch bản được viết và chỉ đạo bởi đạo diễn giành giải Oscar – Guillermo del Toro, và được tái hiện lại bởi tác giả sách bán chạy nhất theo danh sách của tờ New York Times – Cornelia Funke, câu chuyện đầy ám ảnh này sẽ đưa người đọc tới một thế giới phép thuật đen tối, bị chiến tranh giằng xé, với những nhân vật được khắc hoạ sống động, gồm Thần Nông bịp bợm, những kẻ giết người, quái vật ăn thịt trẻ con, quân nổi dậy quả cảm, và nàng công chúa đã mất tích từ lâu, hi vọng được đoàn tụ với gia đình mình.
Một tác phẩm hoàn hảo dành cho những người hâm mộ của bộ phim Pan’s Labyrinth cũng như các độc giả còn xa lạ với tác phẩm huyền ảo của đạo diễn del Toro, cuốn tiểu thuyết huyền bí và đầy say mê này là cánh cổng dẫn vào một vũ trụ khác, nơi không tồn tại rào cản giữa hiện thực và tưởng tượng. Một sự hợp tác táo bạo và khó quên giữa hai bậc thầy kể chuyện.
* Về tác giả: 
Guillermo del Toro là một đạo diễn phim, biên kịch, nhà sản xuất, và tiểu thuyết gia người Mexico. Sự nghiệp làm phim của Guillermo vô cùng đa dạng, gồm các tác phẩm kì ảo u tối tiếng Tây Ban Nha. Guillermo del Toro cũng nhận được giải Oscar hạng mục Đạo diễn Xuất sắc nhất, giải Quả Cầu Vàng, BAFTA, cùng nhiều giải thưởng danh giá khác.
Cornelia Funke kể lại những câu chuyện dành cho đủ mọi lứa tuổi – như những người kể chuyện vẫn làm – cho các mọt sách và những người không dễ dàng ngả mũ trước phép thuật trên giấy in. Những cuốn sách của bà được chuyển ngữ từ tiếng Đức sang 35 ngôn ngữ khác nhau: Inkheart, Dragon Rider, The Thief Lord, và Reckless.
***
Bên cạnh đó, tiểu thuyết Mê Cung Thần Nông còn có các tranh minh họa của Allen xen kẽ với nội dung sách. Đặc biệt duy nhất ấn bản Bìa cứng in kèm 4 tranh màu, không thể tìm thấy ở bản sách Bìa mềm.', 100, 1, 1)
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'MÊ CUNG THẦN NÔNG - PANS LABYRINTH (TẶNG KÈM BOOKMARK) (KỈ NIỆM 65 NĂM NXB KIM ĐỒNG)',
130000,  10, 'me-cung-than-nong---bia_b443c28c6b38462ea2eb47b8304634ba_large.png', 
'978-604-2-23856-4', N'Guillermo del Toro Cornelia Funke', N'Tuổi mới lớn (15 – 18) Thanh niên (trên 18 tuổi)', 
'14x22.5 cm',  324, N'bìa mềm',  400, null, N'“Cháu không nên vào trong này. Cháu có thể đi lạc mất. Trước đây đã có chuyện như vậy xảy ra rồi. Một ngày nào đó, nếu cháu muốn, cô sẽ kể cho cháu nghe câu chuyện đó.”
Trong những câu chuyện cổ tích, luôn có người đàn ông và con sói, có quái thú và bậc cha mẹ đã qua đời, có cô gái và khu rừng.
Ofelia biết tất cả những điều này, giống như bất cứ cô bé nào với cái đầu đầy ắp các câu chuyện kể. Và cô nhìn ra ngay bản chất của tên Đại uý đang mỉm cười, trong bộ quân phục, đôi bốt bóng bẩy và găng tay không tì vết của hắn: một con sói.
Nhưng không gì có thể chuẩn bị tinh thần cho cô trước hiện thực đầy kích động ở căn nhà kì quái của Đại uý, nằm giữa một khu rừng rậm đang ẩn giấu nhiều thứ: vài câu chuyện được nhớ mang máng về những đứa trẻ mất tích, các chiến sĩ quân nổi dậy ẩn trốn khỏi quân đội, một mê cung, các quái vật và nàng tiên.
Chẳng có ai bảo vệ Ofelia khi mê cung mời gọi cô vào câu chuyện của bản thân mình, nơi quỷ quái và con người đan xen không thể tách rời, những câu chuyện thần thoại rộn ràng nhịp đập nhờ máu của kẻ sống…
Mê Cung Thần Nông là cuốn sách không dành cho những người yếu tim hay tinh thần kém vững vàng. Nó không dành cho những kẻ hoài nghi, không tin tưởng vào các câu chuyện cổ tích hay những thế lực hùng mạnh của cái thiện. Nó chỉ dành cho những tâm hồn quả cảm và gan dạ như bạn, người sẽ từ trên cao nhìn xuống cái ác dưới mọi hình dáng của nó.
Lấy cảm hứng từ bộ phim Pan’s Labyrinth được giới phê bình ca ngợi, kịch bản được viết và chỉ đạo bởi đạo diễn giành giải Oscar – Guillermo del Toro, và được tái hiện lại bởi tác giả sách bán chạy nhất theo danh sách của tờ New York Times – Cornelia Funke, câu chuyện đầy ám ảnh này sẽ đưa người đọc tới một thế giới phép thuật đen tối, bị chiến tranh giằng xé, với những nhân vật được khắc hoạ sống động, gồm Thần Nông bịp bợm, những kẻ giết người, quái vật ăn thịt trẻ con, quân nổi dậy quả cảm, và nàng công chúa đã mất tích từ lâu, hi vọng được đoàn tụ với gia đình mình.
Một tác phẩm hoàn hảo dành cho những người hâm mộ của bộ phim Pan’s Labyrinth cũng như các độc giả còn xa lạ với tác phẩm huyền ảo của đạo diễn del Toro, cuốn tiểu thuyết huyền bí và đầy say mê này là cánh cổng dẫn vào một vũ trụ khác, nơi không tồn tại rào cản giữa hiện thực và tưởng tượng. Một sự hợp tác táo bạo và khó quên giữa hai bậc thầy kể chuyện.
* Về tác giả: 
Guillermo del Toro là một đạo diễn phim, biên kịch, nhà sản xuất, và tiểu thuyết gia người Mexico. Sự nghiệp làm phim của Guillermo vô cùng đa dạng, gồm các tác phẩm kì ảo u tối tiếng Tây Ban Nha. Guillermo del Toro cũng nhận được giải Oscar hạng mục Đạo diễn Xuất sắc nhất, giải Quả Cầu Vàng, BAFTA, cùng nhiều giải thưởng danh giá khác.
Cornelia Funke kể lại những câu chuyện dành cho đủ mọi lứa tuổi – như những người kể chuyện vẫn làm – cho các mọt sách và những người không dễ dàng ngả mũ trước phép thuật trên giấy in. Những cuốn sách của bà được chuyển ngữ từ tiếng Đức sang 35 ngôn ngữ khác nhau: Inkheart, Dragon Rider, The Thief Lord, và Reckless.', 100, 1, 2 )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'BORUTO - NARUTO HẬU SINH KHẢ ÚY - QUYỂN 12',  25000,  10,
'12_256f5ca3d1d94d44bfe1a3eb0f847621_large.png', '978-604-2-23551-8', N'Masashi Kishimoto Mikio Ikemoto Ukyo Kodachi',
N'Tuổi mới lớn (15 – 18) ', '11,3x17,6 cm',  176, N'bìa mềm',  140, N' Boruto - Naruto hậu sinh khả úy', N'Kashin Koji và Amado đã quyết định phản bội “Kara”. Amado đột nhiên xuất hiện tại làng Lá, bắt Shikadai làm con tin và đưa ra yêu cầu được vào làng… Sau cuộc thương lượng căng thẳng, những bí mật cũng dần dần lộ rõ!
Cùng lúc đó còn diễn ra trận đại chiến giữa Kashin Koji Vs. Jigen!!', 59, 1, 1 )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'DẤU ẤN THẾ HỆ MỚI - TRỜI XANH NGẬP NẮNG',  80000,  10, 'troi-xanh-ngap-nang_eda15940b6804db399fac41204e5a5c6_large.png',
'978-604-2-27093-9', N'Rosita Nguyen', N'Nhi đồng (6 – 11)', '14,5x20,5 cm', 168, N'bìa mềm', 210, N'Dấu ấn thế hệ mới',
N'Như mọi đứa trẻ, Kaila không lường trước được những biến cố bất ngờ ập tới khiến cuộc sống yên bình bỗng chốc hoàn toàn thay đổi.
Những cuộc phiêu lưu nho nhỏ, những bài học giản dị giúp cô bé hiểu ra rằng, dù bất kì điều gì xảy đến, thì ngoài kia vẫn là bầu trời xanh ngập tràn ánh nắng.
Tác giả Rosita Nguyễn tên thật là Nguyễn Thị Mai Hồng. Ngày sinh: 13/11/1979, nguyên quán: Thanh Oai - Hà Nội. Nơi sinh: Hải Phòng. Đang sống và làm việc tại Thành phố Đà Nẵng.
Rosita Nguyễn khi còn là học sinh tại trường PTTH Năng Khiếu Trần Phú - Hải Phòng và sinh viên trường đại học Kinh tế Quốc dân - Hà Nội, đã sáng tác và có thơ, truyện ngắn đăng trên các báo, tạp chí: Tiền Phong, Hoa Học Trò, Sinh viên…, in chung truyện ngắn trong tuyển tập Trò xúc xắc của tình yêu – NXB Thanh Niên (2002).
Trời xanh ngập nắng
• Top 10 “Chạm – 2018” – Tôn vinh những cuốn sách truyền cảm hứng.
• Giải Cuốn sách Chạm tới trái tim do Trạm đọc bình chọn năm 2018', 100, 1, 1)
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'DẤU ẤN THẾ HỆ MỚI - ĐỪNG GIẪM LÊN CỎ',  50000,  10, 'dung-giam-len-co_715623afe2cf496ba833ec13974432e2_large.png',
'978-604-2-27092-2', N'Nguyễn Thị Bích Nga', N'Nhi đồng (6 – 11)', '14,5x20,5 cm',  168, 'bìa mềm'
,  210, 'Dấu ấn thế hệ mới', N'“Khi nhìn thấy tôi chụp hình bên tấm bảng ĐỪNG GIẪM LÊN CỎ, chị tôi nhắn tin, nói rằng tấm hình dễ thương quá và biểu tôi viết một truyện ngắn với tấm hình này. Tôi "yeah, yeah" nhưng rồi lãng đi mất.
Cách đây hai tháng, biên tập viên Nhà xuất bản Kim Đồng gọi tôi: "Chị ơi, viết cho em một cuốn nhé." Tới lúc đó tôi mới giật mình. Tôi bắt đầu cặm cụi viết cho em.
Trong cuốn sách này có mười sáu truyện ngắn nho nhỏ, và mỗi câu chuyện là một con vật dễ thương mà tôi gặp gỡ hàng ngày trên xứ Mỹ này...”
                                                                                                                                                                NGUYỄN THỊ BÍCH NGA
Nhà văn Nguyễn Thị Bích Nga sinh ngày 20 tháng 7, hiện đang định cư tại California, Mỹ.
GIẢI THƯỞNG
• Giải A cuộc vận động sáng tác cho thiếu nhi của Nhà xuất bản Kim Đồng năm 1995 - Tập truyện vừa Nhạc giữa trời.
• Giải C cuộc vận động sáng tác Tình bạn tuổi thơ (2006 - 2007) của Dự án Hỗ trợ Văn học thiếu nhi Việt Nam - Đan Mạch - Chùm truyện ngắn Năm câu chuyện về bé Kim.
• Giải Nhất cuộc vận động sáng tác Một ngày kì lạ (2007 - 2008) của Dự án Hỗ trợ Văn học thiếu nhi Việt Nam - Đan Mạch - Truyện ngắn Thầy lang hai mặt.
• Giải Nhì cuộc vận động sáng tác Bước qua hai thế giới (2008 - 2009) của Dự án Hỗ trợ Văn học thiếu nhi Việt Nam - Đan Mạch - Truyện ngắn Cậu bé vét giếng.
• Giải Ba cuộc vận động sáng tác Bí mật của tôi (2011 - 2012) của Dự án Hỗ trợ Văn học
thiếu nhi Việt Nam - Đan Mạch - Truyện ngắn Cái mụt ruồi ở chóp mũi.
Tác phẩm đã in ở Nhà xuất bản Kim Đồng
• Nhạc giữa trời - Truyện vừa
• Chuyện huynh và muội - Truyện dài (10 tập)
• Chiếc gương thời gian - Truyện dài (20 tập)
• Những nốt nhạc vui - Tập truyện ngắn
• Dịch bộ truyện nhiều tập của Road Dahl
• Viết lời cho bộ sách tranh hướng nghiệp “Những người sống quanh em”
***', 50, 1, 1)
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )
INSERT INTO SACH
	(TENSACH, GIABAN, SALE, ANHBIA,
	ISBN, TACGIA, DOITUONG, KHUONKHO, SOTRANG,
	DINHDANG, TRONGLUONG, BOSACH, MOTA, SOLUONGTON, MACD, MADM)
VALUES(N'',  ,  , '', '', N'', N'', '',  , '',  , '', N'',  )