create database motor;
use motor;

-- 1. Customer Table
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    DOB DATE,
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    Pincode VARCHAR(10),
    CONSTRAINT PK_Customer PRIMARY KEY (CustomerID)
);


use motor;


-- 2. InsuredVehicle
CREATE TABLE InsuredVehicle (
    VehicleID INT PRIMARY KEY AUTO_INCREMENT,
    PolicyHolderID INT,
    RegistrationNumber VARCHAR(20) UNIQUE,
    ChassisNumber VARCHAR(50),
    EngineNumber VARCHAR(50),
    Brand VARCHAR(50),
    Model VARCHAR(50),
    ManufacturingYear INT,
    FuelType VARCHAR(20),
    VehicleCategory VARCHAR(30),
    CONSTRAINT FK_VehicleCustomer FOREIGN KEY (PolicyHolderID) REFERENCES Customer(CustomerID)
);

-- 3. InsurancePolicy
CREATE TABLE InsurancePolicy (
    PolicyID INT PRIMARY KEY AUTO_INCREMENT,
    PolicyNumber VARCHAR(30) UNIQUE,
    PolicyHolderID INT,
    VehicleID INT,
    PolicyType VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    SumInsured DECIMAL(12,2),
    PolicyStatus VARCHAR(20),
    CONSTRAINT FK_PolicyCustomer FOREIGN KEY (PolicyHolderID) REFERENCES Customer(CustomerID),
    CONSTRAINT FK_PolicyVehicle FOREIGN KEY (VehicleID) REFERENCES InsuredVehicle(VehicleID)
);

-- 4. InsuranceProvider
CREATE TABLE InsuranceProvider (
    ProviderID INT PRIMARY KEY AUTO_INCREMENT,
    ProviderName VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address TEXT
);

-- 5. InsuranceAdvisor
CREATE TABLE InsuranceAdvisor (
    AdvisorID INT PRIMARY KEY AUTO_INCREMENT,
    AdvisorName VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    BranchName VARCHAR(100),
    CommissionRate DECIMAL(5,2)
);

-- 6. PremiumDetails
CREATE TABLE PremiumDetails (
    PremiumID INT PRIMARY KEY AUTO_INCREMENT,
    PolicyID INT,
    PremiumAmount DECIMAL(12,2),
    GSTAmount DECIMAL(10,2),
    DiscountAmount DECIMAL(10,2),
    TotalPremium DECIMAL(12,2),
    DueDate DATE,
    CONSTRAINT FK_PremiumPolicy FOREIGN KEY (PolicyID) REFERENCES InsurancePolicy(PolicyID),
    CONSTRAINT chk_premium CHECK (PremiumAmount > 0)
);

-- 7. PaymentHistory
CREATE TABLE PaymentHistory (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    PremiumID INT,
    PaymentDate DATE,
    PaymentMethod VARCHAR(30),
    PaidAmount DECIMAL(12,2),
    TransactionReference VARCHAR(100),
    CONSTRAINT FK_PaymentPremium FOREIGN KEY (PremiumID) REFERENCES PremiumDetails(PremiumID)
);

-- 8. ClaimRequest
CREATE TABLE ClaimRequest (
    ClaimID INT PRIMARY KEY AUTO_INCREMENT,
    PolicyID INT,
    ClaimDate DATE,
    ClaimedAmount DECIMAL(12,2),
    ApprovedAmount DECIMAL(12,2),
    ClaimStatus VARCHAR(30),
    ClaimReason TEXT,
    CONSTRAINT FK_ClaimPolicy FOREIGN KEY (PolicyID) REFERENCES InsurancePolicy(PolicyID)
);

-- 9. AccidentReport
CREATE TABLE AccidentReport (
    ReportID INT PRIMARY KEY AUTO_INCREMENT,
    ClaimID INT,
    AccidentDate DATE,
    AccidentLocation VARCHAR(255),
    ReportDetails TEXT,
    FIRNumber VARCHAR(50),
    CONSTRAINT FK_ReportClaim FOREIGN KEY (ClaimID) REFERENCES ClaimRequest(ClaimID)
);

-- 10. VehicleInspection
CREATE TABLE VehicleInspection (
    InspectionID INT PRIMARY KEY AUTO_INCREMENT,
    VehicleID INT,
    InspectorName VARCHAR(100),
    InspectionDate DATE,
    InspectionResult VARCHAR(30),
    Remarks TEXT,
    CONSTRAINT FK_InspectionVehicle FOREIGN KEY (VehicleID) REFERENCES InsuredVehicle(VehicleID)
);

-- 11. PolicyRenewal
CREATE TABLE PolicyRenewal (
    RenewalID INT PRIMARY KEY AUTO_INCREMENT,
    PolicyID INT,
    RenewalDate DATE,
    NewExpiryDate DATE,
    RenewalPremium DECIMAL(12,2),
    RenewalStatus VARCHAR(20),
    CONSTRAINT FK_RenewalPolicy FOREIGN KEY (PolicyID) REFERENCES InsurancePolicy(PolicyID)
);

-- 12. Beneficiary
CREATE TABLE Beneficiary (
    BeneficiaryID INT PRIMARY KEY AUTO_INCREMENT,
    PolicyHolderID INT,
    BeneficiaryName VARCHAR(100),
    Relationship VARCHAR(50),
    ContactNumber VARCHAR(15),
    CONSTRAINT FK_BeneficiaryCustomer FOREIGN KEY (PolicyHolderID) REFERENCES Customer(CustomerID)
);

