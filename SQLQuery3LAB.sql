USE NIR
GO

Create Table Patient(
Compulsory_medical_insurance_of_the_patient varchar(30) Primary Key,
The_diagnosis_with_which_he_entered varchar(500),
SNILS varchar(30) Unique,
FIO_Patient varchar(500)
)
GO

Create Table Additional_information(
OMC varchar(30) References Patient(Compulsory_medical_insurance_of_the_patient) Primary Key,
Allergy varchar(500),
RH varchar(100),
Blood_type smallint
)
GO

Create Table Type_of_department(
ID_department smallint Primary Key,
Name_of_department varchar(300)
)
GO

Create Table Ward(
Number smallint,
Code_hir_department smallint,
ID_department smallint,
Numb_empt_sit varchar(10),
Numb_sit varchar(10),
Primary Key(Number, Code_hir_department, ID_department)
)
GO

Create Table Staff(
ID_staff smallint Primary Key,
FIO varchar(500),
Phone_numb varchar(15),
ID_department smallint,
Code_hir_department smallint
)
GO

Create Table Hir_hospital(
Code_hir_department smallint Primary Key,
Name_hir_department varchar(200) Unique,
Adress_hir_department varchar(400) Unique,
Boss smallint References Staff(ID_staff),
Phone_hir_department varchar(15) Unique
)
GO

Create Table Department(
Code_hir_department smallint References Hir_hospital(Code_hir_department),
ID_department smallint References Type_of_department(ID_department),
Boss_department smallint,
Primary Key(Code_hir_department, ID_department)
)
GO

Alter Table Staff
Add Constraint FK_Staff Foreign Key (Code_hir_department, ID_department) References Department(Code_hir_department, ID_department)

Alter Table Department
Add Constraint FK_Staff1 Foreign Key(Boss_department) References Staff(ID_staff)

Alter Table Ward
Add Constraint FK_Ward1 Foreign Key (Code_hir_department, ID_department) References Department(Code_hir_department, ID_department)

Create Table Passport_data(
Code_pass varchar(6) Primary Key,
Data_get_pass date,
Numb_pass varchar(6),
Who_give_pass varchar(100),
Tally_pass varchar(4),
Adress_pass varchar(100),
ID_staff smallint References Staff(ID_staff),
OMC varchar(30) References Patient(Compulsory_medical_insurance_of_the_patient),
Unique(Data_get_pass, Numb_pass, Who_give_pass, Tally_pass)
)
GO

Create Table Receptionist(
ID_staff smallint Primary Key References Staff(ID_staff)
)
GO

Create Table Guard_nurse(
ID_staff smallint Primary Key References Staff(ID_staff)
)
GO

Create Table Therapist(
ID_staff smallint Primary Key References Staff(ID_staff)
)
GO

Create Table Initial_inspection(
OMC varchar(30) References Patient(Compulsory_medical_insurance_of_the_patient),
Date_in date,
Doc_Receptinoist smallint References Receptionist(ID_staff),
Diagnosis varchar(MAX),
Primary Key(OMC, Date_in)
)
GO

Create Table Patient_in_ward(
ID_Patient smallint Primary Key,
OMC varchar(30),
Code_hir_department smallint,
Date_in date,
Number smallint,
ID_department smallint,
Constraint FK_PiW1 Foreign Key(Number, Code_hir_department, ID_department) References Ward(Number, Code_hir_department, ID_department),
Constraint FK_PiW2 Foreign Key (OMC, Date_in) References Initial_inspection(OMC, Date_in),
Unique (OMC, Code_hir_department, Date_in, Number, ID_department)
)
GO

Create Table Doc_Patient(
ID_Patient smallint References Patient_in_ward(ID_Patient),
ID_Staff smallint References Therapist(ID_Staff),
Primary Key(ID_Patient, ID_Staff)
)
GO

Create Table Extract_(
Numb_extract smallint Primary Key,
ID_Patient smallint,
ID_Staff smallint,
Date_out date,
Diagnosis varchar(MAX),
Constraint FK_Extract Foreign Key (ID_Patient, ID_Staff)References Doc_Patient(ID_Patient, ID_Staff),
Unique (ID_Patient, ID_Staff, Date_out)
)
GO

Create Table List_not_working(
Numb_extract smallint References Extract_(Numb_extract) Primary Key,
Date_open date,
Date_close date,
)
GO

Create Table Operation(
ID_operation smallint,
Date_operation date,
ID_Staff smallint,
ID_Patient smallint,
Name_operation varchar(MAX),
Discriptionary_operation varchar(MAX),
Discriptionary_bad varchar(MAX),
Constraint FK_Operation1 Foreign Key (ID_Patient, ID_Staff) References Doc_Patient(ID_Patient, ID_Staff),
Primary Key(ID_operation, Date_operation, ID_Staff,
ID_Patient)
)
GO

Create Table Сonservative(
ID_Staff smallint,
ID_Patient smallint,
ID_procedure smallint,
ID_Staff_Nurce smallint,
Preparat varchar(MAX),
Procadure_name varchar(MAX),
Numbers_procedure smallint,
ID_staff_nurse smallint References Guard_Nurse(ID_staff),
Constraint FK_Operation Foreign Key (ID_Patient, ID_Staff) References Doc_Patient(ID_Patient, ID_Staff),
Primary Key(ID_Staff, ID_Patient)

)
GO

