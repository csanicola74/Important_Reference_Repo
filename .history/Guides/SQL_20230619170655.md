# SQL

```sql

-- Create table for Patient
CREATE TABLE Patient (
    patient_ID INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender CHAR(1),
    address VARCHAR(255)
);

-- Create table for Physician
CREATE TABLE Physician (
    physician_ID INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialty VARCHAR(100)
);

-- Create table for Surgery
CREATE TABLE Surgery (
    surgery_ID INT PRIMARY KEY,
    surgery_name VARCHAR(100),
    surgery_date DATE,
    patient_ID INT,
    physician_ID INT,
    FOREIGN KEY (patient_ID) REFERENCES Patient(patient_ID),
    FOREIGN KEY (physician_ID) REFERENCES Physician(physician_ID)
);

-- Create table for Consultation
CREATE TABLE Consultation (
    consultation_ID INT PRIMARY KEY,
    consultation_date DATE,
    patient_ID INT,
    physician_ID INT,
    consultation_notes TEXT,
    FOREIGN KEY (patient_ID) REFERENCES Patient(patient_ID),
    FOREIGN KEY (physician_ID) REFERENCES Physician(physician_ID)
);

-- Create table for PostOp
CREATE TABLE PostOp (
    postop_ID INT PRIMARY KEY,
    postop_date DATE,
    patient_ID INT,
    surgery_ID INT,
    postop_notes TEXT,
    FOREIGN KEY (patient_ID) REFERENCES Patient(patient_ID),
    FOREIGN KEY (surgery_ID) REFERENCES Surgery(surgery_ID)
);

```

In this example, each table is created with a primary key that uniquely identifies each record. The `Surgery`, `Consultation`, and `PostOp` tables also include foreign keys that link to the `Patient` and `Physician` tables, creating relationships between the tables. The `Surgery` table is also linked to the `PostOp` table via a foreign key. This allows for complex queries across multiple tables. For example, you could easily find all surgeries performed by a particular physician, or all post-op notes for a particular patient.