-- 13. BranchOffice
CREATE TABLE BranchOffice (
    BranchID INT PRIMARY KEY AUTO_INCREMENT,
    BranchName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Phone VARCHAR(15)
);

-- 14. PolicyAssignment
CREATE TABLE PolicyAssignment (
    AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
    PolicyID INT,
    AdvisorID INT,
    AssignedDate DATE,
    CONSTRAINT FK_AssignmentPolicy FOREIGN KEY (PolicyID) REFERENCES InsurancePolicy(PolicyID),
    CONSTRAINT FK_AssignmentAdvisor FOREIGN KEY (AdvisorID) REFERENCES InsuranceAdvisor(AdvisorID)
);




INSERT INTO Customer
(CustomerID, FirstName, LastName, Gender, DOB, Phone, Email, Address, City, State, Pincode)
VALUES
(1, 'Arun', 'Kumar', 'Male', '1995-01-15', '9876543210', 'arun.kumar@gmail.com', '12 Gandhi Street', 'Chennai', 'Tamil Nadu', '600001'),
(2, 'Priya', 'Raman', 'Female', '1997-03-20', '9876543211', 'priya.r@gmail.com', '45 Anna Nagar', 'Coimbatore', 'Tamil Nadu', '641001'),
(3, 'Karthik', 'Raj', 'Male', '1992-06-10', '9876543212', 'karthik.raj@gmail.com', '22 East Street', 'Madurai', 'Tamil Nadu', '625001'),
(4, 'Divya', 'S', 'Female', '1998-09-05', '9876543213', 'divya.s@gmail.com', '18 Lake View', 'Salem', 'Tamil Nadu', '636001'),
(5, 'Vijay', 'M', 'Male', '1994-12-18', '9876543214', 'vijay.m@gmail.com', '7 Market Road', 'Erode', 'Tamil Nadu', '638001'),
(6, 'Meena', 'K', 'Female', '1996-04-11', '9876543215', 'meena.k@gmail.com', '10 Cross Street', 'Trichy', 'Tamil Nadu', '620001'),
(7, 'Rahul', 'Prasad', 'Male', '1993-08-22', '9876543216', 'rahul.p@gmail.com', '5 Temple Road', 'Vellore', 'Tamil Nadu', '632001'),
(8, 'Sneha', 'R', 'Female', '1999-07-09', '9876543217', 'sneha.r@gmail.com', '9 South Street', 'Tiruppur', 'Tamil Nadu', '641601'),
(9, 'Ajith', 'Kumar', 'Male', '1991-02-14', '9876543218', 'ajith.k@gmail.com', '15 Main Road', 'Namakkal', 'Tamil Nadu', '637001'),
(10, 'Anitha', 'B', 'Female', '1995-10-30', '9876543219', 'anitha.b@gmail.com', '3 Park Avenue', 'Karur', 'Tamil Nadu', '639001'),
(11, 'Suresh', 'R', 'Male', '1990-05-16', '9876543220', 'suresh.r@gmail.com', '21 Station Road', 'Dharmapuri', 'Tamil Nadu', '636701'),
(12, 'Kavya', 'N', 'Female', '1998-01-25', '9876543221', 'kavya.n@gmail.com', '14 College Street', 'Hosur', 'Tamil Nadu', '635109'),
(13, 'Manoj', 'S', 'Male', '1993-11-13', '9876543222', 'manoj.s@gmail.com', '8 Bus Stand Road', 'Cuddalore', 'Tamil Nadu', '607001'),
(14, 'Deepa', 'L', 'Female', '1996-06-07', '9876543223', 'deepa.l@gmail.com', '19 River View', 'Thanjavur', 'Tamil Nadu', '613001'),
(15, 'Prakash', 'T', 'Male', '1992-09-21', '9876543224', 'prakash.t@gmail.com', '25 West Street', 'Nagapattinam', 'Tamil Nadu', '611001'),
(16, 'Nisha', 'M', 'Female', '1999-12-01', '9876543225', 'nisha.m@gmail.com', '11 Church Road', 'Dindigul', 'Tamil Nadu', '624001'),
(17, 'Hari', 'V', 'Male', '1994-07-17', '9876543226', 'hari.v@gmail.com', '4 North Street', 'Virudhunagar', 'Tamil Nadu', '626001'),
(18, 'Revathi', 'P', 'Female', '1997-05-29', '9876543227', 'revathi.p@gmail.com', '16 School Road', 'Kanyakumari', 'Tamil Nadu', '629001'),
(19, 'Lokesh', 'G', 'Male', '1991-03-08', '9876543228', 'lokesh.g@gmail.com', '28 Beach Road', 'Thoothukudi', 'Tamil Nadu', '628001'),
(20, 'Keerthana', 'J', 'Female', '1998-11-19', '9876543229', 'keerthana.j@gmail.com', '6 Hill Road', 'Nilgiris', 'Tamil Nadu', '643001');	

select*from customer;

-- table 2