Insert into Patient Values
('12345678901', 'Язвенный колит, острый', '098765432109', 'Андреев Андрей Андреевич'),
('23748923743', 'Колики в животе', '54936810653', 'Петров Петр Петрович'),
('95959504319', 'Камни в почках', '8697444596', 'Иванов Иван Иванович'),
('12837634501', 'Апендицит', '98457124467', 'Максимов Алексей Владимирович'),
('94827457292', 'Паропроктит', '37482109542', 'Журавлева Ирина Витальевна'),
('81729234063', 'Язва желудка','23475001345','Аллегрова Ксения Петровна')

select * from Patient

Insert into Additional_information Values
('12345678901', 'Анальгетики', '+', '4'),
('23748923743', NULL, '-', '2'),
('95959504319', 'Пенициллины', '-', '3'),
('12837634501', 'Макролиды', '+', '2'),
('94827457292', 'Аминогликозиды', '+', '1'),
('81729234063', NULL, '-', '4')

select * from Additional_information

Insert into Type_of_department Values
(1111, 'Отделение 1'),
(1112, 'Отделение 2'),
(1113, 'Отделение 3')

select * from Type_of_department

Insert into Ward (Number, Code_hir_department, ID_department, Numb_empt_sit, Numb_sit)Values
(0001,3111,1111,2,5),
(0002,3111,1111,3,5),
(0003,3111,1111,1,5)

select * from Ward

Insert into Staff Values
(2001, 'Андреев Дмитрий Павлович', '89376594418', 1111, 3111),
(2002, 'Андреев Павел Петрович', '89270133686', 1111, 3111),
(2003, 'Петрова Юлия Валерьевна', '84871848894', 1111, 3111),
(2004, 'Алексеева Юлия Сергеевна', '81030566538', 1111, 3111),
(2005, 'Прокаева Анастасия Юрьевна', '8112095771', 1111, 3111),
(2006, 'Покарева Элина Ивановна', '8095658818', 1111, 3111),
(2007, 'Павлова Екатерина Алексеевна', '811784364419', 1111, 3111),
(2008, 'Перов Роман Сергеевич', '83452137878', 1111, 3111),
(2009, 'Петрушкин Евгений Евгеньевич', '89711231122', 1111, 3111),
(2010, 'Иванов Иван Иванович', '81231235566', 1111, 3111),
(2011, 'Павлов Павел Павлович', '83213214455', 1111, 3111),
(2012, 'Дмитриев Дмитрий Дмитриевич', '84564561111', 1111, 3111),
(2013, 'Осипов Алексей Романович', '86546548888', 1111, 3111),
(2014, 'Белоусов Антон Эдуардович', '87897891423', 1111, 3111),
(2015, 'Репина Екатерина Алексеевна', '81901907623', 1111, 3111),
(2016, 'Насыров Ринат Маратович', '84890392357', 1111, 3111),
(2017, 'Александра Александровна Алексеевна', '80002321679', 1111, 3111),
(2018, 'Трофимова Арина Сергеевна', '89375679800', 1111, 3111),
(2019, 'Шкайдуров Егор Сергеевич', '81112223344', 1111, 3111),
(2020, 'Виншель Эдуард Маратович', '82221114433', 1111, 3111),
(2021, 'Иван Приказчиков Андреевич', '87879342021', 1111, 3111),
(2022, 'Рассказов Андрей Валерьевич', '89371125679', 1111, 3111),
(2023, 'Прохоров Юрий Маратович', '89370092375', 1111, 3111),
(2024, 'Лев Кислинский Семёнович', '89275468668', 1111, 3111),
(2025, 'Покарева Татьяна Сергеевна', '80099887755', 1111, 3111),
(2026, 'Петров Иван Иванович', '89998887564', 1111, 3111),
(2027, 'Трофимова Юлия Васильевна', '89998887744', 1111, 3111),
(2028, 'Жиганов Дмитрий Юрьевич', '89998882233', 1111, 3111),
(2029, 'Пупкин Василий Геннадьевич', '89378438641', 1111, 3111),
(2030, 'Швечихин Антон Сергеевич', '88908902255', 1111, 3111),
(2031, 'Побединский Артемий Юрьевич', '81230985687', 1111, 3111),
(2032, 'Яшин Даниил Константинович', '80129348576', 1111, 3111),
(2033, 'Дяглев Иван Антонович', '88845213344', 1111, 3111)

select * from Staff

Insert into Hir_hospital Values
(3111, 'Хирургический стационар №1', 'г. Самара, обл. Самарская, ул. Ново-Садовая, д.222б', NULL, '891600000000'),
(3112, 'Хирургический стационар №2', 'г. Самара, обл. Самарская, ул. Ново-Садовая, д.222a', NULL, '891500000000')
Update Hir_hospital set Boss = 2002 where Code_hir_department = 3112;
Update Hir_hospital set Boss = 2001
where Code_hir_department = 3111;

select * from Hir_hospital

Insert into Department Values
(3111, 1111, NULL),
(3111, 1112, NULL),
(3111, 1113, NULL),

(3112, 1111, NULL),
(3112, 1112, NULL),
(3112, 1113, NULL)

