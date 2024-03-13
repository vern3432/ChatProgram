
CREATE TABLE IF NOT EXISTS Login (
    LoginId INTEGER PRIMARY KEY AUTOINCREMENT,
    Email TEXT NOT NULL,
    Username TEXT NOT NULL,
    Password TEXT NOT NULL,
    CreateDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    DefaultLanguageId INTEGER,
    LastLogin DATETIME,
    LastLoginAttempt DATETIME,
    LastAttemptCount INTEGER,
    IsActive INTEGER
);

CREATE TABLE IF NOT EXISTS MessageThread (
    MessageThreadId INTEGER PRIMARY KEY AUTOINCREMENT
);

CREATE TABLE IF NOT EXISTS MessageThreadParticipant (
    LoginId INTEGER,
    MessageThreadId INTEGER,
    PRIMARY KEY (LoginId, MessageThreadId),
    FOREIGN KEY (LoginId) REFERENCES Login(LoginId),
    FOREIGN KEY (MessageThreadId) REFERENCES MessageThread(MessageThreadId)
);

CREATE TABLE IF NOT EXISTS Message (
    MessageId INTEGER PRIMARY KEY AUTOINCREMENT,
    MessageThreadId INTEGER,
    SenderLoginId INTEGER,
    Body TEXT,
    CreateDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (MessageThreadId) REFERENCES MessageThread(MessageThreadId),
    FOREIGN KEY (SenderLoginId) REFERENCES Login(LoginId)
);

CREATE TABLE IF NOT EXISTS MessageReadState (
    MessageId INTEGER,
    LoginId INTEGER,
    ReadDate DATETIME,
    PRIMARY KEY (MessageId, LoginId),
    FOREIGN KEY (MessageId) REFERENCES Message(MessageId),
    FOREIGN KEY (LoginId) REFERENCES Login(LoginId)
);