INSERT INTO InsuredVehicle
(VehicleID, PolicyHolderID, RegistrationNumber, ChassisNumber, EngineNumber, Brand, Model, ManufacturingYear, FuelType, VehicleCategory)
VALUES
(1,1,'TN01AB1001','CH1001','EN1001','Maruti','Swift',2022,'Petrol','Hatchback'),
(2,2,'TN02AB1002','CH1002','EN1002','Hyundai','i20',2021,'Petrol','Hatchback'),
(3,3,'TN03AB1003','CH1003','EN1003','Tata','Nexon',2023,'Diesel','SUV'),
(4,4,'TN04AB1004','CH1004','EN1004','Honda','City',2020,'Petrol','Sedan'),
(5,5,'TN05AB1005','CH1005','EN1005','Mahindra','XUV300',2022,'Diesel','SUV'),
(6,6,'TN06AB1006','CH1006','EN1006','Toyota','Innova',2021,'Diesel','MUV'),
(7,7,'TN07AB1007','CH1007','EN1007','Kia','Seltos',2023,'Petrol','SUV'),
(8,8,'TN08AB1008','CH1008','EN1008','Renault','Kwid',2022,'Petrol','Hatchback'),
(9,9,'TN09AB1009','CH1009','EN1009','Nissan','Magnite',2023,'Petrol','SUV'),
(10,10,'TN10AB1010','CH1010','EN1010','Skoda','Slavia',2022,'Petrol','Sedan'),
(11,11,'TN11AB1011','CH1011','EN1011','Volkswagen','Virtus',2023,'Petrol','Sedan'),
(12,12,'TN12AB1012','CH1012','EN1012','Hyundai','Creta',2021,'Diesel','SUV'),
(13,13,'TN13AB1013','CH1013','EN1013','Maruti','Baleno',2022,'Petrol','Hatchback'),
(14,14,'TN14AB1014','CH1014','EN1014','Tata','Punch',2023,'Petrol','SUV'),
(15,15,'TN15AB1015','CH1015','EN1015','Honda','Amaze',2020,'Petrol','Sedan'),
(16,16,'TN16AB1016','CH1016','EN1016','Toyota','Glanza',2022,'Petrol','Hatchback'),
(17,17,'TN17AB1017','CH1017','EN1017','Mahindra','Scorpio',2021,'Diesel','SUV'),
(18,18,'TN18AB1018','CH1018','EN1018','Kia','Sonet',2023,'Petrol','SUV'),
(19,19,'TN19AB1019','CH1019','EN1019','Hyundai','Venue',2022,'Diesel','SUV'),
(20,20,'TN20AB1020','CH1020','EN1020','Tata','Altroz',2023,'Petrol','Hatchback');	


--  table 3
INSERT INTO InsurancePolicy
(PolicyID, PolicyNumber, PolicyHolderID, VehicleID, PolicyType, StartDate, EndDate, SumInsured, PolicyStatus)
VALUES
(1,'IP2025001',1,1,'Comprehensive','2025-01-01','2025-12-31',500000.00,'Active'),
(2,'IP2025002',2,2,'Third Party','2025-01-05','2026-01-04',350000.00,'Active'),
(3,'IP2025003',3,3,'Own Damage','2025-01-10','2026-01-09',450000.00,'Active'),
(4,'IP2025004',4,4,'Comprehensive','2025-01-15','2026-01-14',600000.00,'Expired'),
(5,'IP2025005',5,5,'Third Party','2025-01-20','2026-01-19',400000.00,'Active'),
(6,'IP2025006',6,6,'Own Damage','2025-01-25','2026-01-24',550000.00,'Pending'),
(7,'IP2025007',7,7,'Comprehensive','2025-02-01','2026-01-31',700000.00,'Active'),
(8,'IP2025008',8,8,'Third Party','2025-02-05','2026-02-04',300000.00,'Active'),
(9,'IP2025009',9,9,'Own Damage','2025-02-10','2026-02-09',480000.00,'Expired'),
(10,'IP2025010',10,10,'Comprehensive','2025-02-15','2026-02-14',900000.00,'Active'),
(11,'IP2025011',11,11,'Third Party','2025-02-20','2026-02-19',375000.00,'Active'),
(12,'IP2025012',12,12,'Own Damage','2025-02-25','2026-02-24',520000.00,'Pending'),
(13,'IP2025013',13,13,'Comprehensive','2025-03-01','2026-02-28',800000.00,'Active'),
(14,'IP2025014',14,14,'Third Party','2025-03-05','2026-03-04',425000.00,'Expired'),
(15,'IP2025015',15,15,'Own Damage','2025-03-10','2026-03-09',600000.00,'Active'),
(16,'IP2025016',16,16,'Comprehensive','2025-03-15','2026-03-14',750000.00,'Active'),
(17,'IP2025017',17,17,'Third Party','2025-03-20','2026-03-19',390000.00,'Pending'),
(18,'IP2025018',18,18,'Own Damage','2025-03-25','2026-03-24',580000.00,'Active'),
(19,'IP2025019',19,19,'Comprehensive','2025-04-01','2026-03-31',850000.00,'Active'),
(20,'IP2025020',20,20,'Third Party','2025-04-05','2026-04-04',450000.00,'Expired');

select*from InsuranceProvider;



-- table 4