Update Department set Boss_department = 2003 where Code_hir_department = 3111 and ID_department = 1111
Update Department set Boss_department = 2004 where Code_hir_department = 3111 and ID_department = 1112
Update Department set Boss_department = 2005 where Code_hir_department = 3111 and ID_department = 1113

Update Department set Boss_department = 2006 where Code_hir_department = 3112 and ID_department = 1111
Update Department set Boss_department = 2007 where Code_hir_department = 3112 and ID_department = 1112
Update Department set Boss_department = 2008 where Code_hir_department = 3112 and ID_department = 1113

select * from Department

Insert into Passport_data Values

('456789', '1984-03-19', '789312', 'ГУ МВД России 1', '6731', 'г. Самара, обл. Самарская, ул. Мечникова, д. 50А', 2001, NULL),
('444312', '1982-06-01', '678346', 'ГУ МВД России 4', '7805', 'г. Самара, обл. Самарская, ул. Аксакова, д. 42', 2002, NULL),
('492012', '1960-11-28', '353455', 'ГУ МВД России 2', '4568', 'г. Самара, обл. Самарская, ул. Урицкого, д. 43', 2003, NULL),
('239480', '1989-03-10', '577678', 'ГУ МВД России 2', '5498', 'г. Самара, обл. Самарская, ул. Чернореченская, д. 1', 2004, NULL),
('230492', '1989-04-28', '923424', 'ГУ МВД России 3', '1234', 'г. Самара, обл. Самарская, ул. Карла-Макрса, д. 2', 2005, NULL),
('101203', '1989-05-30', '567532', 'ГУ МВД России 7', '7862', 'г. Самара, обл. Самарская, ул. Карла-Маркса, д. 46', 2006, NULL),
('451233', '1989-02-14', '334633', 'ГУ МВД России 2', '5646', 'г. Самара, обл. Самарская, ул. Ботаническая, д. 7', 2007, NULL),
('101023', '1989-11-16', '422341', 'ГУ МВД России 7', '8879', 'г. Самара, обл. Самарская, ул. Гаражная, д. 43', 2008, NULL),
('567950', '1998-10-17', '311232', 'ГУ МВД России 2', '1234', 'г. Самара, обл. Самарская, ул. Подшипникова, д. 32', 2009, NULL),
('700754', '1998-09-18', '123112', 'ГУ МВД России 2', '4684', 'г. Самара, обл. Самарская, ул. 70-Лет-октября, д. 32', 2010, NULL),
('202349', '1998-08-10', '089786', 'ГУ МВД России 4', '2384', 'г. Самара, обл. Самарская, ул. Тополиная, д. 40', 2011, NULL),
('120398', '1998-03-02', '567000', 'ГУ МВД России 4', '3467', 'г. Самара, обл. Самарская, ул. 40-лет-победы, д. 221', 2012, NULL),
('690445', '1998-04-03', '234443', 'ГУ МВД России 4', '5564', 'г. Самара, обл. Самарская, ул. Южное шоссе, д. 22', 2013, NULL),
('506755', '1998-06-06', '988756', 'ГУ МВД России 6', '7789', 'г. Самара, обл. Самарская, ул. Автозаводское шоссе, д. 10', 2014, NULL),
('104953', '1998-03-13', '234233', 'ГУ МВД России 5', '1346', 'г. Самара, обл. Самарская, ул. Обводное шоссе, д. 18', 2015, NULL),
('065432', '1999-02-16', '008545', 'ГУ МВД России 1', '7978', 'г. Самара, обл. Самарская, ул. 50-лет-октября, д. 29', 2016, NULL),
('212304', '1999-04-17', '223422', 'ГУ МВД России 2', '2234', 'г. Самара, обл. Самарская, ул. Шоссе водникова, д. 14', 2017, NULL),
('795423', '1999-07-18', '223442', 'ГУ МВД России 2', '5467', 'г. Самара, обл. Самарская, ул. Рябиновый бульвар, д. 29', 2018, NULL),
('704534', '1994-07-20', '111233', 'ГУ МВД России 2', '1234', 'г. Самара, обл. Самарская, ул. Ленина, д. 35', 2019, NULL),
('556956', '1994-01-25', '179567', 'ГУ МВД России 1', '4678', 'г. Самара, обл. Самарская, ул. Юбилейное, д. 33', 2020, NULL),
('111111', '1994-06-21', '934134', 'ГУ МВД России 3', '3347', 'г. Самара, обл. Самарская, ул. Вольское, д. 36', 2021, NULL),
('222222', '1994-06-09', '672122', 'ГУ МВД России 3', '7762', 'г. Самара, обл. Самарская, ул. Подшипникова, д. 37', 2022, NULL),
('333333', '1993-04-28', '567523', 'ГУ МВД России 4', '4567', 'г. Самара, обл. Самарская, ул. Подшипникова, д. 60', 2023, NULL),
('444444', '1992-11-28', '678546', 'ГУ МВД России 4', '7568', 'г. Самара, обл. Самарская, ул. Гаражная, д. 50', 2024, NULL),
('555555', '1993-12-23', '342342', 'ГУ МВД России 4', '4456', 'г. Самара, обл. Самарская, ул. Гая, д. 80', 2025,
NULL),
('666666', '1992-10-22', '231141', 'ГУ МВД России 5', '3213', 'г. Самара, обл. Самарская, ул. Гая, д. 70', 2026, NULL),
('777777', '1999-09-21', '967878', 'ГУ МВД России 6', '1347', 'г. Самара, обл. Самарская, ул. Ново-садовая, д. 220', 2027, NULL),
('888888', '1990-02-21', '342341', 'ГУ МВД России 2', '7983', 'г. Самара, обл. Самарская, ул. Фрунзе, д. 11', 2028, NULL),
('999999', '1990-04-22', '232424', 'ГУ МВД России 2', '5677', 'г. Самара, обл. Самарская, ул. Мичурина, д. 12', 2029, NULL),
('456940', '1987-08-23', '123123', 'ГУ МВД России 2', '6548', 'г. Самара, обл. Самарская, ул. Никитинская, д. 44', 2030, NULL),
('234943', '1967-07-27', '897894', 'ГУ МВД России 1', '5648', 'г. Самара, обл. Самарская, ул. Никитинская, д. 12', 2031, NULL),
('609653', '1967-06-04', '345895', 'ГУ МВД России 6', '3524', 'г. Самара, обл. Самарская, ул. Гая, д. 31', 2032, NULL),
('223474', '1990-02-15', '345342', 'ГУ МВД России 5', '7454', 'г. Самара, обл. Самарская, ул. Гая, д. 23', 2033, NULL),

