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
    FOREIGN KEY (subject_id) REFERENCES lesson.subject(subject_id),
    FOREIGN KEY (classroom_id) REFERENCES lesson.classroom(classroom_id)
    -- FOREIGN KEY (subject_id, classroom_id) REFERENCES lesson.lesson(subject_id, classroom_id)
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


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('16d392b1-583c-4fa0-bec3-03bb9500563f', '85de1e36-b258-4c15-81a5-6f8f28e1f000', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'saturday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('492a537b-2ee8-4203-8167-f6096c8eeaf3', '85de1e36-b258-4c15-81a5-6f8f28e1f000', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'saturday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b2aab8bf-66f6-4bfc-aabd-68d3d1fe20e6', '85de1e36-b258-4c15-81a5-6f8f28e1f000', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'thursday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('f39ca330-5acb-432b-80bc-c896815e71b0', '85de1e36-b258-4c15-81a5-6f8f28e1f000', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'thursday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('89187dff-713c-4029-8543-e6c16e2bbbee', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'saturday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('8fdd6977-eead-4e63-8b30-f26d5e43f524', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'saturday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('8c644ee7-fae6-4f2c-9c8d-1bcfbeb2a758', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'friday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('764d1dbf-874d-487e-979d-1f1adb144612', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'friday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('5794624a-8349-49a9-b002-0adea090e3ad', '565ffa32-2490-4ceb-b603-6e4727d961b9', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'tuesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('fc790b9f-3556-4012-a8eb-04afd3baf338', '565ffa32-2490-4ceb-b603-6e4727d961b9', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'tuesday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('f3c9aa58-6424-4974-ad7c-ffbf3ca1218c', '565ffa32-2490-4ceb-b603-6e4727d961b9', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'wednesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('bfe4277f-1910-4609-9608-6085192a80f2', '565ffa32-2490-4ceb-b603-6e4727d961b9', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'wednesday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('4d3ea278-6b79-4704-947b-c15717c959d7', '41c5e531-3766-41aa-b129-191cf4b15d04', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'tuesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('9985c1e7-2a25-4ab5-9c7c-739f3e978626', '41c5e531-3766-41aa-b129-191cf4b15d04', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'tuesday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6142bc62-d57e-426d-993a-1131a00c48fe', '41c5e531-3766-41aa-b129-191cf4b15d04', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'friday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('893d8542-cb2c-438a-81ca-314aaa2355c2', '41c5e531-3766-41aa-b129-191cf4b15d04', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'friday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('685ecf14-df39-41b5-9fab-c44e3ba778c9', 'd0e6410b-56d2-4cb3-9dd4-1b656c14fc7c', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'wednesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('2c54a6c8-ffd7-4cc0-b9c5-b838b591af87', 'd0e6410b-56d2-4cb3-9dd4-1b656c14fc7c', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f', 'wednesday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('115b61b5-c6a9-465e-bdc8-4b44ae2f1b64', '70ba8979-0767-4e43-9762-3ca7b8983f82', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'saturday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('75ef0736-be49-4493-8232-96d26ba0e073', '70ba8979-0767-4e43-9762-3ca7b8983f82', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'saturday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('08b17028-03a7-4524-a9c0-630cb42cf136', '70ba8979-0767-4e43-9762-3ca7b8983f82', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'wednesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('1a6eeb29-d2f7-4f29-88d5-841bd807c8ea', '70ba8979-0767-4e43-9762-3ca7b8983f82', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'wednesday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('1bc9f998-eee6-4c3b-a1e8-a0dbdde8198b', 'e66cd7d8-4223-4924-bdc9-85911b9e5410', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'saturday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('c206b144-ce4e-4bf3-bef6-58fb46c94b4b', 'e66cd7d8-4223-4924-bdc9-85911b9e5410', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'saturday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('36144470-5ca1-4519-82b2-2a412ed568ef', 'e66cd7d8-4223-4924-bdc9-85911b9e5410', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'tuesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('2ffbcc2f-af20-44ca-8115-2235ebc59d58', 'e66cd7d8-4223-4924-bdc9-85911b9e5410', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'tuesday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('8ce6a69d-8308-4a73-8399-6c361d6c0908', '96b17e4b-0d92-4623-86c9-d04bc1221ad0', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'tuesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('69566c40-38dc-4952-b98a-5d8c34740e51', '96b17e4b-0d92-4623-86c9-d04bc1221ad0', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'tuesday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d99f999e-8169-46b5-830c-139e896e447f', '96b17e4b-0d92-4623-86c9-d04bc1221ad0', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'thursday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6e4ee6c4-2cbf-48fb-a8de-7f070e93c613', '96b17e4b-0d92-4623-86c9-d04bc1221ad0', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'thursday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b979f0ce-02cb-4d35-8ecd-2c576455502f', '1e6e62da-0c3f-4500-9e49-f9721ec79b17', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'wednesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('90f25aa7-cb52-4a79-acd2-13cf7a8cbccc', '1e6e62da-0c3f-4500-9e49-f9721ec79b17', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'wednesday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('3e0d4a19-c35d-401c-a285-1265bc2dcb46', '89b296d8-6cce-4784-a40a-03082c25cd7f', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'thursday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a93f53ad-1793-4b14-b280-a83f69708888', '89b296d8-6cce-4784-a40a-03082c25cd7f', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'thursday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('3d631ce2-f13c-417c-8f97-54da1b940c91', '89b296d8-6cce-4784-a40a-03082c25cd7f', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'friday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6d49f1ba-8d6e-476b-a66c-6290c3e625b0', '89b296d8-6cce-4784-a40a-03082c25cd7f', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'friday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('3b1f021f-fe53-4022-9396-1f019f52f5fd', 'b0b6023f-3e95-44c4-985e-1dd372e35d0a', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'friday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('7ab3c4d8-177d-47af-974e-a4fd9fc2c0ea', 'b0b6023f-3e95-44c4-985e-1dd372e35d0a', '98d6e21c-8364-4ce7-b8b8-e6c6440da916', 'friday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b22a4d43-8259-4e06-b463-11192b8a72b3', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '0c9bdbce-8409-479e-918b-4824baa8420f', 'saturday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('ca646ffb-3491-44a1-944e-c6329246b8f2', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '0c9bdbce-8409-479e-918b-4824baa8420f', 'saturday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('ddc96ea5-e5d0-47c4-8a20-4b9832e28882', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '0c9bdbce-8409-479e-918b-4824baa8420f', 'wednesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('25c5e521-aaef-480c-8711-c817b9e498ec', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '0c9bdbce-8409-479e-918b-4824baa8420f', 'wednesday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a6ccf6f7-9e3e-4384-b770-47546e574cc0', '288d4f0d-edaa-457f-b887-212edae5701b', '0c9bdbce-8409-479e-918b-4824baa8420f', 'saturday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('3a6be455-34e9-4a9f-8ed6-3d011109accd', '288d4f0d-edaa-457f-b887-212edae5701b', '0c9bdbce-8409-479e-918b-4824baa8420f', 'saturday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d0ec9dbc-1a5f-493a-ae66-a384479ac478', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '0c9bdbce-8409-479e-918b-4824baa8420f', 'tuesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('12e39671-5407-4e9d-ab8a-e3e9780c97ae', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '0c9bdbce-8409-479e-918b-4824baa8420f', 'tuesday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('21dd1084-9b74-49da-ae10-e382dcf27574', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '0c9bdbce-8409-479e-918b-4824baa8420f', 'thursday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a501dfd0-2d8d-4e81-ba5d-3b8a5d7a13a4', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '0c9bdbce-8409-479e-918b-4824baa8420f', 'thursday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('390f4f22-060f-4d7f-ae7a-d1052ec08767', '73284f3c-7cc6-475b-b610-3bc05b448895', '0c9bdbce-8409-479e-918b-4824baa8420f', 'tuesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('db35d46a-c977-4b82-821d-f3404a4ee98a', '73284f3c-7cc6-475b-b610-3bc05b448895', '0c9bdbce-8409-479e-918b-4824baa8420f', 'tuesday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('056ef884-0b99-41b3-acf9-33bd2a927db7', '73284f3c-7cc6-475b-b610-3bc05b448895', '0c9bdbce-8409-479e-918b-4824baa8420f', 'wednesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('45bb04fb-21b3-41d8-b2cd-915514bcae11', '73284f3c-7cc6-475b-b610-3bc05b448895', '0c9bdbce-8409-479e-918b-4824baa8420f', 'wednesday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('237dc7bb-dac5-496f-b07e-f3b08ecc7583', '512d2c00-246e-470b-80a6-bb4616615c79', '0c9bdbce-8409-479e-918b-4824baa8420f', 'thursday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('21361ac0-3f46-4024-a968-e32160b2eec5', '512d2c00-246e-470b-80a6-bb4616615c79', '0c9bdbce-8409-479e-918b-4824baa8420f', 'thursday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('fb6c3125-4709-4150-8fcd-ac3a5b6b9bc8', '512d2c00-246e-470b-80a6-bb4616615c79', '0c9bdbce-8409-479e-918b-4824baa8420f', 'friday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d1edaf31-1558-4ac5-add3-1d829b84b7a1', '512d2c00-246e-470b-80a6-bb4616615c79', '0c9bdbce-8409-479e-918b-4824baa8420f', 'friday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('03ba146f-f1d7-4895-8da2-7da15a3b50d7', '56aa4c1c-61ea-466b-bd0d-8980b4ae25ce', '0c9bdbce-8409-479e-918b-4824baa8420f', 'friday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('4f91949d-4256-4ac6-bc8e-22103cf311ba', '56aa4c1c-61ea-466b-bd0d-8980b4ae25ce', '0c9bdbce-8409-479e-918b-4824baa8420f', 'friday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('881acf42-3761-447b-a75e-2a1c1bbdd404', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'saturday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('2ecf4401-c479-438e-b271-a2a126f1078a', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'saturday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('627c59b5-c5bc-44e1-b140-b43cec212e09', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'tuesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('0534cb42-2730-4b15-bc9b-cfe81f4e789a', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'tuesday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('4da79fc8-7180-44b9-ab94-f2fb4660366f', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'saturday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('496924e6-0753-4ee9-a248-d20af4fe1b4b', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'saturday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b1717121-e2db-449c-be5e-250432485983', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'friday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d9f6a9b5-6b84-4af2-ab45-87b7aa17328d', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'friday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('14985009-f5cd-4551-a91d-97155f7d3b63', '56aa4c1c-61ea-466b-bd0d-8980b4ae25ce', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'tuesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('7bf5a7f6-8afc-48a4-893d-1d826df5602a', '56aa4c1c-61ea-466b-bd0d-8980b4ae25ce', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'tuesday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('ed582535-886a-4f48-a2e7-567e8f383915', '73284f3c-7cc6-475b-b610-3bc05b448895', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'wednesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6e2f5a99-d13c-42cd-93c2-77e9fe933141', '73284f3c-7cc6-475b-b610-3bc05b448895', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'wednesday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('090d2957-c065-48bc-ae22-35bd95dca17b', '73284f3c-7cc6-475b-b610-3bc05b448895', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'thursday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('bbb1f42f-d5ed-461e-8d71-712f4ec1546b', '73284f3c-7cc6-475b-b610-3bc05b448895', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'thursday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a11baf61-241e-4792-bd68-2edd651708b5', '288d4f0d-edaa-457f-b887-212edae5701b', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'wednesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('9661b918-29dc-4bee-8719-68fdb3861366', '288d4f0d-edaa-457f-b887-212edae5701b', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'wednesday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('82873798-a516-4d6e-9cbf-9ff260e5047d', '512d2c00-246e-470b-80a6-bb4616615c79', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'thursday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('bd439cec-4675-4563-aa8a-cc64804e12db', '512d2c00-246e-470b-80a6-bb4616615c79', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'thursday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b6c169bc-8c32-424e-a88f-5961926bc3b5', '512d2c00-246e-470b-80a6-bb4616615c79', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'friday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d3b7c9d7-f3f2-468e-aec8-01849081720b', '512d2c00-246e-470b-80a6-bb4616615c79', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb', 'friday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('4ed06b92-11a0-4e35-b9cc-fcb0f87287d2', 'd40158a7-5290-4b3a-b52b-f3ae282a33bc', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'saturday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('9eef8405-01e6-4388-a397-26f8b1b3e9f7', 'd40158a7-5290-4b3a-b52b-f3ae282a33bc', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'saturday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d1547da0-4235-477e-a853-fda75eecb943', 'd40158a7-5290-4b3a-b52b-f3ae282a33bc', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'thursday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('ab548426-f971-4842-89ee-d0b7dc44a99a', 'd40158a7-5290-4b3a-b52b-f3ae282a33bc', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'thursday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('46c5cecb-3611-4da8-894d-57582550c151', '007c2e2d-249c-42f7-a67c-1645eac004b8', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'saturday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('de45500b-4ef2-484c-9cf7-3a24d048f7bb', '007c2e2d-249c-42f7-a67c-1645eac004b8', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'saturday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('778397c6-3656-40a0-b4d4-221614cfffa2', '007c2e2d-249c-42f7-a67c-1645eac004b8', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'friday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a8ab74f4-adc5-4ca1-8268-dc6bcff9f4b8', '007c2e2d-249c-42f7-a67c-1645eac004b8', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'friday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('255ad3c8-517c-4e76-b0d2-da60d77407ca', '88f39d91-ae9d-401a-9559-7d65899a6acb', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'tuesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('52438117-59e3-4b19-b9ce-c705c14c2585', '88f39d91-ae9d-401a-9559-7d65899a6acb', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'tuesday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('4b7366ad-13b5-4742-86a0-846d75bd4522', 'e0d48d2c-e16a-4fdb-8f15-614425060520', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'tuesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6b7d8271-3d18-4112-9911-6c2d5422106e', 'e0d48d2c-e16a-4fdb-8f15-614425060520', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'tuesday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('95a64fb8-8bbe-4e6c-86e5-dacad29a0b9c', '206b1ec1-e2f6-43b8-8541-3fa6b934c073', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'wednesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('4fb9a7b7-7372-4dc6-bbee-0d586609e470', '206b1ec1-e2f6-43b8-8541-3fa6b934c073', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'wednesday', '08:20', '09:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d90406f8-4a49-40a5-98f7-2c6dd1eb81fd', '206b1ec1-e2f6-43b8-8541-3fa6b934c073', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'thursday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a5419687-d690-49f0-890a-17c89b4a8ccf', '206b1ec1-e2f6-43b8-8541-3fa6b934c073', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'thursday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('5d29ecf2-856f-4a1f-b3ea-881aedd7c5b4', 'cee8cec0-d302-4c1f-8ed5-e9eb2206b6b7', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'wednesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b6654435-a26d-4d1b-8b1f-008194a64087', 'cee8cec0-d302-4c1f-8ed5-e9eb2206b6b7', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'wednesday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('1c7a3894-24d1-4034-893e-8956b8e9cafd', '471f63c0-8de8-4b73-9552-09e7ab718870', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'friday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('75528842-47e5-4553-a5c6-f8f4fe569f0c', '471f63c0-8de8-4b73-9552-09e7ab718870', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5', 'friday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('17920968-ad4f-463a-aacf-d7b0afd0cfe3', '338dd044-8611-4f4f-8b4d-6a6b5b2a7f81', '90e21056-e725-4bfc-950f-d7a1e7d6b138', 'wednesday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d4f8f128-57c7-4661-b71b-7262bdd81c40', '338dd044-8611-4f4f-8b4d-6a6b5b2a7f81', '90e21056-e725-4bfc-950f-d7a1e7d6b138', 'wednesday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6f4fd1a7-3ba2-46e4-91fa-52d17f82b0cc', '81dc9a03-7c48-4c3a-8a4e-3f14d8a2f155', '90e21056-e725-4bfc-950f-d7a1e7d6b138', 'thursday', '07:30', '08:20');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('32b1643e-fdb4-41d9-8faa-c1df6cb84923', '81dc9a03-7c48-4c3a-8a4e-3f14d8a2f155', '90e21056-e725-4bfc-950f-d7a1e7d6b138', 'thursday', '08:20', '09:10');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('1fdc1794-0780-4969-a22e-c4b54e98dcf4', '9c0f5e3b-4321-4753-8f8f-4a7d6a1c2b34', '90e21056-e725-4bfc-950f-d7a1e7d6b138', 'wednesday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('e8583694-811d-4041-a811-c8888942ad45', '9c0f5e3b-4321-4753-8f8f-4a7d6a1c2b34', '90e21056-e725-4bfc-950f-d7a1e7d6b138', 'wednesday', '10:10', '11:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('084d737a-d106-40cb-aa13-26068fa0d5f6', '9c0f5e3b-4321-4753-8f8f-4a7d6a1c2b34', '90e21056-e725-4bfc-950f-d7a1e7d6b138', 'thursday', '09:20', '10:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('e14e7538-9e85-414d-a9d9-42b62f328f73', '9c0f5e3b-4321-4753-8f8f-4a7d6a1c2b34', '90e21056-e725-4bfc-950f-d7a1e7d6b138', 'thursday', '10:10', '11:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a7110b97-a8cf-4208-a638-7b8361744945', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'saturday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('74901601-3920-454b-b785-f0782f2f15fa', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'saturday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('c3cbb692-70df-40e9-af16-0c43e90d4670', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'wednesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('f4385c7c-be5c-4072-b2c4-65a301c1d92c', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'wednesday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('82090d44-54aa-4e93-a171-7361c2846418', 'ec75db55-606b-458f-8f75-7cd04bbc7263', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'saturday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('68ae3d8f-2e2f-4b95-a5bb-5041157a64c8', 'ec75db55-606b-458f-8f75-7cd04bbc7263', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'saturday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('168e4f0c-b85d-4643-bea6-bf1ce63104b1', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'tuesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('e8239ac3-ee40-4ab5-ba0c-fc5a8dd1c2a3', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'tuesday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('898659e0-4aa4-4584-982c-95873a51f09f', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'thursday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('704a569c-4a2f-4784-9507-e194aaa10f50', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'thursday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d4588897-ce9d-4a85-a11e-bf73ddbb628a', '3b07f815-803c-4a1e-859a-676e1609923b', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'tuesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('3bb5bdef-1d66-411b-b4c3-8a0ff987ea8a', '3b07f815-803c-4a1e-859a-676e1609923b', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'tuesday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('13b70336-74c0-4b8e-a124-023ec3f5d32f', '3b07f815-803c-4a1e-859a-676e1609923b', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'friday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('f4afd11f-94ac-45de-bf30-9630bc584bb0', '3b07f815-803c-4a1e-859a-676e1609923b', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'friday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('60cd9fec-863c-4690-8642-5ef138ace2f2', '6cd67348-2aec-43c1-89da-cd67db66a57c', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'wednesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('cd4e06e9-9538-4f05-9dc1-2f3c90693637', '6cd67348-2aec-43c1-89da-cd67db66a57c', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'wednesday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('0164e2fb-de29-4211-9885-76c76e34c5bb', '79801de9-5275-48d5-b528-468e89eea314', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'thursday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('fc981c1a-4626-43d3-878e-739d1aaba1e6', '79801de9-5275-48d5-b528-468e89eea314', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'thursday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('62867706-45c4-45c7-a88d-d1d5ab03ce3b', '79801de9-5275-48d5-b528-468e89eea314', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'friday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('35e8450b-b0d7-4244-8734-d1f42c87325b', '79801de9-5275-48d5-b528-468e89eea314', '22fc9f8c-4662-431b-ae29-323aeaf4af28', 'friday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b7df7e3e-95bc-474d-95eb-f6b5bbd5d6de', '6cd67348-2aec-43c1-89da-cd67db66a57c', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'saturday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('3cdf3079-2e65-4ecb-8dc5-8b54e66e2c78', '6cd67348-2aec-43c1-89da-cd67db66a57c', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'saturday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('7a6155bd-0272-410b-9604-5d68e965fc66', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'saturday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('35fb78a4-5291-4bf6-81c3-ab9bccfbd32b', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'saturday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a0a691ec-886d-4564-81b6-6906e4352eb4', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'wednesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6390eebb-a00e-42f0-ac9f-c6225caf81a8', 'f2c5829c-e5ff-4965-866f-e13900d17cab', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'wednesday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a0c3465c-0ea6-488d-9794-80970ee713f4', '3b07f815-803c-4a1e-859a-676e1609923b', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'tuesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b4753c1e-a0a5-4672-be4b-4edc0611ec18', '3b07f815-803c-4a1e-859a-676e1609923b', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'tuesday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('c0a6409d-eaa4-4ba6-b535-87008f366929', '3b07f815-803c-4a1e-859a-676e1609923b', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'friday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b997d460-a19b-479e-872e-9a7bf5f496c7', '3b07f815-803c-4a1e-859a-676e1609923b', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'friday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('cbe536d4-575b-4ad3-8548-98fcb72f91cb', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'tuesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('cc7844c9-f5cd-4920-8eb5-9241886bed3b', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'tuesday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('ece9909a-5132-4f70-bce4-16513e4a0269', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'thursday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('fade2dfd-8b0d-49d9-8eb4-473fb39397b5', '5c57b674-b3ef-40e4-a4fa-e89be1826c72', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'thursday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('e4748319-b7d8-47f0-aa35-53399bcf545b', '79801de9-5275-48d5-b528-468e89eea314', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'wednesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('48557379-e330-4992-9f8b-9ce4441edb9f', '79801de9-5275-48d5-b528-468e89eea314', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'wednesday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('cdc788f8-0e50-43c5-aa1b-2cb7d77dafe2', '79801de9-5275-48d5-b528-468e89eea314', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'thursday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('db46670d-8743-4ee4-b3ef-5096f7da5aaa', '79801de9-5275-48d5-b528-468e89eea314', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'thursday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('79c59098-7742-4e3b-a11f-ca06f67c1c9a', 'ec75db55-606b-458f-8f75-7cd04bbc7263', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'friday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('4da751d6-a7af-49e3-8ebb-4909c7232904', 'ec75db55-606b-458f-8f75-7cd04bbc7263', '9114de5d-6b48-410d-ad0a-a5449fe9946d', 'friday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('460ca018-56ea-423d-8a85-6ee48984f3df', 'e2214f3d-6509-48f0-a132-cb1ffb97eebc', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'saturday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('ccb793e4-ce4a-4bdc-b871-253b87799da1', 'e2214f3d-6509-48f0-a132-cb1ffb97eebc', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'saturday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('7e5fc140-be51-47d9-9e20-2eab0abf51cf', 'e2214f3d-6509-48f0-a132-cb1ffb97eebc', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'thursday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('22606ccc-8dad-4585-95fb-61dea1686bae', 'e2214f3d-6509-48f0-a132-cb1ffb97eebc', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'thursday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('38252d03-4a68-4f6c-b5af-f810e4313d36', 'cbe5cc3c-ce54-4afa-a561-a025209d9477', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'saturday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('f6d72dc1-2060-4ebd-a3aa-7ff0186e0aaf', 'cbe5cc3c-ce54-4afa-a561-a025209d9477', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'saturday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('fa262292-98e4-4189-b1f3-f354b5826edb', '0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'tuesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b52f781e-dce5-4b8c-a3df-91a1bcc39711', '0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'tuesday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a705a097-38a1-4866-ac96-80cfcbc8c9c8', '0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'wednesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('5a39230a-026e-41a7-ab74-a2c268c1e370', '0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'wednesday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('671dc9fa-d122-4247-bbbe-75aa4e0f8cef', '0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'thursday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('7e74733f-04f9-461f-ba13-e6d91a950edc', '0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'thursday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('4578d848-be81-40df-a608-9a28e4c9c27a', '1c7fe57f-cb3d-4d5c-87f0-d9206d9dd9ad', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'tuesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('903ddbaf-93bb-47ce-b2c1-de49561a2d50', '1c7fe57f-cb3d-4d5c-87f0-d9206d9dd9ad', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'tuesday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('f08e3a92-68d1-45fe-96bd-75afd9203244', '1c7fe57f-cb3d-4d5c-87f0-d9206d9dd9ad', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'friday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('3b0adb30-53c4-4da2-ba15-8ec94f568721', '1c7fe57f-cb3d-4d5c-87f0-d9206d9dd9ad', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'friday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6690993f-4f62-4efe-9abb-d7bf437c46cc', 'bbdf71da-53d7-4ac3-8bcf-aea96db95d98', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'wednesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('e977fcfb-3df7-4184-a52a-c45912da8036', 'bbdf71da-53d7-4ac3-8bcf-aea96db95d98', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'wednesday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('4ff0227e-6eaf-4a16-86a9-5494172fb66e', 'bbdf71da-53d7-4ac3-8bcf-aea96db95d98', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'friday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a6374b7b-946e-4915-8d5f-e867f260ce0e', 'bbdf71da-53d7-4ac3-8bcf-aea96db95d98', '6d3f3838-da40-45da-b616-d4cac61a94d4', 'friday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('fb9215e4-df5b-4ef5-98a8-998ce2748088', '85de1e36-b258-4c15-81a5-6f8f28e1f000', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'saturday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('1128b281-6499-44a7-a3e1-b44ca501b775', '85de1e36-b258-4c15-81a5-6f8f28e1f000', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'saturday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b64a7424-7001-4bb2-8f79-6ac31705b296', '85de1e36-b258-4c15-81a5-6f8f28e1f000', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'thursday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('49792c07-f544-4d99-b8f0-a2b65b3aedd2', '85de1e36-b258-4c15-81a5-6f8f28e1f000', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'thursday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('ba4ad95f-eb9d-46b9-ad36-55b7cda18114', '41c5e531-3766-41aa-b129-191cf4b15d04', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'saturday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d360b1e0-10ed-4772-9dab-19c1eece6e88', '41c5e531-3766-41aa-b129-191cf4b15d04', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'saturday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('cbfb0558-e3df-43dc-879a-c53cf169d2b2', '41c5e531-3766-41aa-b129-191cf4b15d04', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'friday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('35993751-f485-4f18-b744-9b9a3ec90373', '41c5e531-3766-41aa-b129-191cf4b15d04', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'friday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('2a833e26-8b15-4643-9175-753723c27a26', '565ffa32-2490-4ceb-b603-6e4727d961b9', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'tuesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('0e7391d7-005e-4e85-857c-fc0be4c60386', '565ffa32-2490-4ceb-b603-6e4727d961b9', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'tuesday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b0b5faca-3a75-417d-b0ba-70757afe6b3a', '565ffa32-2490-4ceb-b603-6e4727d961b9', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'wednesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6b15183b-c386-4ceb-8622-ef0c5da3eb58', '565ffa32-2490-4ceb-b603-6e4727d961b9', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'wednesday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d5fb0872-e565-4f27-84bc-698bf87680c6', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'tuesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('7b2a87b8-79a5-46da-bd94-928c4cd164d2', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'tuesday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('0c8ddc20-3907-40dd-9a2f-7b171c3f9817', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'thursday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d837d4bb-3728-434f-b540-cb1b99a17ce3', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'thursday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('56323390-39e3-437d-85d6-8382d5ef344a', 'd0e6410b-56d2-4cb3-9dd4-1b656c14fc7c', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'wednesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('480d5c3d-a6ec-466c-9fa9-b1054c2e7ebc', 'd0e6410b-56d2-4cb3-9dd4-1b656c14fc7c', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6', 'wednesday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('e3cd2bf3-b304-4996-ab57-ebea062b22d0', '85de1e36-b258-4c15-81a5-6f8f28e1f000', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'saturday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('9cc14a18-12d6-4f8f-bbb4-cf3a0f818712', '85de1e36-b258-4c15-81a5-6f8f28e1f000', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'saturday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('662cc90c-cee9-4ac2-839f-b777c86f7e4c', '85de1e36-b258-4c15-81a5-6f8f28e1f000', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'thursday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('09c9e083-12de-4455-b225-d67bb787b4c5', '85de1e36-b258-4c15-81a5-6f8f28e1f000', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'thursday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('c5021746-3de1-4e12-8ced-2f076135cc91', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'tuesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('14591354-f5be-412f-90b0-97643cb95330', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'tuesday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('c920e896-d536-416a-86aa-e88c790df25e', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'wednesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b4f24830-981d-4a87-bb39-751f4229c1fb', '6b3ff87e-eae6-4947-b121-1a359f8ab0d8', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'wednesday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('37e44c08-82f0-4d88-a172-c4c08d3fa3b1', '41c5e531-3766-41aa-b129-191cf4b15d04', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'tuesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('337370b8-dac7-45a3-998b-f76322d1b7c4', '41c5e531-3766-41aa-b129-191cf4b15d04', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'tuesday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('f09aeea1-6c6d-4e90-ba00-f1c106c66f01', '41c5e531-3766-41aa-b129-191cf4b15d04', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'friday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d3a93178-614c-4b83-b06e-b9db9882b654', '41c5e531-3766-41aa-b129-191cf4b15d04', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'friday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('56b0d97c-6abf-4b03-9ebc-0187beaff7ff', 'd0e6410b-56d2-4cb3-9dd4-1b656c14fc7c', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'wednesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('3f998495-0668-490c-a2e0-b3196beb5c5e', 'd0e6410b-56d2-4cb3-9dd4-1b656c14fc7c', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'wednesday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('7aa7404d-f8d1-40c2-b73b-434544f354a0', '565ffa32-2490-4ceb-b603-6e4727d961b9', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'wednesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b041ecd2-9c6e-4901-a208-4c17352e2fba', '565ffa32-2490-4ceb-b603-6e4727d961b9', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'wednesday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d782b128-ea26-4611-a1a0-8aebee824f46', '565ffa32-2490-4ceb-b603-6e4727d961b9', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'friday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('3e241083-0f72-4b7a-9669-c73103b7fc37', '565ffa32-2490-4ceb-b603-6e4727d961b9', 'cbfa50dc-76b4-4946-a10e-79319bf65155', 'friday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a8d27b9e-8bac-4264-a315-84b849de1a35', '1e6e62da-0c3f-4500-9e49-f9721ec79b17', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'saturday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6174dbf5-338c-445f-b01e-97498f3d22b5', '1e6e62da-0c3f-4500-9e49-f9721ec79b17', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'saturday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('2dd75ecc-3370-4fbb-b54c-e06a7b06c8ea', 'e66cd7d8-4223-4924-bdc9-85911b9e5410', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'saturday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('634e7699-514e-4797-b98c-e63f776dd241', 'e66cd7d8-4223-4924-bdc9-85911b9e5410', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'saturday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('aad59c72-1d4a-4538-aec1-60adb54ed405', 'e66cd7d8-4223-4924-bdc9-85911b9e5410', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'thursday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('5c4431a1-e31b-4145-a9b7-db318c3bcf2c', 'e66cd7d8-4223-4924-bdc9-85911b9e5410', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'thursday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('f9bfe95c-6fc4-4d28-8c53-a14399f4553f', '96b17e4b-0d92-4623-86c9-d04bc1221ad0', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'tuesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('1059c0ac-43d3-4848-b0a7-4075e11a9bf5', '96b17e4b-0d92-4623-86c9-d04bc1221ad0', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'tuesday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('634412ce-3751-4cfe-9475-71e163132a99', '96b17e4b-0d92-4623-86c9-d04bc1221ad0', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'friday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('fcd760fb-77e7-4124-9244-984db54fcc30', '96b17e4b-0d92-4623-86c9-d04bc1221ad0', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'friday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('898f8bcd-4a0b-4782-ac07-fb19547e1a51', '70ba8979-0767-4e43-9762-3ca7b8983f82', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'tuesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('986d7de7-e306-403a-8849-68f0ec6dfd84', '70ba8979-0767-4e43-9762-3ca7b8983f82', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'tuesday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('cab613d3-d507-49b5-90d8-d91afe17802a', '70ba8979-0767-4e43-9762-3ca7b8983f82', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'wednesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('653682ef-cfb3-4cda-9044-89a66b294395', '70ba8979-0767-4e43-9762-3ca7b8983f82', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'wednesday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('64b0b9da-8a57-4c4d-bcba-5da2b8eb96ff', '89b296d8-6cce-4784-a40a-03082c25cd7f', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'wednesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a5cda5a8-3041-4e1d-bbaf-0023c186ff8d', '89b296d8-6cce-4784-a40a-03082c25cd7f', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'wednesday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('53a5fd0c-a8db-4819-b296-d495829c6c9a', '89b296d8-6cce-4784-a40a-03082c25cd7f', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'thursday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('60be3d32-ec3e-4b5e-9860-be69197fb5fa', '89b296d8-6cce-4784-a40a-03082c25cd7f', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'thursday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('5fc8df34-c536-48ef-a6f3-e45bd73d00dc', 'b0b6023f-3e95-44c4-985e-1dd372e35d0a', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'friday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('144b9f12-0718-4172-a387-8a0bea856f12', 'b0b6023f-3e95-44c4-985e-1dd372e35d0a', '47737e4a-1d56-457a-b89d-49b9f3600a94', 'friday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('cd36e883-667e-4488-8549-3eaffe095c2f', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'saturday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('c33f3182-9cee-434a-a91e-836e74902635', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'saturday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('ba551a69-90f4-4190-843b-9c2e7cb6dc43', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'wednesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('55901a2b-8df8-4820-9ae4-0a9f373ed3bc', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'wednesday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('93ff144a-a0c0-47fc-a2e0-63c64b6cbf15', '512d2c00-246e-470b-80a6-bb4616615c79', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'saturday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('336515ba-60fb-4d62-bcd6-c38eb106e20f', '512d2c00-246e-470b-80a6-bb4616615c79', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'saturday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('326097fb-06de-48d1-a8f6-0333cc3636ef', '512d2c00-246e-470b-80a6-bb4616615c79', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'friday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('53df0328-4010-4fd3-9173-7406bf57434f', '512d2c00-246e-470b-80a6-bb4616615c79', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'friday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6715a420-125f-4560-97ca-0a1073a39feb', '56aa4c1c-61ea-466b-bd0d-8980b4ae25ce', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'tuesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('3c2e9976-d5aa-4dbb-97b5-d65762c69b47', '56aa4c1c-61ea-466b-bd0d-8980b4ae25ce', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'tuesday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('f37c7bb5-30d4-40c2-ac28-e060017bfe10', '73284f3c-7cc6-475b-b610-3bc05b448895', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'tuesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('5279f7bb-cfe0-4577-9273-15aaa6dbc7e3', '73284f3c-7cc6-475b-b610-3bc05b448895', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'tuesday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('209f57e8-4254-4a3e-80fa-33e4a54bac7b', '73284f3c-7cc6-475b-b610-3bc05b448895', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'thursday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a8cd66a0-9948-4d75-80b2-28ad3b81edba', '73284f3c-7cc6-475b-b610-3bc05b448895', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'thursday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('78bd2ca7-d350-4741-9922-08b10f193385', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'wednesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('c647e264-58fd-49ba-ab08-482028e2e204', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'wednesday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('603f2006-2e48-4f62-acdb-864d933b1549', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'thursday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('bac2d0f8-f2f5-4f84-ad90-72011e0649a9', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'thursday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('9b9af827-bba3-4572-942e-d1e6247c5256', '288d4f0d-edaa-457f-b887-212edae5701b', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'friday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('17a80893-639d-44bf-a78b-49e70e6263b3', '288d4f0d-edaa-457f-b887-212edae5701b', 'cd2ed283-8c56-44c1-befe-9a3cf5738378', 'friday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('81eab7ca-ac2e-4177-ac88-453ceaaeb39d', '73284f3c-7cc6-475b-b610-3bc05b448895', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'saturday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('d04a53e2-c7c4-4a0d-a935-f6ff91c7007a', '73284f3c-7cc6-475b-b610-3bc05b448895', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'saturday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('4f0161fe-8f5f-486c-a393-3ee99c3cac8c', '73284f3c-7cc6-475b-b610-3bc05b448895', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'thursday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('165b8207-ea43-4d02-9d30-f73e3adc54c3', '73284f3c-7cc6-475b-b610-3bc05b448895', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'thursday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('2530ca1e-6fe0-4945-b5c9-9b4a01d656ed', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'saturday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('13bcca2d-e3c2-478b-a62e-dc075073abdc', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'saturday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('8ece92fa-5021-48e5-b287-6ed67385146c', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'wednesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('66a449d3-c5fb-4b57-a82c-e3b6aff9ee3a', '1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'wednesday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('ce015a50-6ba0-42a4-afd2-021c19a2fa23', '288d4f0d-edaa-457f-b887-212edae5701b', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'tuesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('7332e0ef-9268-405b-a408-885ec7fea9fb', '288d4f0d-edaa-457f-b887-212edae5701b', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'tuesday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a3690f05-b3bc-4ed5-8765-2578b3aed504', '512d2c00-246e-470b-80a6-bb4616615c79', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'tuesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('2b7cd141-dca8-4bbf-8c67-b13309c30580', '512d2c00-246e-470b-80a6-bb4616615c79', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'tuesday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a405dea9-d7b2-4798-be67-be7c9ff76ae9', '512d2c00-246e-470b-80a6-bb4616615c79', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'thursday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b0a06b0d-b823-4c1e-be35-33bb326c20d7', '512d2c00-246e-470b-80a6-bb4616615c79', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'thursday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('cb6c61e5-33be-422c-87ec-11237c756c9d', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'wednesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('81e95a3a-1948-4982-abbb-91ba23bd64a7', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'wednesday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a539334a-1564-4222-82fb-a7d96bd2fe43', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'friday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('eb41353c-780e-41e6-abbf-5cb42cd36907', '63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'friday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('db01a621-2119-471b-a45d-f6f90ace8e6e', '56aa4c1c-61ea-466b-bd0d-8980b4ae25ce', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'friday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('03b5624b-5ec2-47f8-8aa8-460753d4cdc0', '56aa4c1c-61ea-466b-bd0d-8980b4ae25ce', '834ea7fa-6558-4957-bf3c-b1974d50a680', 'friday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6655d424-1bb4-46d9-b9dc-4ddd4a032ee8', '007c2e2d-249c-42f7-a67c-1645eac004b8', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'saturday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('efdcfaea-fe9e-4022-83de-280e1c90cde2', '007c2e2d-249c-42f7-a67c-1645eac004b8', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'saturday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a3169125-831c-4515-9b3f-9ac101d1f8a4', '007c2e2d-249c-42f7-a67c-1645eac004b8', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'wednesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('849ef793-f8a3-4b44-8e70-89403430a23b', '007c2e2d-249c-42f7-a67c-1645eac004b8', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'wednesday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('07e2b8d8-39f4-40d1-b5b0-62693b3ca5f6', 'e0d48d2c-e16a-4fdb-8f15-614425060520', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'saturday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('1f2409da-246c-4cf3-8bae-84cd9d11962b', 'e0d48d2c-e16a-4fdb-8f15-614425060520', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'saturday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b47973c2-a482-4d3b-9c25-6f8439bb69be', 'd40158a7-5290-4b3a-b52b-f3ae282a33bc', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'tuesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b3b851f2-47e8-46f4-931f-3b9ee76e6ac9', 'd40158a7-5290-4b3a-b52b-f3ae282a33bc', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'tuesday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('c9b03ef0-926c-4dba-902d-5e8260f4b087', 'd40158a7-5290-4b3a-b52b-f3ae282a33bc', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'wednesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a5e4ec09-5ca6-494d-a55d-7178444deb09', 'd40158a7-5290-4b3a-b52b-f3ae282a33bc', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'wednesday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('81d17594-8c3d-4350-b98d-a2bd7f18b758', '88f39d91-ae9d-401a-9559-7d65899a6acb', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'tuesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('9655f52d-5e50-44e5-8914-280e62fea2a2', '88f39d91-ae9d-401a-9559-7d65899a6acb', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'tuesday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('9189a653-0086-4a65-bbc9-02758afe00b8', '206b1ec1-e2f6-43b8-8541-3fa6b934c073', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'thursday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('cd5feb77-389f-4ea9-9feb-b22b27140980', '206b1ec1-e2f6-43b8-8541-3fa6b934c073', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'thursday', '20:10', '21:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('333194cd-2483-48b1-bcd9-2aa880bed0f5', '206b1ec1-e2f6-43b8-8541-3fa6b934c073', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'friday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('6a4e952c-f8f5-4ed6-a465-fd35a0662bbd', '206b1ec1-e2f6-43b8-8541-3fa6b934c073', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'friday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('8e4b1f9f-175e-4597-af5e-2db34b124727', '471f63c0-8de8-4b73-9552-09e7ab718870', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'thursday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('53b2679a-df80-4d59-a057-2770a7b03136', '471f63c0-8de8-4b73-9552-09e7ab718870', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'thursday', '22:00', '22:50');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('22ffeca9-2c1a-4f9c-82a5-66d5a4e16feb', 'cee8cec0-d302-4c1f-8ed5-e9eb2206b6b7', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'friday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('a5d2f354-ea77-4495-8a36-27cd85123e60', 'cee8cec0-d302-4c1f-8ed5-e9eb2206b6b7', 'cc665ac5-861e-4af2-adf6-86b71732db91', 'friday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('862c1d50-e9e8-4012-982f-95563504de08', '9c0f5e3b-4321-4753-8f8f-4a7d6a1c2b34', '6b484df1-a447-4711-ad51-39a2d42996db', 'saturday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('5e9ad2b7-7379-4eaa-b069-f106d1bb5f45', '9c0f5e3b-4321-4753-8f8f-4a7d6a1c2b34', '6b484df1-a447-4711-ad51-39a2d42996db', 'saturday', '22:00', '22:50');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('b942c34b-0d40-4c2f-8ecb-93044845f718', '9c0f5e3b-4321-4753-8f8f-4a7d6a1c2b34', '6b484df1-a447-4711-ad51-39a2d42996db', 'wednesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('cae02339-3739-447a-9dcd-47d8e0d4d2d1', '9c0f5e3b-4321-4753-8f8f-4a7d6a1c2b34', '6b484df1-a447-4711-ad51-39a2d42996db', 'wednesday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('181a81db-1534-439a-bcdc-6ba225262268', '338dd044-8611-4f4f-8b4d-6a6b5b2a7f81', '6b484df1-a447-4711-ad51-39a2d42996db', 'tuesday', '19:20', '20:10');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('1062aaf9-a2f4-4388-85be-99f7b7d91e28', '338dd044-8611-4f4f-8b4d-6a6b5b2a7f81', '6b484df1-a447-4711-ad51-39a2d42996db', 'tuesday', '20:10', '21:00');


INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('cc9e1d72-e910-42de-9b2a-6326c0e73e5c', '81dc9a03-7c48-4c3a-8a4e-3f14d8a2f155', '6b484df1-a447-4711-ad51-39a2d42996db', 'tuesday', '21:10', '22:00');

INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, start_time, end_time)
VALUES ('9c13ff01-3f54-4cd5-87ad-8c8a28b4b679', '81dc9a03-7c48-4c3a-8a4e-3f14d8a2f155', '6b484df1-a447-4711-ad51-39a2d42996db', 'tuesday', '22:00', '22:50');