INSERT INTO InsuranceProvider
(ProviderID, ProviderName, Phone, Email, Address)
VALUES
(1, 'ICICI Lombard', '9876500001', 'support@icicilombard.com', 'Chennai, Tamil Nadu'),
(2, 'HDFC ERGO', '9876500002', 'care@hdfcergo.com', 'Coimbatore, Tamil Nadu'),
(3, 'Bajaj Allianz', '9876500003', 'support@bajajallianz.com', 'Madurai, Tamil Nadu'),
(4, 'Reliance General', '9876500004', 'care@reliancegeneral.co.in', 'Salem, Tamil Nadu'),
(5, 'IFFCO Tokio', '9876500005', 'support@iffcotokio.co.in', 'Trichy, Tamil Nadu'),
(6, 'SBI General', '9876500006', 'support@sbigeneral.in', 'Chennai, Tamil Nadu'),
(7, 'New India Assurance', '9876500007', 'support@newindia.co.in', 'Erode, Tamil Nadu'),
(8, 'United India Insurance', '9876500008', 'support@uiic.co.in', 'Coimbatore, Tamil Nadu'),
(9, 'Oriental Insurance', '9876500009', 'support@orientalinsurance.org.in', 'Vellore, Tamil Nadu'),
(10, 'National Insurance', '9876500010', 'support@nic.co.in', 'Madurai, Tamil Nadu'),
(11, 'TATA AIG', '9876500011', 'support@tataaig.com', 'Chennai, Tamil Nadu'),
(12, 'Go Digit', '9876500012', 'hello@godigit.com', 'Bangalore, Karnataka'),
(13, 'ACKO General Insurance', '9876500013', 'support@acko.com', 'Mumbai, Maharashtra'),
(14, 'Future Generali', '9876500014', 'care@futuregenerali.in', 'Hyderabad, Telangana'),
(15, 'Liberty General', '9876500015', 'care@libertyinsurance.in', 'New Delhi'),
(16, 'Kotak General Insurance', '9876500016', 'care@kotakgeneral.com', 'Pune, Maharashtra'),
(17, 'Royal Sundaram', '9876500017', 'support@royalsundaram.in', 'Chennai, Tamil Nadu'),
(18, 'Cholamandalam MS', '9876500018', 'customercare@cholams.murugappa.com', 'Chennai, Tamil Nadu'),
(19, 'Magma HDI', '9876500019', 'support@magmahdi.com', 'Kolkata, West Bengal'),
(20, 'Universal Sompo', '9876500020', 'support@universalsompo.com', 'Mumbai, Maharashtra');


-- table 5


INSERT INTO InsuranceAdvisor
(AdvisorID, AdvisorName, Phone, Email, BranchName, CommissionRate)
VALUES
(1,'Ramesh Kumar','9876501001','ramesh.kumar@advisor.com','Chennai',5.50),
(2,'Priya Sharma','9876501002','priya.sharma@advisor.com','Coimbatore',6.00),
(3,'Karthik Raj','9876501003','karthik.raj@advisor.com','Madurai',5.75),
(4,'Divya Lakshmi','9876501004','divya.lakshmi@advisor.com','Salem',6.25),
(5,'Vignesh Kumar','9876501005','vignesh.kumar@advisor.com','Trichy',5.80),
(6,'Anitha Devi','9876501006','anitha.devi@advisor.com','Erode',6.10),
(7,'Suresh Babu','9876501007','suresh.babu@advisor.com','Vellore',5.90),
(8,'Meena Rani','9876501008','meena.rani@advisor.com','Tiruppur',6.50),
(9,'Hari Prasad','9876501009','hari.prasad@advisor.com','Namakkal',5.60),
(10,'Kavitha S','9876501010','kavitha.s@advisor.com','Karur',6.00),
(11,'Arun Prakash','9876501011','arun.prakash@advisor.com','Dharmapuri',5.70),
(12,'Nisha Mary','9876501012','nisha.mary@advisor.com','Hosur',6.20),
(13,'Lokesh R','9876501013','lokesh.r@advisor.com','Cuddalore',5.95),
(14,'Deepa K','9876501014','deepa.k@advisor.com','Thanjavur',6.15),
(15,'Manoj Kumar','9876501015','manoj.kumar@advisor.com','Nagapattinam',5.85),
(16,'Revathi P','9876501016','revathi.p@advisor.com','Dindigul',6.30),
(17,'Prakash V','9876501017','prakash.v@advisor.com','Virudhunagar',5.65),
(18,'Keerthana J','9876501018','keerthana.j@advisor.com','Kanyakumari',6.40),
(19,'Ajith Kumar','9876501019','ajith.kumar@advisor.com','Thoothukudi',5.55),
(20,'Sneha R','9876501020','sneha.r@advisor.com','Nilgiris',6.50);


-- table 6
INSERT INTO PremiumDetails
(PremiumID, PolicyID, PremiumAmount, GSTAmount, DiscountAmount, TotalPremium, DueDate)
VALUES
(1,1,12000.00,2160.00,500.00,13660.00,'2025-01-10'),
(2,2,10000.00,1800.00,300.00,11500.00,'2025-01-15'),
(3,3,15000.00,2700.00,700.00,17000.00,'2025-01-20'),
(4,4,11000.00,1980.00,400.00,12580.00,'2025-01-25'),
(5,5,18000.00,3240.00,1000.00,20240.00,'2025-02-01'),
(6,6,9500.00,1710.00,200.00,11010.00,'2025-02-05'),
(7,7,20000.00,3600.00,1200.00,22400.00,'2025-02-10'),
(8,8,10500.00,1890.00,300.00,12090.00,'2025-02-15'),
(9,9,17000.00,3060.00,800.00,19260.00,'2025-02-20'),
(10,10,11500.00,2070.00,500.00,13070.00,'2025-02-25'),
(11,11,16000.00,2880.00,600.00,18280.00,'2025-03-01'),
(12,12,9800.00,1764.00,250.00,11314.00,'2025-03-05'),
(13,13,14500.00,2610.00,500.00,16610.00,'2025-03-10'),
(14,14,10800.00,1944.00,400.00,12344.00,'2025-03-15'),
(15,15,17500.00,3150.00,900.00,19750.00,'2025-03-20'),
(16,16,12500.00,2250.00,600.00,14150.00,'2025-03-25'),
(17,17,13200.00,2376.00,500.00,15076.00,'2025-04-01'),
(18,18,15500.00,2790.00,700.00,17590.00,'2025-04-05'),
(19,19,11800.00,2124.00,300.00,13624.00,'2025-04-10'),
(20,20,16500.00,2970.00,800.00,18670.00,'2025-04-15');