('489842', '1999-01-03', '849652', 'ГУ МВД России 1', '8982', 'г. Самара, обл. Самарская, ул. Маяковского, д. 1', NULL, '12345678901'),
('950482', '1970-11-20', '239423', 'ГУ МВД России 2', '4443', 'г. Самара, обл. Самарская, ул. Гагарина 2, д. 45', NULL, '23748923743'),
('456733', '1989-11-18', '349058', 'ГУ МВД России 3', '2021', 'г. Самара, обл. Самарская, ул. Льва-Толстого, д. 22', NULL, '95959504319'),
('101010', '1990-10-24', '101012', 'ГУ МВД России 5', '1010', 'г. Самара, обл. Самарская, ул. Братьев-Коростелёвых, д. 31', NULL, '12837634501'),
('202020', '1991-05-27', '603542', 'ГУ МВД России 1', '5556', 'г. Самара, обл. Самарская, ул. Гая, д. 30', NULL, '94827457292'),
('555043', '1990-06-17', '333253', 'ГУ МВД России 7', '3162', 'г. Самара, обл. Самарская, ул. Первомайская, д. 5', NULL, '81729234063'),


select * from Passport_data

Insert into Receptionist Values
(2009), (2010), (2011),
(2018), (2019), (2020),
(2021), (2022), (2023)

select * from Receptionist

Insert into Guard_nurse Values
(2012), (2013), (2014),
(2024), (2025), (2026),
(2027), (2028), (2029)

select * from Guard_nurse

Insert into Therapist Values
(2015), (2016), (2017),
(2030), (2031), (2032),
(2033)

select * from Therapist

Insert into Initial_inspection Values
('12345678901', '2021-03-16', 2019, 'Острение язвенного колита'),
('23748923743', '2021-04-06', 2010, 'Желчно-каменная болезнь, обострение'),
('95959504319', '2021-03-21', 2011, 'Дивертикулез'),
('12837634501', '2021-06-19', 2022, 'Острый панкреатит'),
('94827457292', '2021-05-17', 2011, 'Язвенная болезнь желудка '),
('81729234063', '2021-03-02', 2011, 'Острый аппендицит')

select * from Initial_inspection

Insert into Patient_in_ward Values
(4001, '12345678901', 3111, '2021-03-16', 0001, 1111),
(4002, '23748923743', 3111, '2021-04-06', 0002, 1111),
(4003, '95959504319', 3111, '2021-03-21', 0001, 1111),
(4004, '12837634501', 3111, '2021-06-19', 0001, 1111),
(4005, '94827457292', 3111, '2021-05-17', 0002, 1111),
(4006, '81729234063', 3111, '2021-03-02', 0001, 1111)

select * from Patient_in_ward

Insert into Doc_Patient Values
(4001, 2015),
(4002, 2016),
(4003, 2030),
(4004, 2031),
(4005, 2033),
(4006, 2033)

select * from Doc_Patient

Insert into Extract_ Values
(9001, 4001, 2015, '2021-03-26', 'Язвенный колит, обострение, положительная динамика, обострение стихло'),
(9002, 4002, 2016, '2021-04-20', 'Желчно-каменная болезнь, обострение, в результате лечения обострение стихло'),
(9003, 4003, 2030, '2021-03-28', 'Дивертикулёз сигмовидной кишки, в результате лечения обострение стихло'),
(9004, 4004, 2031, '2021-07-01', 'Панкреатит острый, в результате лечения обострение стихло'),
(9005, 4005, 2033, '2021-05-29', 'Язвенная болезнь желудка, в результате лечения обострение стихло'),
(9006, 4006, 2033, '2021-03-26', 'Острый аппендицит, острый флегмонозный, операция была числа, швы сняты, без полеоперационных осложнений')

select * from Extract_

