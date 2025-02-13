CREATE SCHEMA lesson;

CREATE TABLE lesson.course (
    course_id UUID PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    total_credits INT NOT NULL,
    acronym_id VARCHAR(5) NOT NULL
);

CREATE TYPE lesson.semester AS ENUM ('1', '2', '3', '4', '5', '6', '7', '8');

CREATE TABLE lesson.subject (
    subject_id UUID NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    credit INT NOT NULL,
    semester lesson.semester NOT NULL,
    course_id UUID NOT NULL,
    FOREIGN KEY (course_id) REFERENCES lesson.course(course_id)  
);

CREATE TABLE lesson.student (
    student_id VARCHAR(8) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    course_id UUID NOT NULL,
    FOREIGN KEY (course_id) REFERENCES lesson.course(course_id) 
);

CREATE TABLE lesson.subject_graduated_students (
    subject_id UUID NOT NULL,
    student_id VARCHAR(100) NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES lesson.subject(subject_id),
    FOREIGN KEY (student_id) REFERENCES lesson.student(student_id),
    PRIMARY KEY (subject_id, student_id)
);

CREATE TABLE lesson.classroom (
    classroom_id UUID PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    capacity INT NOT NULL,
    semester lesson.semester NOT NULL,
    course_id UUID NOT NULL,
    FOREIGN KEY (course_id) REFERENCES lesson.course(course_id)
);

CREATE TYPE lesson.week_day AS ENUM (
    'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'
);

CREATE TABLE lesson.lesson (
    subject_id UUID NOT NULL,
    classroom_id UUID NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES lesson.subject(subject_id),
    FOREIGN KEY (classroom_id) REFERENCES lesson.classroom(classroom_id),
    PRIMARY KEY (subject_id, classroom_id)
);

CREATE TABLE lesson.lesson_date (
    lesson_date_id UUID NOT NULL PRIMARY KEY,
    subject_id UUID NOT NULL,
    classroom_id UUID NOT NULL,
    week_day lesson.week_day NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    FOREIGN KEY (subject_id, classroom_id) REFERENCES lesson.lesson(subject_id, classroom_id)
);

CREATE TABLE lesson.student_subject_enrollment (
    subject_id UUID NOT NULL,
    classroom_id UUID NOT NULL,
    student_id VARCHAR(100) NOT NULL,
    FOREIGN KEY (subject_id, classroom_id) REFERENCES lesson.lesson(subject_id, classroom_id),
    FOREIGN KEY (student_id) REFERENCES lesson.student(student_id),
    PRIMARY KEY (subject_id, classroom_id, student_id)
);

CREATE TABLE lesson.subject_dependency (
    dependent_id UUID NOT NULL,
    dependency_id UUID NOT NULL,
    FOREIGN KEY (dependent_id) REFERENCES lesson.subject(subject_id),
    FOREIGN KEY (dependency_id) REFERENCES lesson.subject(subject_id),
    PRIMARY KEY (dependent_id, dependency_id)
);