-- table  7

INSERT INTO PaymentHistory
(PaymentID, PremiumID, PaymentDate, PaymentMethod, PaidAmount, TransactionReference)
VALUES
(1,1,'2025-01-08','UPI',13660.00,'TXN100001'),
(2,2,'2025-01-13','Credit Card',11500.00,'TXN100002'),
(3,3,'2025-01-18','Net Banking',17000.00,'TXN100003'),
(4,4,'2025-01-22','Debit Card',12580.00,'TXN100004'),
(5,5,'2025-01-30','UPI',20240.00,'TXN100005'),
(6,6,'2025-02-03','Cash',11010.00,'TXN100006'),
(7,7,'2025-02-08','Credit Card',22400.00,'TXN100007'),
(8,8,'2025-02-12','UPI',12090.00,'TXN100008'),
(9,9,'2025-02-18','Net Banking',19260.00,'TXN100009'),
(10,10,'2025-02-23','Debit Card',13070.00,'TXN100010'),
(11,11,'2025-02-28','UPI',18280.00,'TXN100011'),
(12,12,'2025-03-03','Cash',11314.00,'TXN100012'),
(13,13,'2025-03-08','Credit Card',16610.00,'TXN100013'),
(14,14,'2025-03-13','UPI',12344.00,'TXN100014'),
(15,15,'2025-03-18','Net Banking',19750.00,'TXN100015'),
(16,16,'2025-03-23','Debit Card',14150.00,'TXN100016'),
(17,17,'2025-03-29','UPI',15076.00,'TXN100017'),
(18,18,'2025-04-03','Credit Card',17590.00,'TXN100018'),
(19,19,'2025-04-08','Cash',13624.00,'TXN100019'),
(20,20,'2025-04-13','Net Banking',18670.00,'TXN100020');

select*from paymenthistory;


-- table 8

INSERT INTO ClaimRequest
(ClaimID, PolicyID, ClaimDate, ClaimedAmount, ApprovedAmount, ClaimStatus, ClaimReason)
VALUES
(1,1,'2025-01-15',25000.00,22000.00,'Approved','Minor accident'),
(2,2,'2025-01-20',18000.00,18000.00,'Approved','Windshield damage'),
(3,3,'2025-01-25',45000.00,40000.00,'Approved','Front bumper damage'),
(4,4,'2025-02-01',30000.00,0.00,'Rejected','Policy expired'),
(5,5,'2025-02-05',55000.00,50000.00,'Approved','Engine damage'),
(6,6,'2025-02-10',20000.00,18000.00,'Approved','Tyre damage'),
(7,7,'2025-02-15',60000.00,55000.00,'Approved','Major accident'),
(8,8,'2025-02-20',15000.00,0.00,'Pending','Glass replacement'),
(9,9,'2025-02-25',35000.00,30000.00,'Approved','Door damage'),
(10,10,'2025-03-01',22000.00,20000.00,'Approved','Rear bumper damage'),
(11,11,'2025-03-05',40000.00,36000.00,'Approved','Flood damage'),
(12,12,'2025-03-10',28000.00,0.00,'Pending','Electrical issue'),
(13,13,'2025-03-15',50000.00,45000.00,'Approved','Accident repair'),
(14,14,'2025-03-20',32000.00,30000.00,'Approved','Headlight damage'),
(15,15,'2025-03-25',47000.00,42000.00,'Approved','Engine repair'),
(16,16,'2025-04-01',26000.00,25000.00,'Approved','Mirror replacement'),
(17,17,'2025-04-05',38000.00,0.00,'Rejected','Invalid documents'),
(18,18,'2025-04-10',42000.00,39000.00,'Approved','Accident repair'),
(19,19,'2025-04-15',31000.00,30000.00,'Approved','Side panel damage'),
(20,20,'2025-04-20',45000.00,43000.00,'Approved','Total body repair');

select*from AccidentReport;

-- table 9

