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
    -- FOREIGN KEY (subject_id) REFERENCES lesson.subject(subject_id),
    -- FOREIGN KEY (classroom_id) REFERENCES lesson.classroom(classroom_id)
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


-- creating lesson

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('3b07f815-803c-4a1e-859a-676e1609923b', '6753b227-769f-4bcd-ba35-c9987c333bba');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('5c57b674-b3ef-40e4-a4fa-e89be1826c72', '6753b227-769f-4bcd-ba35-c9987c333bba');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('79801de9-5275-48d5-b528-468e89eea314', '6753b227-769f-4bcd-ba35-c9987c333bba');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('f2c5829c-e5ff-4965-866f-e13900d17cab', '6753b227-769f-4bcd-ba35-c9987c333bba');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('6cd67348-2aec-43c1-89da-cd67db66a57c', '6753b227-769f-4bcd-ba35-c9987c333bba');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('ec75db55-606b-458f-8f75-7cd04bbc7263', '6753b227-769f-4bcd-ba35-c9987c333bba');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('3b07f815-803c-4a1e-859a-676e1609923b', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('5c57b674-b3ef-40e4-a4fa-e89be1826c72', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('79801de9-5275-48d5-b528-468e89eea314', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('f2c5829c-e5ff-4965-866f-e13900d17cab', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('6cd67348-2aec-43c1-89da-cd67db66a57c', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('ec75db55-606b-458f-8f75-7cd04bbc7263', '2eec3e1d-fa3e-4cf3-afa3-95d0adf2e463');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('3b07f815-803c-4a1e-859a-676e1609923b', '22fc9f8c-4662-431b-ae29-323aeaf4af28');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('5c57b674-b3ef-40e4-a4fa-e89be1826c72', '22fc9f8c-4662-431b-ae29-323aeaf4af28');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('79801de9-5275-48d5-b528-468e89eea314', '22fc9f8c-4662-431b-ae29-323aeaf4af28');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('f2c5829c-e5ff-4965-866f-e13900d17cab', '22fc9f8c-4662-431b-ae29-323aeaf4af28');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('6cd67348-2aec-43c1-89da-cd67db66a57c', '22fc9f8c-4662-431b-ae29-323aeaf4af28');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('ec75db55-606b-458f-8f75-7cd04bbc7263', '22fc9f8c-4662-431b-ae29-323aeaf4af28');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('3b07f815-803c-4a1e-859a-676e1609923b', '9114de5d-6b48-410d-ad0a-a5449fe9946d');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('5c57b674-b3ef-40e4-a4fa-e89be1826c72', '9114de5d-6b48-410d-ad0a-a5449fe9946d');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('79801de9-5275-48d5-b528-468e89eea314', '9114de5d-6b48-410d-ad0a-a5449fe9946d');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('f2c5829c-e5ff-4965-866f-e13900d17cab', '9114de5d-6b48-410d-ad0a-a5449fe9946d');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('6cd67348-2aec-43c1-89da-cd67db66a57c', '9114de5d-6b48-410d-ad0a-a5449fe9946d');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('ec75db55-606b-458f-8f75-7cd04bbc7263', '9114de5d-6b48-410d-ad0a-a5449fe9946d');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('e2214f3d-6509-48f0-a132-cb1ffb97eebc', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('bbdf71da-53d7-4ac3-8bcf-aea96db95d98', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('1c7fe57f-cb3d-4d5c-87f0-d9206d9dd9ad', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('cbe5cc3c-ce54-4afa-a561-a025209d9477', 'fd1ff062-e4d6-47ad-a02c-0cba75e0f262');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('e2214f3d-6509-48f0-a132-cb1ffb97eebc', '6d3f3838-da40-45da-b616-d4cac61a94d4');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('0d5583c9-8b9b-465c-8ad1-1b3e14230d6a', '6d3f3838-da40-45da-b616-d4cac61a94d4');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('bbdf71da-53d7-4ac3-8bcf-aea96db95d98', '6d3f3838-da40-45da-b616-d4cac61a94d4');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('1c7fe57f-cb3d-4d5c-87f0-d9206d9dd9ad', '6d3f3838-da40-45da-b616-d4cac61a94d4');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('cbe5cc3c-ce54-4afa-a561-a025209d9477', '6d3f3838-da40-45da-b616-d4cac61a94d4');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('85de1e36-b258-4c15-81a5-6f8f28e1f000', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('41c5e531-3766-41aa-b129-191cf4b15d04', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('6b3ff87e-eae6-4947-b121-1a359f8ab0d8', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('d0e6410b-56d2-4cb3-9dd4-1b656c14fc7c', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('565ffa32-2490-4ceb-b603-6e4727d961b9', '75b0e281-07b3-4ba4-9eb1-0f7e04ef5575');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('85de1e36-b258-4c15-81a5-6f8f28e1f000', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('41c5e531-3766-41aa-b129-191cf4b15d04', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('6b3ff87e-eae6-4947-b121-1a359f8ab0d8', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('d0e6410b-56d2-4cb3-9dd4-1b656c14fc7c', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('565ffa32-2490-4ceb-b603-6e4727d961b9', 'ce04e642-6a6e-441f-88ae-4001ff1b6b4f');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('85de1e36-b258-4c15-81a5-6f8f28e1f000', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('41c5e531-3766-41aa-b129-191cf4b15d04', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('6b3ff87e-eae6-4947-b121-1a359f8ab0d8', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('d0e6410b-56d2-4cb3-9dd4-1b656c14fc7c', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('565ffa32-2490-4ceb-b603-6e4727d961b9', '51d0e0b4-7639-4366-9ad0-5ce64c14ace6');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('85de1e36-b258-4c15-81a5-6f8f28e1f000', 'cbfa50dc-76b4-4946-a10e-79319bf65155');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('41c5e531-3766-41aa-b129-191cf4b15d04', 'cbfa50dc-76b4-4946-a10e-79319bf65155');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('6b3ff87e-eae6-4947-b121-1a359f8ab0d8', 'cbfa50dc-76b4-4946-a10e-79319bf65155');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('d0e6410b-56d2-4cb3-9dd4-1b656c14fc7c', 'cbfa50dc-76b4-4946-a10e-79319bf65155');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('565ffa32-2490-4ceb-b603-6e4727d961b9', 'cbfa50dc-76b4-4946-a10e-79319bf65155');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('96b17e4b-0d92-4623-86c9-d04bc1221ad0', '98d6e21c-8364-4ce7-b8b8-e6c6440da916');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('e66cd7d8-4223-4924-bdc9-85911b9e5410', '98d6e21c-8364-4ce7-b8b8-e6c6440da916');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('1e6e62da-0c3f-4500-9e49-f9721ec79b17', '98d6e21c-8364-4ce7-b8b8-e6c6440da916');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('89b296d8-6cce-4784-a40a-03082c25cd7f', '98d6e21c-8364-4ce7-b8b8-e6c6440da916');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('b0b6023f-3e95-44c4-985e-1dd372e35d0a', '98d6e21c-8364-4ce7-b8b8-e6c6440da916');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('70ba8979-0767-4e43-9762-3ca7b8983f82', '98d6e21c-8364-4ce7-b8b8-e6c6440da916');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('96b17e4b-0d92-4623-86c9-d04bc1221ad0', '47737e4a-1d56-457a-b89d-49b9f3600a94');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('e66cd7d8-4223-4924-bdc9-85911b9e5410', '47737e4a-1d56-457a-b89d-49b9f3600a94');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('1e6e62da-0c3f-4500-9e49-f9721ec79b17', '47737e4a-1d56-457a-b89d-49b9f3600a94');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('89b296d8-6cce-4784-a40a-03082c25cd7f', '47737e4a-1d56-457a-b89d-49b9f3600a94');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('b0b6023f-3e95-44c4-985e-1dd372e35d0a', '47737e4a-1d56-457a-b89d-49b9f3600a94');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('70ba8979-0767-4e43-9762-3ca7b8983f82', '47737e4a-1d56-457a-b89d-49b9f3600a94');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '0c9bdbce-8409-479e-918b-4824baa8420f');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '0c9bdbce-8409-479e-918b-4824baa8420f');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('56aa4c1c-61ea-466b-bd0d-8980b4ae25ce', '0c9bdbce-8409-479e-918b-4824baa8420f');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('73284f3c-7cc6-475b-b610-3bc05b448895', '0c9bdbce-8409-479e-918b-4824baa8420f');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('512d2c00-246e-470b-80a6-bb4616615c79', '0c9bdbce-8409-479e-918b-4824baa8420f');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('288d4f0d-edaa-457f-b887-212edae5701b', '0c9bdbce-8409-479e-918b-4824baa8420f');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('56aa4c1c-61ea-466b-bd0d-8980b4ae25ce', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('73284f3c-7cc6-475b-b610-3bc05b448895', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('512d2c00-246e-470b-80a6-bb4616615c79', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('288d4f0d-edaa-457f-b887-212edae5701b', '7298c9dd-6286-4240-bd5b-73f3a04ffaeb');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', 'cd2ed283-8c56-44c1-befe-9a3cf5738378');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('63ff2fbb-65ea-465d-acc4-5c07dc1ae563', 'cd2ed283-8c56-44c1-befe-9a3cf5738378');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('56aa4c1c-61ea-466b-bd0d-8980b4ae25ce', 'cd2ed283-8c56-44c1-befe-9a3cf5738378');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('73284f3c-7cc6-475b-b610-3bc05b448895', 'cd2ed283-8c56-44c1-befe-9a3cf5738378');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('512d2c00-246e-470b-80a6-bb4616615c79', 'cd2ed283-8c56-44c1-befe-9a3cf5738378');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('288d4f0d-edaa-457f-b887-212edae5701b', 'cd2ed283-8c56-44c1-befe-9a3cf5738378');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('1e3a5e0c-6cbe-4dfb-8269-a475f214dfdc', '834ea7fa-6558-4957-bf3c-b1974d50a680');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('63ff2fbb-65ea-465d-acc4-5c07dc1ae563', '834ea7fa-6558-4957-bf3c-b1974d50a680');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('56aa4c1c-61ea-466b-bd0d-8980b4ae25ce', '834ea7fa-6558-4957-bf3c-b1974d50a680');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('73284f3c-7cc6-475b-b610-3bc05b448895', '834ea7fa-6558-4957-bf3c-b1974d50a680');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('512d2c00-246e-470b-80a6-bb4616615c79', '834ea7fa-6558-4957-bf3c-b1974d50a680');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('288d4f0d-edaa-457f-b887-212edae5701b', '834ea7fa-6558-4957-bf3c-b1974d50a680');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('007c2e2d-249c-42f7-a67c-1645eac004b8', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('cee8cec0-d302-4c1f-8ed5-e9eb2206b6b7', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('d40158a7-5290-4b3a-b52b-f3ae282a33bc', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('88f39d91-ae9d-401a-9559-7d65899a6acb', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('206b1ec1-e2f6-43b8-8541-3fa6b934c073', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('471f63c0-8de8-4b73-9552-09e7ab718870', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('e0d48d2c-e16a-4fdb-8f15-614425060520', 'd89f360b-c2b2-49b8-a457-8a49f504f5d5');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('007c2e2d-249c-42f7-a67c-1645eac004b8', 'cc665ac5-861e-4af2-adf6-86b71732db91');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('cee8cec0-d302-4c1f-8ed5-e9eb2206b6b7', 'cc665ac5-861e-4af2-adf6-86b71732db91');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('d40158a7-5290-4b3a-b52b-f3ae282a33bc', 'cc665ac5-861e-4af2-adf6-86b71732db91');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('88f39d91-ae9d-401a-9559-7d65899a6acb', 'cc665ac5-861e-4af2-adf6-86b71732db91');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('206b1ec1-e2f6-43b8-8541-3fa6b934c073', 'cc665ac5-861e-4af2-adf6-86b71732db91');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('471f63c0-8de8-4b73-9552-09e7ab718870', 'cc665ac5-861e-4af2-adf6-86b71732db91');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('e0d48d2c-e16a-4fdb-8f15-614425060520', 'cc665ac5-861e-4af2-adf6-86b71732db91');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('338dd044-8611-4f4f-8b4d-6a6b5b2a7f81', '90e21056-e725-4bfc-950f-d7a1e7d6b138');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('81dc9a03-7c48-4c3a-8a4e-3f14d8a2f155', '90e21056-e725-4bfc-950f-d7a1e7d6b138');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('9c0f5e3b-4321-4753-8f8f-4a7d6a1c2b34', '90e21056-e725-4bfc-950f-d7a1e7d6b138');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('6f81a312-8547-449f-8d4e-5f13f2a9c1e4', '90e21056-e725-4bfc-950f-d7a1e7d6b138');


INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('338dd044-8611-4f4f-8b4d-6a6b5b2a7f81', '6b484df1-a447-4711-ad51-39a2d42996db');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('81dc9a03-7c48-4c3a-8a4e-3f14d8a2f155', '6b484df1-a447-4711-ad51-39a2d42996db');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('9c0f5e3b-4321-4753-8f8f-4a7d6a1c2b34', '6b484df1-a447-4711-ad51-39a2d42996db');

INSERT INTO lesson.lesson (subject_id, classroom_id)
VALUES ('6f81a312-8547-449f-8d4e-5f13f2a9c1e4', '6b484df1-a447-4711-ad51-39a2d42996db');

-- creating student
INSERT INTO lesson.student (student_id, name, course_id)
VALUES ('12345678', 'Rafael', 'b0d1a107-5dd0-48c9-a19e-bf93c53608e5');