Insert into List_not_working Values
(9001, '2021-03-16', '2021-03-26'),
(9002, '2021-04-06', '2021-04-20'),
(9003, '2021-03-21', '2021-03-28'),
(9004,
'2021-06-19', '2021-07-01'),
(9005, '2021-05-17', '2021-05-29'),
(9006, '2021-03-02', '2021-03-26')

select * from List_not_working

Insert into Operation Values
(5009, '2021-03-17', 2015, 4001, 'Операция1', 'Описание операции Описание операции Описание операции1', 'Без осложнений1'),
(5195, '2021-04-10', 2033, 4005, 'Операция2', 'Описание операции Описание операции Описание операции2', 'Осложение1'),
(5847, '2021-03-23', 2033, 4006, 'Операция3', 'Описание операции Описание операции Описание операции3', 'Без осложнений2')

select * from Operation

Insert into Сonservative Values
(2015, 4001, 6348, 2012, 'Формальдегид', 'Насыщение формальдегидом', 7, 2012),
(2016, 4002, 6012, 2013, 'Витамин С', 'Поедание витаминок', 15, 2012),
(2030, 4003, 6945, 2014, 'Глюкоза', 'Уколы глюкозы', 2, 2013),
(2031, 4004, 6773, 2013, 'Глюкоза', 'Уколы глюкозы', 10, 2013),
(2033, 4005, 6623, 2013, 'Глюкоза', 'Уколы глюкозы', 4, 2013),
(2033, 4006, 6321, 2013, 'Глюкоза', 'Уколы глюкозы', 4, 2012)

select * from Сonservative

--изменить максимальное кол-во мест и свободных мест в палатах первого отделения
Update Ward
set Numb_empt_sit = Numb_empt_sit+1, Numb_sit = Numb_sit-1
where ID_department in (select ID_department from Type_of_department where Type_of_department.Name_of_department = 'Отделение 1')

select * from Ward

--удаление ошибочной записи по ФМО пациента
Delete from Сonservative where ID_Patient in (select ID_Patient from Patient_in_ward where OMC in(select OMC from Patient 
where Patient.FIO_Patient = 'Андреев Андрей Андреевич')) 

--вывод паспортных данных о пациентах, проживающих на улицах, название которых начинается на букву Г (изменить)
Select Distinct OMC as 'ОМС пациента', Code_pass 'Код паспорта', Numb_pass 'Номер паспорта', 
Tally_pass 'Серия паспорта', Data_get_pass 'Дата выдачи паспорта'
from Passport_data where Adress_pass like '%ул. Г%'


--вевести сведенbя о пациентах, получившивх кончервативное лечение с числом процедур в интервале от 4 до 10
Select FIO_patient as 'ФИО пациента' from Patient where Patient.Compulsory_medical_insurance_of_the_patient in 
(select Patient.Compulsory_medical_insurance_of_the_patient from Patient_in_ward where Patient_in_ward.ID_Patient in 
(select ID_Patient from Сonservative where Numbers_procedure between 4 and 10)) 

--выборка or, получение ОМС пациента и его даты первичного осмотра по ID врача приёмного покоя, проводившего осмотр (2011) или с диагнозом (Острый панкреатит)
Select Distinct OMC as 'ОМС пациента', Date_in 'Дата проведения первичного осмотра'
from Initial_inspection where Doc_Receptinoist in(select Doc_Receptinoist from Staff where FIO = 'Павлов Павел Павлович') 
or Diagnosis = 'Острый панкреатит'

--группировка с ограничением, количество процедур, проведённых определёнными медсёстрами (переделать без ID) 
--(фамилии пациентов, у которых проведены проыедуры не менее такого то кол-ва определённой мед сестрой)
select FIO_Patient as 'ФИО пациента', count(ID_procedure) 'Кол-во процедур'
from Сonservative join Patient_in_ward on Сonservative.ID_Patient = Patient_in_ward.ID_Patient join Patient on Patient_in_ward.OMC = Patient.Compulsory_medical_insurance_of_the_patient 
group by Patient.FIO_Patient having min(ID_staff_nurse)<2013

--case, с оценкой кол-ва процедур (вывести фио)
select FIO_Patient as 'ФИО пациента', Procadure_name as 'Название процедуры', Numbers_procedure as 'Кол-во процедур',
case
	when Numbers_procedure<4 then 'Недостаточное кол-во'
	when Numbers_procedure>9 then 'Большое кол-во'
	else 'Достаточное кол-во'
end  'Мнение о кол-ве процедур'

from Сonservative join Patient_in_ward on Сonservative.ID_Patient = Patient_in_ward.ID_Patient join Patient on Patient_in_ward.OMC = Patient.Compulsory_medical_insurance_of_the_patient

--where, (искать по ФИО) вывести сведения о пациентах, выписанные в указанный период, конкретным врачом
select FIO_Patient as 'ФИО пациента', Numb_extract as 'Номер выписки', Date_out as 'Дата выписки', Diagnosis as 'Диагноз выписки' 
from Extract_ join Patient_in_ward on Extract_.ID_Patient = Patient_in_ward.ID_Patient join Patient on Patient_in_ward.OMC = Patient.Compulsory_medical_insurance_of_the_patient where Extract_.ID_staff in (select Extract_.ID_staff from Extract_ join Staff on Staff.ID_staff = Extract_.ID_staff where FIO = 'Дяглев Иван Антонович')	


