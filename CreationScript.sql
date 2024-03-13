DROP DATABASE IF  EXISTS YourDatabaseName;
DROP DATABASE IF  EXISTS MessageApp;
CREATE DATABASE IF NOT EXISTS MessageApp;

USE MessageApp;

CREATE TABLE Login (
    LoginId INT PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(255) NOT NULL,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    CreateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    DefaultLanguageId INT,
    LastLogin TIMESTAMP,
    LastLoginAttempt TIMESTAMP,
    LastAttemptCount INT,
    IsActive BOOLEAN
);

CREATE TABLE MessageThread (
    MessageThreadId INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE MessageThreadParticipant (
    LoginId INT,
    MessageThreadId INT,
    PRIMARY KEY (LoginId, MessageThreadId),
    FOREIGN KEY (LoginId) REFERENCES Login(LoginId),
    FOREIGN KEY (MessageThreadId) REFERENCES MessageThread(MessageThreadId)
);

CREATE TABLE Message (
    MessageId INT PRIMARY KEY AUTO_INCREMENT,
    MessageThreadId INT,
    SenderLoginId INT,
    Body TEXT,
    CreateDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (MessageThreadId) REFERENCES MessageThread(MessageThreadId),
    FOREIGN KEY (SenderLoginId) REFERENCES Login(LoginId)
);

CREATE TABLE MessageReadState (
    MessageId INT,
    LoginId INT,
    ReadDate TIMESTAMP,
    PRIMARY KEY (MessageId, LoginId),
    FOREIGN KEY (MessageId) REFERENCES Message(MessageId),
    FOREIGN KEY (LoginId) REFERENCES Login(LoginId)
);