INSERT INTO lesson.course (course_id, name, total_credits, acronym_id) 
VALUES ('b0d1a107-5dd0-48c9-a19e-bf93c53608e5', 'Ciencia da Computação', 200, 'CC');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('3b07f815-803c-4a1e-859a-676e1609923b', 'Matematica discreta I', 1, '1', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('5c57b674-b3ef-40e4-a4fa-e89be1826c72', 'Algoritmos e programação I', 1, '1', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('79801de9-5275-48d5-b528-468e89eea314', 'Circuitos elétricos e eletronicos', 1, '1', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('f2c5829c-e5ff-4965-866f-e13900d17cab', 'Fundamentos de ciência da computação', 1, '1', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('6cd67348-2aec-43c1-89da-cd67db66a57c', 'Ciencia, tecnologia e sociedade na matematica e na computação', 1, '1', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('ec75db55-606b-458f-8f75-7cd04bbc7263', 'Etica e cidadania', 1, '1', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('e2214f3d-6509-48f0-a132-cb1ffb97eebc', 'Algortimos e programação II', 1, '2', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', 'Analise de dados', 1, '2', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('bbdf71da-53d7-4ac3-8bcf-aea96db95d98', 'Algebra booleana e circuitos digitais', 1, '2', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('1c7fe57f-cb3d-4d5c-87f0-d9206d9dd9ad', 'Matematica discreta II', 1, '2', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('cbe5cc3c-ce54-4afa-a561-a025209d9477', 'Introdução a cosmovisão reformada', 1, '2', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('85de1e36-b258-4c15-81a5-6f8f28e1f000', 'Organização de computadores', 1, '3', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('41c5e531-3766-41aa-b129-191cf4b15d04', 'Projeto e analise de algoritmos I', 1, '3', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('6b3ff87e-eae6-4947-b121-1a359f8ab0d8', 'Estrutura de dados I', 1, '3', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('d0e6410b-56d2-4cb3-9dd4-1b656c14fc7c', 'Banco de dados', 1, '3', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('565ffa32-2490-4ceb-b603-6e4727d961b9', 'Modelagem matemática I', 1, '3', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('96b17e4b-0d92-4623-86c9-d04bc1221ad0', 'Sistemas operacionais', 1, '4', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('e66cd7d8-4223-4924-bdc9-85911b9e5410', 'Estrutura de dados II', 1, '4', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('1e6e62da-0c3f-4500-9e49-f9721ec79b17', 'Projeto de Software', 1, '4', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('89b296d8-6cce-4784-a40a-03082c25cd7f', 'Projeto e analise de algoritmos II', 1, '4', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('b0b6023f-3e95-44c4-985e-1dd372e35d0a', 'Algoritmos numericos', 1, '4', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('70ba8979-0767-4e43-9762-3ca7b8983f82', 'Modelagem matemática II', 1, '4', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', 'Engenharia de software', 1, '5', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('63ff2fbb-65ea-465d-acc4-5c07dc1ae563', 'Redes de computadores', 1, '5', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('56aa4c1c-61ea-466b-bd0d-8980b4ae25ce', 'Principios de empreendedorismo', 1, '5', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('73284f3c-7cc6-475b-b610-3bc05b448895', 'Linguagens formais e automatos', 1, '5', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('512d2c00-246e-470b-80a6-bb4616615c79', 'Computação paralela', 1, '5', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('288d4f0d-edaa-457f-b887-212edae5701b', 'Paradigmas de linguagens de programação', 1, '5', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('007c2e2d-249c-42f7-a67c-1645eac004b8', 'Laboratotio de engenharia de software', 2, '6', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('cee8cec0-d302-4c1f-8ed5-e9eb2206b6b7', 'Compiladores', 2, '6', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('d40158a7-5290-4b3a-b52b-f3ae282a33bc', 'Teoria dos grafos', 2, '6', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('88f39d91-ae9d-401a-9559-7d65899a6acb', 'Interação humano-computador', 2, '6', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('206b1ec1-e2f6-43b8-8541-3fa6b934c073', 'Computação distribuída', 2, '6', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('471f63c0-8de8-4b73-9552-09e7ab718870', 'Projetos empreendedores', 2, '6', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('e0d48d2c-e16a-4fdb-8f15-614425060520', 'Metodologia de pesquisa em computação', 2, '6', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('338dd044-8611-4f4f-8b4d-6a6b5b2a7f81', 'Inteligencia artificial', 2, '7', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('81dc9a03-7c48-4c3a-8a4e-3f14d8a2f155', 'Computação visual', 2, '7', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('9c0f5e3b-4321-4753-8f8f-4a7d6a1c2b34', 'Teoria da computação', 2, '7', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('6f81a312-8547-449f-8d4e-5f13f2a9c1e4', 'Trabalho de conclusão de curso I', 2, '7', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.subject (subject_id, name, credit, semester, course_id)
VALUES ('4e59d4a2-4151-47c2-93f4-654a1b2c3d45', 'Trabalho de conclusão de curso II', 2, '8', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');