--подзапросы в списке выводимых значений, скольким пациентам мед сестра проводила процедуры (поменять ID) вывести фимилию мед сестры и кол-во процеур, выполненных ею
select FIO as 'ФИО персонала', (select sum(Numbers_procedure)
from Сonservative where Сonservative.ID_staff_nurse=Guard_nurse.ID_staff) as 'Кол-во выполненных процедур'
from Guard_nurse join Staff on Guard_nurse.ID_staff = Staff.ID_staff

--from, выводим информацию о пациенте по диагнозу, его дату поступления, фио, id, палату с номером отделения, где лежит 
--(весето номера отделения писать название, ID пациента не нужно) (пациента соединяю с подзапросом, возвращающим ID и при условии что у него диагноз апендицит)
select FIO_Patient as 'ФИО пациента', The_diagnosis_with_which_he_entered as 'Дигноз при поступлении', Date_in as 'Дата поступления', Name_of_department as 'Отделение', Number as 'Номер палаты' 
from Patient inner join Patient_in_ward on Patient.Compulsory_medical_insurance_of_the_patient = Patient_in_ward.OMC join Type_of_department on Patient_in_ward.ID_department = Type_of_department.ID_department 
where The_diagnosis_with_which_he_entered = 'Апендицит'

insert into Patient values
('34545434212', 'Апендицит', '48572946824', 'Петренко Пётр Николаевич'),
('56838385686', 'Апендицит', '38355644731', 'Акимов Алексей Юрьевич')

insert into Initial_inspection values
('34545434212', '2021-03-21', 2011, 'Апендицит'),
('56838385686', '2021-03-21', 2011, 'Апендицит'),
('93274192844', '2021-03-21', 2011, 'Апендицит')

insert into Patient_in_ward values
('93274192844', 'Апендицит', '11293447589', 'Вареников Жорик Маратович')

select * from Patient_in_ward

insert into Passport_data values
('101021', '1990-10-24', '101014', 'ГУ МВД России 5', '1011', 'г. Самара, обл. Самарская, ул. Братьев-Коростелёвых, д. 31', NULL, '12837634501'),
('101022', '1990-10-24', '101015', 'ГУ МВД России 5', '1012', 'г. Самара, обл. Самарская, ул. Братьев-Коростелёвых, д. 31', NULL, '12837634501'),
('101023', '1990-10-24', '101016', 'ГУ МВД России 5', '1013', 'г. Самара, обл. Самарская, ул. Братьев-Коростелёвых, д. 31', NULL, '12837634501')
select * from Passport_data

select * from Patient_in_ward
--ещё  добавить 2-3 человека



------------------------------------------------------------------------------------------------------------------------------------------------------------


--1.1 Динамический курсор
--Создать динамический курсор для обработки информации об абонентах с указанной льготой.
--вывести пациенах указанным диагнозом
--объявления курсора

declare dynamic_cursor cursor dynamic scroll
for select ID_operation, Date_operation, Name_operation, Discriptionary_operation, Discriptionary_bad
	from Operation
--открытие курсора
open dynamic_cursor
	declare
		@ID_operation smallint,
		@Date_operation date,
		@Name_operation varchar(MAX),
		@Discriptionary_operation varchar(MAX),
		@Discriptionary_bad varchar(MAX)

--устанавливаем указатель на первую запись в таблице
fetch first from dynamic_cursor into @ID_operation, @Date_operation, @Name_operation, @Discriptionary_operation, @Discriptionary_bad
--пока есть записи в курсоре
while @@FETCH_STATUS = 0
begin
--вывод значения переменных
	select @ID_operation 'ID операции', @Date_operation 'Дата проведения', @Name_operation 'Название операции', 
	@Discriptionary_operation 'Описание операции', @Discriptionary_bad 'Осложнения'
	fetch next from dynamic_cursor into @ID_operation, @Date_operation, @Name_operation, @Discriptionary_operation, @Discriptionary_bad
end;

--обновление данных 1
UPDATE Operation
set Discriptionary_bad = 'Осложнение222'
where Discriptionary_bad = 'Осложнение222'
	close dynamic_cursor
deallocate dynamic_cursor










--1.2 статический курсор
declare static_cursor cursor scroll static
for select  ID_operation, Date_operation, Name_operation, Discriptionary_operation, Discriptionary_bad
	from Operation
open static_cursor
declare 
	@ID_operation2 smallint,
		@Date_operation2 date,
		@Name_operation2 varchar(MAX),
		@Discriptionary_operation2 varchar(MAX),
		@Discriptionary_bad2 varchar(MAX)
fetch first from static_cursor 
into @ID_operation2, @Date_operation2, @Name_operation2, @Discriptionary_operation2, @Discriptionary_bad2
while @@FETCH_STATUS = 0
begin
	select @ID_operation2 'ID операции', @Date_operation2 'Дата операции', @Name_operation2 'Название операции', 
	@Discriptionary_operation2 'Описание', @Discriptionary_bad2 'Осложения'
	fetch next from static_cursor
	into @ID_operation2, @Date_operation2, @Name_operation2, @Discriptionary_operation2, @Discriptionary_bad2
end;

--обновление данных 
UPDATE Operation
set Name_operation = 'Операция3333'
where  Name_operation = 'Операция3'
 
 close static_cursor
