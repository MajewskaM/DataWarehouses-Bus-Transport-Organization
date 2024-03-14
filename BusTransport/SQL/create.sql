--CREATE DATABASE RoutesTraveller;
USE RoutesTraveller;

CREATE TABLE Bus (
    RegistrationNumber VARCHAR(8) PRIMARY KEY CHECK(LEN(RegistrationNumber) >= 2),
    Type VARCHAR(9) NOT NULL CHECK (Type IN ('minibus',
	'standard', 'low floor'))
);

CREATE TABLE ROUTE (
    RouteNumber INT IDENTITY PRIMARY KEY,
    RouteName VARCHAR(30) NOT NULL,
    StartStop INT NOT NULL,
    EndStop INT NOT NULL
);

CREATE TABLE SCHEDULE (
    ScheduleID INT IDENTITY PRIMARY KEY,
    FK_Route INT REFERENCES ROUTE(RouteNumber) NOT NULL,
    ArrivalTime TIME NOT NULL,
    DepartureTime TIME NOT NULL,
    DayType VARCHAR(7) NOT NULL CHECK (DayType IN ('weekday', 'weekend', 'holiday'))
);

CREATE TABLE TICKET (
    TicketID INT IDENTITY PRIMARY KEY,
    -- to allow only letters (alphabet)
    Name VARCHAR(20) NOT NULL CHECK(LEN(Name) >= 2 AND Name NOT LIKE '%' +'[^A-Z]'+'%'),
    Surname VARCHAR(50) NOT NULL CHECK(LEN(Surname) >= 2),
    Email VARCHAR(40) NOT NULL CHECK (Email LIKE '%@%' AND LEN(Email) >= 2)
);


CREATE TABLE TRAVEL (
    TravelID INT IDENTITY PRIMARY KEY,
    FK_Bus VARCHAR(8) REFERENCES BUS(RegistrationNumber) NOT NULL,
    FK_Route INT REFERENCES ROUTE(RouteNumber) NOT NULL,
    FK_Schedule INT REFERENCES SCHEDULE(ScheduleID) NOT NULL,
    IssuedDate DATE NOT NULL,
    CHECK (IssuedDate >= '2018-01-01' AND IssuedDate <= '2050-01-01'),
);

CREATE TABLE VALIDATION (
    PRIMARY KEY (FK_Ticket, FK_Travel),
    FK_Ticket INT REFERENCES TICKET(TicketID) NOT NULL,
    FK_Travel INT REFERENCES TRAVEL(TravelID) NOT NULL
);

CREATE TABLE FEEDBACK (
    FeedbackID INT IDENTITY PRIMARY KEY,
    FK_Travel INT NOT NULL REFERENCES TRAVEL(TravelID),
    SatisfactionLevel INT NOT NULL CHECK (SatisfactionLevel BETWEEN 0 AND 10),
);