INSERT INTO AccidentReport
(ReportID, ClaimID, AccidentDate, AccidentLocation, ReportDetails, FIRNumber)
VALUES
(1,1,'2025-01-14','Chennai','Rear-end collision','FIR1001'),
(2,2,'2025-01-19','Coimbatore','Stone hit windshield','FIR1002'),
(3,3,'2025-01-24','Madurai','Front collision','FIR1003'),
(4,4,'2025-01-30','Salem','Minor accident','FIR1004'),
(5,5,'2025-02-04','Erode','Engine submerged in water','FIR1005'),
(6,6,'2025-02-09','Trichy','Tyre burst','FIR1006'),
(7,7,'2025-02-14','Vellore','Highway accident','FIR1007'),
(8,8,'2025-02-19','Tiruppur','Glass broken','FIR1008'),
(9,9,'2025-02-24','Namakkal','Side collision','FIR1009'),
(10,10,'2025-02-28','Karur','Rear impact','FIR1010'),
(11,11,'2025-03-04','Dharmapuri','Flood affected','FIR1011'),
(12,12,'2025-03-09','Hosur','Electrical short circuit','FIR1012'),
(13,13,'2025-03-14','Cuddalore','Vehicle overturned','FIR1013'),
(14,14,'2025-03-19','Thanjavur','Headlight broken','FIR1014'),
(15,15,'2025-03-24','Nagapattinam','Engine overheating','FIR1015'),
(16,16,'2025-03-31','Dindigul','Mirror broken','FIR1016'),
(17,17,'2025-04-04','Virudhunagar','Document mismatch','FIR1017'),
(18,18,'2025-04-09','Kanyakumari','Road accident','FIR1018'),
(19,19,'2025-04-14','Thoothukudi','Side damage','FIR1019'),
(20,20,'2025-04-19','Nilgiris','Full body damage','FIR1020');


-- table 10
INSERT INTO VehicleInspection
(InspectionID, VehicleID, InspectorName, InspectionDate, InspectionResult, Remarks)
VALUES
(1,1,'Ravi Kumar','2025-01-05','Passed','Vehicle in good condition'),
(2,2,'Suresh Babu','2025-01-10','Passed','No issues found'),
(3,3,'Arun Raj','2025-01-15','Passed','Minor scratches'),
(4,4,'Karthik M','2025-01-20','Failed','Brake issue'),
(5,5,'Priya S','2025-01-25','Passed','Excellent condition'),
(6,6,'Manoj Kumar','2025-02-01','Passed','Tyres replaced'),
(7,7,'Deepak R','2025-02-05','Passed','Engine checked'),
(8,8,'Anitha V','2025-02-10','Failed','Windshield crack'),
(9,9,'Lokesh P','2025-02-15','Passed','Good condition'),
(10,10,'Hari Kumar','2025-02-20','Passed','All systems OK'),
(11,11,'Nisha R','2025-02-25','Passed','Minor dent'),
(12,12,'Vignesh S','2025-03-01','Failed','Electrical issue'),
(13,13,'Prakash T','2025-03-05','Passed','Roadworthy'),
(14,14,'Meena Devi','2025-03-10','Passed','Excellent'),
(15,15,'Ajith Kumar','2025-03-15','Passed','Engine serviced'),
(16,16,'Divya R','2025-03-20','Passed','Good condition'),
(17,17,'Keerthana M','2025-03-25','Failed','Suspension issue'),
(18,18,'Saravanan P','2025-04-01','Passed','Inspection completed'),
(19,19,'Revathi K','2025-04-05','Passed','Minor paint damage'),
(20,20,'Gokul N','2025-04-10','Passed','Vehicle approved');


-- table 11

INSERT INTO PolicyRenewal
(RenewalID, PolicyID, RenewalDate, NewExpiryDate, RenewalPremium, RenewalStatus)
VALUES
(1,1,'2025-12-20','2026-12-31',14000.00,'Completed'),
(2,2,'2025-12-22','2026-01-04',11800.00,'Completed'),
(3,3,'2025-12-25','2026-01-09',17200.00,'Completed'),
(4,4,'2025-12-28','2026-01-14',12700.00,'Pending'),
(5,5,'2026-01-02','2027-01-19',20500.00,'Completed'),
(6,6,'2026-01-05','2027-01-24',11200.00,'Completed'),
(7,7,'2026-01-10','2027-01-31',22600.00,'Pending'),
(8,8,'2026-01-15','2027-02-04',12200.00,'Completed'),
(9,9,'2026-01-20','2027-02-09',19400.00,'Completed'),
(10,10,'2026-01-25','2027-02-14',13200.00,'Completed'),
(11,11,'2026-02-01','2027-02-19',18400.00,'Pending'),
(12,12,'2026-02-05','2027-02-24',11500.00,'Completed'),
(13,13,'2026-02-10','2027-02-28',16800.00,'Completed'),
(14,14,'2026-02-15','2027-03-04',12500.00,'Pending'),
(15,15,'2026-02-20','2027-03-09',19900.00,'Completed'),
(16,16,'2026-02-25','2027-03-14',14300.00,'Completed'),
(17,17,'2026-03-01','2027-03-19',15200.00,'Pending'),
(18,18,'2026-03-05','2027-03-24',17700.00,'Completed'),
(19,19,'2026-03-10','2027-03-31',13800.00,'Completed'),
(20,20,'2026-03-15','2027-04-04',18900.00,'Completed');


-- table 12

INSERT INTO Beneficiary
(BeneficiaryID, PolicyHolderID, BeneficiaryName, Relationship, ContactNumber)
VALUES
(1,1,'Lakshmi Kumar','Wife','9876600001'),
(2,2,'Ramesh Raman','Father','9876600002'),
(3,3,'Priya Raj','Wife','9876600003'),
(4,4,'Suresh M','Brother','9876600004'),
(5,5,'Meena Vijay','Wife','9876600005'),
(6,6,'Karthik K','Husband','9876600006'),
(7,7,'Anitha Prasad','Wife','9876600007'),
(8,8,'Ravi R','Father','9876600008'),
(9,9,'Divya Kumar','Wife','9876600009'),
(10,10,'Bala G','Brother','9876600010'),
(11,11,'Revathi N','Wife','9876600011'),
(12,12,'Mohan D','Father','9876600012'),
(13,13,'Deepa S','Wife','9876600013'),
(14,14,'Selvi L','Mother','9876600014'),
(15,15,'Keerthana T','Wife','9876600015'),
(16,16,'Arun M','Brother','9876600016'),
(17,17,'Nisha V','Wife','9876600017'),
(18,18,'Hari P','Father','9876600018'),
(19,19,'Kavya G','Wife','9876600019'),
(20,20,'Prakash J','Brother','9876600020');