deallocate static_cursor


--1.3 ключевой курсор
DECLARE cursor_key CURSOR KEYSET  SCROLL FOR
SELECT ID_operation, Date_operation, Name_operation, Discriptionary_operation, Discriptionary_bad
from Operation
open cursor_key
DECLARE 
	@ID_operation3 smallint,
		@Date_operation3 date,
		@Name_operation3 varchar(MAX),
		@Discriptionary_operation3 varchar(MAX),
		@Discriptionary_bad3 varchar(MAX)

FETCH FIRST FROM cursor_key INTO @ID_operation3, @Date_operation3, @Name_operation3, @Discriptionary_operation3, @Discriptionary_bad3
WHILE @@FETCH_STATUS=0
BEGIN
SELECT @ID_operation3 'ID операции', @Date_operation3 'Дата операции', @Name_operation3 'Название операции', 
	@Discriptionary_operation3 'Описание', @Discriptionary_bad3 'Осложения'
FETCH NEXT FROM cursor_key INTO @ID_operation3, @Date_operation3, @Name_operation3, @Discriptionary_operation3, @Discriptionary_bad3
END;
 

UPDATE Operation SET ID_operation = '5222'
WHERE  ID_operation = '5195'


UPDATE Operation SET Discriptionary_operation = 'Описание2222'
WHERE  Discriptionary_operation = 'Описание операции Описание операции Описание операции1'

 CLOSE cursor_key
DEALLOCATE cursor_key

select * from Initial_inspection







--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--2.1 простой вид
--создать вид, отображающий ОМС пациентов, дату их поступления и диагноз, если дата поступления находится в диапазоне:...
--drop view view1
go
create view view1 (OMC1, Date_in1, Diagnosis1) as
select OMC, Date_in, Diagnosis
	from Initial_inspection
	where Date_in between '2021-04-06' and '2021-06-19'
go
select * from view1
drop view view1

--2.2 составной вид - на основе нескольких таблиц
--создать вид, отображающий ФИО пациентов, диагноз, аллергию и тип крови
go
create view view2 (FIO_Patient1, The_diagnosis_with_which_he_entered1, Allergy1, Blood_type1, RH1) as
select distinct FIO_Patient, The_diagnosis_with_which_he_entered, Allergy, Blood_type, RH
	from Patient join Additional_information
	on Patient.Compulsory_medical_insurance_of_the_patient = Additional_information.OMC
go
select FIO_Patient1, The_diagnosis_with_which_he_entered1, Allergy1, Blood_type1, RH1
from view2
drop view view2


select * from Initial_inspection


--2.3 вид из вида ???????
--создать вид, отображающий ФИО пациентов и их диагноз, с определённой аллергией = Макролиды
go
create view view3 (OMC1, Date_in1, Diagnosis1) as
select OMC1, Date_in1, Diagnosis1
	from view1
	where Date_in1 = '2021-04-06'
go
select * from view3
drop view view3


select * from Extract_
select * from Doc_Patient
insert into Doc_Patient values 
(4008, 2033)
select * from Patient_in_ward

--2.4 вид без использования WITH CHECK OPTION
--без использования CHECK OPTION
go
CREATE VIEW view4 AS SELECT Numb_extract, Date_out, Diagnosis
FROM Extract_ WHERE Date_out > '2021-03-26'
go

select * from view4
drop view view4

update view4 set Date_out = '2021-03-25' where Diagnosis = 'Желчно-каменная болезнь, обострение, в результате лечения обострение стихло'

insert view4 values (9007, '2021-03-25', 'Диагноз')



--2.5 вид с использованием WITH CHECK OPTION

go
create view view5 as select Numb_extract, Date_out, Diagnosis
from Extract_ where Date_out > '2021-03-26'
WITH CHECK OPTION
go
select * from view5
drop view view5


update view5 set Date_out = '2021-03-25' where Diagnosis = 'Панкреатит острый, в результате лечения обострение стихло'

insert view5 values (9008, '2021-03-25', 'Диагноз11')

select * from Extract_
----------------------------------------------------------------------------------------------------------------------------------------------------

--3 процедуры
CREATE PROCEDURE Proc1
	@idP smallint = 4004,
	@idS smallint,
	@diag varchar(MAX) Output
AS 
	BEGIN
	SET @diag = (SELECT Diagnosis FROM Extract_ WHERE ID_Patient = @idP and ID_Staff = @idS)
       END

drop procedure Proc1

--3.1 позиционный способ

DECLARE @pass varchar(MAX)
EXEC Proc1 4004, 2031, @pass Output
SELECT [Диагноз] = @pass

--3.2 ключевой способ

DECLARE @pass1 varchar(MAX)
EXECUTE Proc1 @idP = default, @idS = 2031, @diag = @pass1 Output
SELECT [Диагноз] = @pass1

--3.3 смешанный способ

DECLARE @pass2 varchar(MAX)
EXECUTE Proc1 default, @idS = 2031, @diag = @pass2 Output
SELECT [Даигноз] = @pass2

--4 скалярная хранимая ф-ия

select * from Additional_information

CREATE FUNCTION func1 (@na smallint) returns INT
AS
	BEGIN
		DECLARE @count int
		SET @count = (SELECT count(*) FROM Additional_information Where Blood_type=@na)
		return @count
	END
