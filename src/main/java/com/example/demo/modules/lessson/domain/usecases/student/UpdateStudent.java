package com.example.demo.modules.lessson.domain.usecases.student;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.Student;
import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.exceptions.MissingSubjectDependencyException;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.domain.usecases.lesson.PostLesson;
import com.example.demo.modules.lessson.persistence.services.StudentService;

@Service
public class UpdateStudent {

    @Autowired
    private StudentService studentService;
    
    @Autowired
    private PostLesson postLesson;

    public Student postSchedule(String studentId, List<Lesson> lessons) throws MissingSubjectDependencyException {
        Student student = studentService.getOne(studentId).orElseThrow(
                () -> new NotFoundException(String.format("Could not find student of id %s", studentId)));

        Subject subject;
        for (Lesson lesson : lessons) {
            subject = lesson.getSubject();
            isThereMissingSubjectDepedency(student, subject);
            lesson.addStudent(student);
        }

        List<Lesson> updatedLessons = lessons.stream().map((lesson) -> postLesson.createLesson(lesson))
            .collect(Collectors.toCollection(ArrayList::new));
    
        student.setlessons(updatedLessons);
        Student newStudent = studentService.create(student);
        return newStudent;
    }

    private void isThereMissingSubjectDepedency(Student student, Subject subject) {
        Set<Subject> dependencies;
        if (subject.isThereDependecies()) {
            dependencies = subject.getDependencies();
            for (Subject dependency : dependencies) {
                if (!student.isSubjectCompleted(dependency)) {
                    throwMissingSubjectDependencyException(dependency.getName(), subject.getName());
                }
            }
        }
    }

    private void throwMissingSubjectDependencyException(String dependency, String subject) {
        throw new MissingSubjectDependencyException(
                String.format("%s is required to have been completed for the student to enroll" +
                        " in %s", dependency, subject));
    }
}
