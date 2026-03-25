USE MochiVocab;
GO


CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    avatar_url NVARCHAR(MAX),
    login_method VARCHAR(50) DEFAULT 'Email', 
    activation_date DATETIME DEFAULT GETDATE(),
    account_type VARCHAR(20) DEFAULT 'Free', 
    premium_expiration_date DATETIME NULL
);


CREATE TABLE User_Preferences (
    user_id INT PRIMARY KEY,
    display_language VARCHAR(20) DEFAULT 'vi',
    dark_mode BIT DEFAULT 0,
    sound_effects BIT DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);


CREATE TABLE Courses (
    course_id INT IDENTITY(1,1) PRIMARY KEY,
    course_name NVARCHAR(200) NOT NULL,
    access_condition VARCHAR(20) DEFAULT 'Free' 
);

-- 4. BẢNG TỪ VỰNG (VOCABULARY)
CREATE TABLE Vocabularies (
    vocab_id INT IDENTITY(1,1) PRIMARY KEY,
    word NVARCHAR(100) NOT NULL,
    vietnamese_meaning NVARCHAR(MAX) NOT NULL,
    phonetic_transcription NVARCHAR(100),
    audio_url NVARCHAR(MAX),
    image_url NVARCHAR(MAX),
    example_sentence NVARCHAR(MAX),
    synonyms NVARCHAR(MAX),
    antonyms NVARCHAR(MAX)
);


CREATE TABLE User_Course (
    user_id INT,
    course_id INT,
    enrollment_date DATETIME DEFAULT GETDATE(),
    progress_percentage DECIMAL(5,2) DEFAULT 0.00,
    PRIMARY KEY (user_id, course_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);


CREATE TABLE Course_Vocabulary (
    course_id INT,
    vocab_id INT,
    PRIMARY KEY (course_id, vocab_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
    FOREIGN KEY (vocab_id) REFERENCES Vocabularies(vocab_id) ON DELETE CASCADE
);


CREATE TABLE User_Vocab_Tracking (
    user_id INT,
    vocab_id INT,
    source VARCHAR(50) DEFAULT 'Course', 
    learning_status VARCHAR(20) DEFAULT 'Learning', 
    memory_level INT DEFAULT 1, 
    next_review_time DATETIME NULL, 
    last_updated DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (user_id, vocab_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (vocab_id) REFERENCES Vocabularies(vocab_id) ON DELETE CASCADE
);
