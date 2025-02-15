CREATE SCHEMA lesson;

--  criação das tabelas
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


-- criando um curso
INSERT INTO lesson.course (course_id, name, total_credits, acronym_id) 
VALUES ('b0d1a107-5dd0-48c9-a19e-bf93c53608e5', 'Ciencia da Computação', 200, 'CC');

--criando os disciplinas
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

-- criando a depedencia entre as disciplinas
INSERT INTO lesson.subject_dependency (dependent_id, dependency_id)
VALUES ('e2214f3d-6509-48f0-a132-cb1ffb97eebc', '5c57b674-b3ef-40e4-a4fa-e89be1826c72');

INSERT INTO lesson.subject_dependency (dependent_id, dependency_id)
VALUES ('1c7fe57f-cb3d-4d5c-87f0-d9206d9dd9ad', '3b07f815-803c-4a1e-859a-676e1609923b');

INSERT INTO lesson.subject_dependency (dependent_id, dependency_id)
VALUES ('e66cd7d8-4223-4924-bdc9-85911b9e5410', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8');

INSERT INTO lesson.subject_dependency (dependent_id, dependency_id)
VALUES ('89b296d8-6cce-4784-a40a-03082c25cd7f', '41c5e531-3766-41aa-b129-191cf4b15d04');

INSERT INTO lesson.subject_dependency (dependent_id, dependency_id)
VALUES ('70ba8979-0767-4e43-9762-3ca7b8983f82', '565ffa32-2490-4ceb-b603-6e4727d961b9');

INSERT INTO lesson.subject_dependency (dependent_id, dependency_id)
VALUES ('4e59d4a2-4151-47c2-93f4-654a1b2c3d45', '6f81a312-8547-449f-8d4e-5f13f2a9c1e4');

-- criando as turmas
INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('6753b227-769f-4bcd-ba35-c9987c333bba', '01G', 40, '1', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', '01D', 40, '1', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('fd1ff062-e4d6-47ad-a02c-0cba75e0f262', '02G', 40, '2', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', '03G', 40, '3', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('ce04e642-6a6e-441f-88ae-4001ff1b6b4f', '03D', 40, '3', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('98d6e21c-8364-4ce7-b8b8-e6c6440da916', '04G', 40, '4', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('0c9bdbce-8409-479e-918b-4824baa8420f', '05G', 40, '5', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('7298c9dd-6286-4240-bd5b-73f3a04ffaeb', '05D', 40, '5', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('d89f360b-c2b2-49b8-a457-8a49f504f5d5', '06G', 40, '6', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('90e21056-e725-4bfc-950f-d7a1e7d6b138', '07G', 40, '7', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('3aab5eea-9ecf-4f91-b1f1-306f33157e75', '08G', 40, '8', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('22fc9f8c-4662-431b-ae29-323aeaf4af28', '01N', 40, '1', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('9114de5d-6b48-410d-ad0a-a5449fe9946d', '01P', 40, '1', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('6d3f3838-da40-45da-b616-d4cac61a94d4', '02N', 40, '2', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('51d0e0b4-7639-4366-9ad0-5ce64c14ace6', '03N', 40, '3', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('cbfa50dc-76b4-4946-a10e-79319bf65155', '03P', 40, '3', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('47737e4a-1d56-457a-b89d-49b9f3600a94', '04N', 40, '4', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('cd2ed283-8c56-44c1-befe-9a3cf5738378', '05N', 40, '5', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('834ea7fa-6558-4957-bf3c-b1974d50a680', '05P', 40, '5', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('cc665ac5-861e-4af2-adf6-86b71732db91', '06N', 40, '6', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('6b484df1-a447-4711-ad51-39a2d42996db', '07N', 40, '7', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id)
VALUES ('0e843c90-1a52-4f13-b41e-c6aa117f49d1', '08N', 40, '8', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');

-- crearing lesson dates

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('87ac39c0-78b0-4029-b53b-b1a7082f695e', '3b07f815-803c-4a1e-859a-676e1609923b', '6753b227-769f-4bcd-ba35-c9987c333bba', 'saturday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('7a1a8e90-2abe-4fdf-9442-905f4d0892d5', '3b07f815-803c-4a1e-859a-676e1609923b', '6753b227-769f-4bcd-ba35-c9987c333bba', 'saturday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('e91b6a18-5486-43d7-9c47-cdc51d32df3a', '3b07f815-803c-4a1e-859a-676e1609923b', '6753b227-769f-4bcd-ba35-c9987c333bba', 'tuesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b366fe99-4855-48ad-a8d3-4e847e75836e', '3b07f815-803c-4a1e-859a-676e1609923b', '6753b227-769f-4bcd-ba35-c9987c333bba', 'tuesday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('12b28dfd-52e9-40d2-8914-22ae8b08fc6c', '79801de9-5275-48d5-b528-468e89eea314', '6753b227-769f-4bcd-ba35-c9987c333bba', 'saturday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('ad8ad091-7b81-4cb6-b088-1bd1cb502dbb', '79801de9-5275-48d5-b528-468e89eea314', '6753b227-769f-4bcd-ba35-c9987c333bba', 'saturday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('ecf4b10e-ed40-4abb-8c09-cd8cfb65e559', '79801de9-5275-48d5-b528-468e89eea314', '6753b227-769f-4bcd-ba35-c9987c333bba', 'thursday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('f255f514-781c-44ff-ad81-3818bd5cd05d', '79801de9-5275-48d5-b528-468e89eea314', '6753b227-769f-4bcd-ba35-c9987c333bba', 'thursday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('2cdac0ad-58ae-413a-b414-a09bcc7fc233', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '6753b227-769f-4bcd-ba35-c9987c333bba', 'tuesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('8ce6eb61-c648-444f-afb0-f226367f04cd', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '6753b227-769f-4bcd-ba35-c9987c333bba', 'tuesday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('4573fcd8-3ebd-4aad-98a4-96719f3d7a3a', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '6753b227-769f-4bcd-ba35-c9987c333bba', 'thursday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('eef10555-4f56-4c7c-a127-b672da607011', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '6753b227-769f-4bcd-ba35-c9987c333bba', 'thursday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('5749cc49-4a92-4528-b4d5-a8c469094108', '6cd67348-2aec-43c1-89da-cd67db66a57c', '6753b227-769f-4bcd-ba35-c9987c333bba', 'wednesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('f4d61d34-4269-4e73-bb21-1edf28686716', '6cd67348-2aec-43c1-89da-cd67db66a57c', '6753b227-769f-4bcd-ba35-c9987c333bba', 'wednesday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('71620a96-333e-45c9-901c-2886324d828e', 'ec75db55-606b-458f-8f75-7cd04bbc7263', '6753b227-769f-4bcd-ba35-c9987c333bba', 'wednesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('284f26ce-a924-45f8-a761-5689bafe7f89', 'ec75db55-606b-458f-8f75-7cd04bbc7263', '6753b227-769f-4bcd-ba35-c9987c333bba', 'wednesday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('777fc248-6585-4c6c-bdeb-f0b84f42e0d3', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '6753b227-769f-4bcd-ba35-c9987c333bba', 'friday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('050fe193-b38b-4502-9610-5ab12d2b3e20', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '6753b227-769f-4bcd-ba35-c9987c333bba', 'friday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b9c5c4f1-79d0-4567-a20c-0958e6a94ea9', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '6753b227-769f-4bcd-ba35-c9987c333bba', 'friday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('c20b66ba-66ed-457d-b010-8693dcaec625', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '6753b227-769f-4bcd-ba35-c9987c333bba', 'friday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('f18b0d72-42bd-4a8b-b7a8-4077f593ed8a', 'ec75db55-606b-458f-8f75-7cd04bbc7263', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'saturday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('3154d4ba-5b6f-469c-b201-44daaed48ad2', 'ec75db55-606b-458f-8f75-7cd04bbc7263', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'saturday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d797cae1-ff13-4931-9475-d15601861427', '3b07f815-803c-4a1e-859a-676e1609923b', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'saturday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('80521aad-c946-458a-a764-b63a1f7c223a', '3b07f815-803c-4a1e-859a-676e1609923b', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'saturday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('88e8ebd2-b4dd-4a1a-9bde-14ddf7bb1aa9', '3b07f815-803c-4a1e-859a-676e1609923b', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'wednesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b2056c7e-c47c-4ca2-8a82-39436f5a40b6', '3b07f815-803c-4a1e-859a-676e1609923b', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'wednesday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('578c924d-f610-4d34-a534-fba1cf31344d', '79801de9-5275-48d5-b528-468e89eea314', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'tuesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('2274b53d-04e2-4231-babb-e72a1ccac680', '79801de9-5275-48d5-b528-468e89eea314', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'tuesday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('9f64bdc1-6018-49b2-9a20-97a5c072d2df', '79801de9-5275-48d5-b528-468e89eea314', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'thursday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('fdac2929-8df5-4a96-8256-f9fd172cd4a1', '79801de9-5275-48d5-b528-468e89eea314', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'thursday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('48ddbd96-ec5d-4e5b-bf5c-c7c7fe055626', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'tuesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('65e13997-317f-4e3e-981e-805504f471ff', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'tuesday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('48ed4de5-89e7-41a6-896a-97de4da02721', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'friday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('1263f1ee-5b22-4f73-b6d3-8562905958a1', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'friday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('283bccf7-1f69-4bf4-be14-e8cba260721f', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'wednesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('84a2a17f-0664-4b5d-88b8-ca05b080a470', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'wednesday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('e79f9fd3-6b68-4236-9c33-bb406809e359', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'friday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6be6a55e-3c49-4b14-b862-946dc708687a', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'friday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('db532d66-c8db-4561-8c62-b07e411bc7c2', '6cd67348-2aec-43c1-89da-cd67db66a57c', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'wednesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b7c5a0b0-a5a5-4b09-a772-d2e0bbd30f9e', '6cd67348-2aec-43c1-89da-cd67db66a57c', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463', 'wednesday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('44598ff8-96bc-496b-b64b-23403778a782', 'bbdf71da-53d7-4ac3-8bcf-aea96db95d98', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'saturday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('c94e36ca-bffa-46df-b9bb-0518a1d76f98', 'bbdf71da-53d7-4ac3-8bcf-aea96db95d98', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'saturday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('3efb56e7-1d4c-4f2a-a37b-e96a91652c38', 'bbdf71da-53d7-4ac3-8bcf-aea96db95d98', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'wednesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('9b09bc03-01b8-4525-aaee-6ccb8decd15f', 'bbdf71da-53d7-4ac3-8bcf-aea96db95d98', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'wednesday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('8c5cfe62-5c15-4bac-ae8f-c923fcd41fe8', '0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'saturday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('c720dc62-f091-4295-ba21-38b0341c9e20', '0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'saturday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('5b712d8e-eb19-43a8-b95c-a61518c6e730', '0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'tuesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('dc2014eb-53eb-4305-9e53-e54edb7d4f49', '0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'tuesday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('bbf646dd-965c-41ac-af97-e396940b0cf3', '0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'wednesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('16718e74-14b4-4c9b-8acf-09de43793b65', '0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'wednesday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('172e0c2c-af26-469f-88bb-ea016114422d', 'e2214f3d-6509-48f0-a132-cb1ffb97eebc', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'tuesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('36d9f63e-31a9-4e67-9a93-5b1156233099', 'e2214f3d-6509-48f0-a132-cb1ffb97eebc', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'tuesday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('45107822-e727-4bc3-9248-8c27d258ecf3', 'e2214f3d-6509-48f0-a132-cb1ffb97eebc', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'friday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('80d02c23-5a7c-4de8-8831-e369e912025d', 'e2214f3d-6509-48f0-a132-cb1ffb97eebc', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'friday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('c759724c-bd06-4723-af98-7e568ecd1828', '1c7fe57f-cb3d-4d5c-87f0-d9206d9dd9ad', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'wednesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b7305471-ab2c-461f-91ef-d255f8e8f56e', '1c7fe57f-cb3d-4d5c-87f0-d9206d9dd9ad', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'wednesday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('bae74346-a567-4cb2-bf8f-a797621edce3', '1c7fe57f-cb3d-4d5c-87f0-d9206d9dd9ad', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'friday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('44143eb9-6dde-4f9b-ba78-5175d51b976d', '1c7fe57f-cb3d-4d5c-87f0-d9206d9dd9ad', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'friday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('2a57d2fe-3376-464c-b4a8-8e5cfe3d5174', 'cbe5cc3c-ce54-4afa-a561-a025209d9477', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'thursday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('61f24589-ed40-46fb-b6b0-6a7fdf37d172', 'cbe5cc3c-ce54-4afa-a561-a025209d9477', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262', 'thursday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b6e17e80-77b8-428f-947f-bc8195ff3863', '41c5e531-3766-41aa-b129-191cf4b15d04', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'saturday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('5d7cf245-d388-471f-9d84-ea1e6008d2fd', '41c5e531-3766-41aa-b129-191cf4b15d04', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'saturday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6eb06d34-ed78-4441-8bf6-9412ad8970be', '41c5e531-3766-41aa-b129-191cf4b15d04', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'wednesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('3c7e8e06-c57d-4212-a867-16cff7d7b4c8', '41c5e531-3766-41aa-b129-191cf4b15d04', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'wednesday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('62501182-c613-4d92-bfc6-c7dd648f70c2', '85de1e36-b258-4c15-81a5-6f8f28e1f000', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'saturday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('1af0534b-f620-49d5-a339-8dfd4da2cbd0', '85de1e36-b258-4c15-81a5-6f8f28e1f000', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'saturday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('3156fdfe-effa-41f2-8f38-6e5f02497c16', '85de1e36-b258-4c15-81a5-6f8f28e1f000', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'thursday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b3e9e987-bcd3-454b-b562-7c3c2895ce26', '85de1e36-b258-4c15-81a5-6f8f28e1f000', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'thursday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b30184c3-78ed-468a-a883-8313e74f7762', 'd0e6410b-56d2-4cb3-9dd4-1b656c14fc7c', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'tuesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('dfcd28d6-606f-497e-baa4-c22e81fd84d0', 'd0e6410b-56d2-4cb3-9dd4-1b656c14fc7c', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'tuesday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('81e78d07-0a58-45c9-a759-fe58f2512baf', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'tuesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('ed37af20-c1d0-4303-8edc-24532c38653e', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'tuesday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('efa38277-050c-4c4c-9f71-18a317a9549f', '565ffa32-2490-4ceb-b603-6e4727d961b9', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'wednesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('27383698-991a-440e-b23b-d66ab1e0a23b', '565ffa32-2490-4ceb-b603-6e4727d961b9', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'wednesday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('7fc251f4-fd20-47fd-a9d9-35cb3f4f8161', '565ffa32-2490-4ceb-b603-6e4727d961b9', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'friday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('1d193f08-445a-4d07-a1f0-f18c36d849c3', '565ffa32-2490-4ceb-b603-6e4727d961b9', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575', 'friday', '08:20', '09:10');
