-- create the tables for the database
CREATE TABLE Checklist (
  ChecklistID        INT            PRIMARY KEY   IDENTITY,
  Name				 VARCHAR(30)
);

CREATE TABLE Users (
  UserID			INT            PRIMARY KEY   IDENTITY,
  Username			VARCHAR(25)    NOT NULL		 UNIQUE, 
  FName				NVARCHAR(20),
  Lname				NVARCHAR(20),
  pw				VARCHAR(100)
);

CREATE TABLE Users_Checklist (
  UserID			 INT            REFERENCES Users(UserID),
  ChecklistID        INT            REFERENCES Checklist (ChecklistID),
  PRIMARY KEY(UserID, ChecklistID)
);

CREATE TABLE Task (
  TaskID				INT            PRIMARY KEY  IDENTITY,
  ChecklistID			INT            REFERENCES Checklist (ChecklistID),
  Name					VARCHAR(40)    NOT NULL,
  Deadline				VARCHAR(15),
  DateCompleted			VARCHAR(15),
  IsRecurring			BIT
);

CREATE TABLE RecurringTask (
	TaskID				INT			REFERENCES Task(TaskID),
	Day					VARCHAR(10),
	Time				VARCHAR(10)
);

CREATE TABLE Change (
  ChangeID           INT            PRIMARY KEY  IDENTITY,
  ChecklistID        INT            REFERENCES Checklist (ChecklistID),
  UserID			 INT            REFERENCES Users (UserID),
  TaskID			 INT            REFERENCES Task (TaskID),
  Action             VARCHAR(21)	NOT NULL,
  Description	     VARCHAR(30),  
);

--Friendship is one-way, not mutual
CREATE TABLE Friends (
	UserID		INT		REFERENCES Users(UserID),
	FriendID	INT		REFERENCES Users(UserID),
	PRIMARY KEY(UserID, FriendID)
);

--This is to let users leave a ~50 character note on other people's profile,
--only visible to the person who created the note
--CREATE TABLE Notes (
--	UserID		INT		REFERENCES Users(UserID),
--	VictimID	INT		REFERENCES Users(UserID),
--	PRIMARY KEY(UserID, VictimID),
--	Note		VARCHAR(50)
--);

--CREATE TABLE Groups (
--	GroupID		INT		PRIMARY KEY		IDENTITY,
--	Name		VARCHAR(30)
--);

--CREATE TABLE Group_Users (
--	GroupID		INT		REFERENCES Groups(GroupID),
--	UserID		INT		REFERENCES Users(UserID),
--	PRIMARY KEY(GroupID, UserID)
--);

--This will make the primary key for users start at 100M
--This is done to make sure there are no issues with the composite pk for user_checklist
DBCC checkident ('Users', reseed, 100000000);