-- value 13

-- Insert 20 values into BranchOffice
INSERT INTO BranchOffice (BranchName, City, State, Phone)
VALUES
('Central Branch', 'Chennai', 'Tamil Nadu', '9876543210'),
('North Branch', 'Bengaluru', 'Karnataka', '9876543211'),
('South Branch', 'Hyderabad', 'Telangana', '9876543212'),
('East Branch', 'Kolkata', 'West Bengal', '9876543213'),
('West Branch', 'Mumbai', 'Maharashtra', '9876543214'),
('City Branch', 'Coimbatore', 'Tamil Nadu', '9876543215'),
('Metro Branch', 'Pune', 'Maharashtra', '9876543216'),
('Lake Branch', 'Bhopal', 'Madhya Pradesh', '9876543217'),
('Capital Branch', 'New Delhi', 'Delhi', '9876543218'),
('Garden Branch', 'Mysuru', 'Karnataka', '9876543219'),
('Hill Branch', 'Shimla', 'Himachal Pradesh', '9876543220'),
('River Branch', 'Patna', 'Bihar', '9876543221'),
('Beach Branch', 'Visakhapatnam', 'Andhra Pradesh', '9876543222'),
('Temple Branch', 'Madurai', 'Tamil Nadu', '9876543223'),
('Industrial Branch', 'Surat', 'Gujarat', '9876543224'),
('Heritage Branch', 'Jaipur', 'Rajasthan', '9876543225'),
('IT Branch', 'Noida', 'Uttar Pradesh', '9876543226'),
('Business Branch', 'Ahmedabad', 'Gujarat', '9876543227'),
('Port Branch', 'Kochi', 'Kerala', '9876543228'),
('Valley Branch', 'Srinagar', 'Jammu & Kashmir', '9876543229');
 
 use motor;
-- Insert 20 values into PolicyAssignment
INSERT INTO PolicyAssignment (PolicyID, AdvisorID, AssignedDate)
VALUES
(1, 1, '2025-01-10'),
(2, 2, '2025-01-15'),
(3, 3, '2025-01-20'),
(4, 4, '2025-01-25'),
(5, 5, '2025-02-01'),
(6, 6, '2025-02-05'),
(7, 7, '2025-02-10'),
(8, 8, '2025-02-15'),
(9, 9, '2025-02-20'),
(10, 10, '2025-02-25'),
(11, 11, '2025-03-01'),
(12, 12, '2025-03-05'),
(13, 13, '2025-03-10'),
(14, 14, '2025-03-15'),
(15, 15, '2025-03-20'),
(16, 16, '2025-03-25'),
(17, 17, '2025-04-01'),
(18, 18, '2025-04-05'),
(19, 19, '2025-04-10'),
(20, 20, '2025-04-15');

-- Insert values into BranchOffice
INSERT INTO BranchOffice (BranchName, City, State, Phone)
VALUES
('Central Branch', 'Chennai', 'Tamil Nadu', '9876543210'),
('North Branch', 'Coimbatore', 'Tamil Nadu', '9876543211'),
('South Branch', 'Madurai', 'Tamil Nadu', '9876543212'),
('East Branch', 'Tiruchirappalli', 'Tamil Nadu', '9876543213'),
('West Branch', 'Salem', 'Tamil Nadu', '9876543214'),
('City Branch', 'Bengaluru', 'Karnataka', '9876543215'),
('Metro Branch', 'Hyderabad', 'Telangana', '9876543216'),
('Capital Branch', 'New Delhi', 'Delhi', '9876543217'),
('Business Branch', 'Mumbai', 'Maharashtra', '9876543218'),
('Garden Branch', 'Mysuru', 'Karnataka', '9876543219'),
('Heritage Branch', 'Jaipur', 'Rajasthan', '9876543220'),
('Lake Branch', 'Bhopal', 'Madhya Pradesh', '9876543221'),
('Temple Branch', 'Thanjavur', 'Tamil Nadu', '9876543222'),
('Industrial Branch', 'Surat', 'Gujarat', '9876543223'),
('Beach Branch', 'Visakhapatnam', 'Andhra Pradesh', '9876543224'),
('Port Branch', 'Kochi', 'Kerala', '9876543225'),
('Hill Branch', 'Shimla', 'Himachal Pradesh', '9876543226'),
('River Branch', 'Patna', 'Bihar', '9876543227'),
('IT Branch', 'Noida', 'Uttar Pradesh', '9876543228'),
('Valley Branch', 'Srinagar', 'Jammu & Kashmir', '9876543229');

-- alter table

UPDATE Customer
SET Phone = '9999999999'
WHERE CustomerID = 1;

select*from customer;
UPDATE InsurancePolicy
SET PolicyStatus = 'Expired'
WHERE PolicyID = 5;  