GO
SELECT [Количество людей со 2 группой крови в стационаре] = dbo.func1(2)

--5 ф-ия возвращающая табличное значение

select * from Initial_inspection
go
CREATE FUNCTION func2 (@ac varchar(MAX))
RETURNS TABLE
AS
RETURN (SELECT Patient.FIO_Patient, Initial_inspection.Date_in
FROM Initial_inspection join Patient on Initial_inspection.OMC = Patient.Compulsory_medical_insurance_of_the_patient
WHERE Diagnosis = @ac )
go
SELECT * FROM dbo.func2('Апендицит')
drop FUNCTION func2

--6 тригерры

CREATE TRIGGER triger1
ON Staff
FOR INSERT, UPDATE
AS
IF UPDATE(Phone_numb) and ((SELECT count(*) FROM Staff JOIN inserted 
ON Staff.Phone_numb = inserted.Phone_numb) > 1)
BEGIN
	RAISERROR('Персонал с таким номером телефона уже существует!', 16, 10)
	ROLLBACK TRAN
END
RETURN

drop trigger triger1

select * from Staff

update Staff set Phone_numb = '8095658818' where FIO = 'Перов Роман Сергеевич' --срабатывание стригера

update Staff set Phone_numb = '9231233232' where FIO = 'Перов Роман Сергеевич' --не срабатывание триггера

INSERT Staff VALUES (2034, 'ФИО444', '8112095771', '1111','3111') --срабатывание триггера

INSERT Staff VALUES (2034, 'ФИО444', '9232325342', '1111','3111') --не срабатывание триггера


--7 целостность restrict

select *from Staff
select * from Passport_data

CREATE TRIGGER TR3
ON Staff
FOR DELETE, UPDATE
AS 
	IF(EXISTS(SELECT * FROM Passport_data JOIN deleted ON Passport_data.ID_staff = deleted.ID_staff))
	BEGIN
		RAISERROR('Невозможно удалить название направления из таблицы, так как направление используется!', 16, 10)
		ROLLBACK TRAN
	END
RETURN

drop trigger TR3

DELETE FROM Staff WHERE FIO = 'Андреев Павел Петрович' --сработает

update Staff set FIO = '123ФИО123' where FIO = 'Жиганов Дмитрий Юрьевич' --сработает

insert into Staff values 
(2035, 'ФИОтестТриг3', '99999999999', 1111,3111)

update Staff set FIO = '123ФИО123' where FIO = 'ФИОтестТриг3' --не сработает
select * from Staff

DELETE FROM Staff WHERE FIO = '123ФИО123' -- не сработает
select * from Staff


--8 ссылочность cascade

--patient in wrd
--extract_


Create Table Extract2_(
Numb_extract smallint Primary Key,
ID_Patient smallint,
ID_Staff smallint,
Date_out date,
Diagnosis varchar(MAX)
)

Create Table Patient_in_ward2(
ID_Patient smallint Primary Key,
OMC varchar(30),
Code_hir_department smallint,
Date_in date,
Number smallint,
ID_department smallint
)

Insert into Patient_in_ward2 Values
(4001, '12345678901', 3111, '2021-03-16', 0001, 1111),
(4002, '23748923743', 3111, '2021-04-06', 0002, 1111),
(4003, '95959504319', 3111, '2021-03-21', 0001, 1111),
(4004, '12837634501', 3111, '2021-06-19', 0001, 1111),
(4005, '94827457292', 3111, '2021-05-17', 0002, 1111),
(4006, '81729234063', 3111, '2021-03-02', 0001, 1111)

Insert into Extract2_ Values
(9001, 4001, 2015, '2021-03-26', 'Язвенный колит, обострение, положительная динамика, обострение стихло'),
(9002, 4002, 2016, '2021-04-20', 'Желчно-каменная болезнь, обострение, в результате лечения обострение стихло'),
(9003, 4003, 2030, '2021-03-28', 'Дивертикулёз сигмовидной кишки, в результате лечения обострение стихло'),
(9004, 4004, 2031, '2021-07-01', 'Панкреатит острый, в результате лечения обострение стихло'),
(9005, 4005, 2033, '2021-05-29', 'Язвенная болезнь желудка, в результате лечения обострение стихло'),
(9006, 4006, 2033, '2021-03-26', 'Острый аппендицит, острый флегмонозный, операция была числа, швы сняты, без полеоперационных осложнений')

CREATE TRIGGER tr44
ON Patient_in_ward2
FOR UPDATE
AS
	UPDATE Extract2_ SET ID_Patient = (SELECT ID_Patient  FROM inserted) WHERE ID_Patient  IN (SELECT ID_Patient  FROM deleted)
RETURN

drop trigger tr44

UPDATE Patient_in_ward2 SET ID_Patient = 4010 WHERE ID_Patient = 4006
select * from Patient_in_ward2
select * from Extract2_



CREATE TRIGGER TR5
ON Patient_in_ward2
FOR DELETE
AS
	DELETE FROM Extract2_ WHERE ID_Patient IN (SELECT ID_Patient FROM deleted)
RETURN

select * from Patient_in_ward2
select * from Extract2_


DELETE FROM Patient_in_ward2 WHERE ID_Patient = 4010