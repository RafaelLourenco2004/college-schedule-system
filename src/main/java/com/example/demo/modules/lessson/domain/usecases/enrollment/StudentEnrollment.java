package com.example.demo.modules.lessson.domain.usecases.enrollment;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Classroom;
import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.Student;
import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.exceptions.MissingSubjectDependencyException;
import com.example.demo.modules.lessson.domain.usecases.lesson.PostLesson;
import com.example.demo.modules.lessson.domain.usecases.student.GetStudent;
import com.example.demo.modules.lessson.persistence.services.EnrollmentService;
import com.example.demo.modules.lessson.persistence.services.StudentService;

@Service
public class StudentEnrollment {

    @Autowired
    private EnrollmentService enrollmentService;

    @Autowired
    private PostLesson postLesson;

    @Autowired
    private StudentService studentService;

    @Autowired
    private GetStudent getStudent;

    public Student enrollStudent(String studentId, Collection<Lesson> lessons) {
        Student student = getStudent.getOne(studentId);

        for (Lesson lesson : lessons) {
            if (isThereMissingDependency(lesson, student))
                throw new MissingSubjectDependencyException(String.format("Student could not be enrolled " +
                        "in %s as a previous mandatory subject has not been completed.",
                        lesson.getSubject().getName()));
        }

        deleteStudentPreviousEnrollments(student);

        lessons.stream().forEach((lesson) -> {
            student.addLesson(lesson);
            lesson.addStudent(student);
            postLesson.createLesson(lesson);
        });
        Student updatedStudent = studentService.create(student);
        return updatedStudent;

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

    private void deleteStudentPreviousEnrollments(Student student) {
        student.getLessons().stream().forEach((lesson) -> {
            Subject subject = lesson.getSubject();
            Classroom classroom = lesson.getClassroom();
            enrollmentService.deleteEnrollment(subject.getId(), classroom.getId(), student.getId());
        });
    }

}