-- delete
DELETE FROM Beneficiary
WHERE BeneficiaryID = 20;

-- alter table

ALTER TABLE Customer
ADD Occupation VARCHAR(50);

ALTER TABLE BranchOffice
ADD BranchManager VARCHAR(100);

-- where cluase
SELECT *
FROM Customer
WHERE City = 'Chennai';

SELECT *
FROM InsurancePolicy
WHERE PolicyStatus = 'Active';


-- orderby
SELECT *
FROM PremiumDetails
ORDER BY TotalPremium DESC;

SELECT *
FROM Customer
ORDER BY FirstName ASC;


-- distint
SELECT DISTINCT City
FROM Customer;

SELECT DISTINCT PolicyStatus
FROM InsurancePolicy;

-- Aggregate Function 

SELECT COUNT(*) AS TotalCustomers
FROM Customer;

SELECT SUM(TotalPremium)
FROM PremiumDetails;

SELECT AVG(TotalPremium)
FROM PremiumDetails;

SELECT MAX(SumInsured)
FROM InsurancePolicy;

SELECT MIN(PremiumAmount)
FROM PremiumDetails;

SELECT PolicyStatus, COUNT(*) AS Total
FROM InsurancePolicy
GROUP BY PolicyStatus;

SELECT PolicyStatus, COUNT(*);


SELECT *
FROM Customer
WHERE FirstName LIKE 'A%';


SELECT
c.FirstName,
c.LastName,
i.PolicyNumber
FROM Customer c
INNER JOIN InsurancePolicy i
ON c.CustomerID = i.PolicyHolderID;


SELECT
c.FirstName,
i.PolicyNumber
FROM Customer c
LEFT JOIN InsurancePolicy i
ON c.CustomerID = i.PolicyHolderID;


SELECT
c.FirstName,
i.PolicyNumber
FROM Customer c
RIGHT JOIN InsurancePolicy i
ON c.CustomerID = i.PolicyHolderID;
-- cross join

SELECT
Customer.FirstName,
BranchOffice.BranchName
FROM Customer
CROSS JOIN BranchOffice;

SELECT
A.CustomerID,
A.FirstName,
B.FirstName
FROM Customer A
JOIN Customer B
ON A.CustomerID<>B.CustomerID;


-- subquery

SELECT *
FROM InsurancePolicy
WHERE SumInsured >
(
SELECT AVG(SumInsured)
FROM InsurancePolicy
);


-- rollback
START TRANSACTION;
UPDATE Customer
SET Phone='8888888888'
WHERE CustomerID=2;
ROLLBACK;

SELECT PolicyStatus, COUNT(*) AS TotalPolicies
FROM InsurancePolicy
GROUP BY PolicyStatus
HAVING COUNT(*) >= 5;

SELECT PolicyStatus, COUNT(*) AS TotalPolicies
FROM InsurancePolicy
GROUP BY PolicyStatus
HAVING COUNT(*) >=6;


SELECT PolicyStatus, COUNT(*) AS TotalPolicies
FROM InsurancePolicy
GROUP BY PolicyStatus
HAVING COUNT(*)>=5;

SELECT *
FROM InsurancePolicy
WHERE SumInsured BETWEEN 400000 AND 700000;


SELECT *
FROM Customer
WHERE City IN ('Chennai','Salem','Coimbatore');
SELECT *
FROM PremiumDetails
WHERE TotalPremium BETWEEN 13000 AND 18000;

SELECT FirstName, LastName
FROM Customer c
WHERE EXISTS
(
SELECT *
FROM InsurancePolicy p
WHERE c.CustomerID=p.PolicyHolderID
);

SELECT PolicyNumber,

CASE

WHEN PolicyStatus='Active' THEN 'Policy Running'
WHEN PolicyStatus='Expired' THEN 'Renew Immediately'
ELSE 'Waiting'
END AS PolicyRemark
FROM InsurancePolicy;

CREATE VIEW ActivePolicyDetails AS

SELECT
PolicyNumber,
PolicyHolderID,
PolicyType,
SumInsured

FROM InsurancePolicy
WHERE PolicyStatus='Active';
SELECT * FROM ActivePolicyDetails;
CREATE INDEX idx_customer_city
ON Customer(City);

CREATE INDEX idx_policy_status
ON InsurancePolicy(PolicyStatus);
START TRANSACTION;

UPDATE Customer
SET Phone='9111111111'
WHERE CustomerID=4;

SAVEPOINT sp1;

UPDATE Customer
SET Phone='9222222222'
WHERE CustomerID=5;

COMMIT;

ALTER TABLE Customer
MODIFY FirstName VARCHAR(50) NOT NULL;

SELECT City
FROM Customer
UNION
SELECT City
FROM BranchOffice;

SELECT City
FROM Customer
UNION ALL
SELECT City
FROM BranchOffice;

SELECT *
FROM Customer
WHERE Occupation IS NULL;

SELECT *
FROM Customer
WHERE Email IS NOT NULL;

DELIMITER $$

CREATE PROCEDURE GetActivePolicies()

BEGIN

SELECT *
FROM InsurancePolicy
WHERE PolicyStatus='Active';

END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER BeforeInsertPremium

BEFORE INSERT

ON PremiumDetails

FOR EACH ROW

BEGIN

IF NEW.PremiumAmount<=0 THEN

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Premium Amount must be greater than Zero';

END IF;

END $$

DELIMITER ;
