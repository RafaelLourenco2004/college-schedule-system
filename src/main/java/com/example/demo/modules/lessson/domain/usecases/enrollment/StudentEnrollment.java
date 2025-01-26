package com.example.demo.modules.lessson.domain.usecases.enrollment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.Student;
import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.exceptions.MissingSubjectDependencyException;
import com.example.demo.modules.lessson.domain.usecases.student.GetStudent;
import com.example.demo.modules.lessson.persistence.services.EnrollmentService;

@Service
public class StudentEnrollment {

    @Autowired
    private EnrollmentService enrollmentService;

    @Autowired
    private GetStudent getStudent;

    public Student enrollStudent(String studentId, List<Lesson> lessons) {
        Student student = getStudent.getOne(studentId);

        for (Lesson lesson : lessons) {
            if (isThereMissingDependency(lesson, student))
                throw new MissingSubjectDependencyException(String.format("Student could not be enrolled " +
                        "in %s as a previous mandatory subject has not been completed.",
                        lesson.getSubject().getName()));
        }

        enrollmentService.deleteEnrollments(student.getLessons(), studentId);
        enrollmentService.createEnrollments(lessons, studentId);

        lessons.stream().forEach((lesson) -> student.addLesson(lesson));
        return student;
    }

    private boolean isThereMissingDependency(Lesson lesson, Student student) {
        Subject subject = lesson.getSubject();
        if (subject.isThereDependecies()) {
            for (Subject dependecy : subject.getDependencies()) {
                if (!student.isSubjectCompleted(dependecy))
                    return true;
            }
        }
        return false;
    }

}
