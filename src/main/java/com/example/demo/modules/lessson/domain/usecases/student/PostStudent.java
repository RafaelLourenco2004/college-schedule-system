package com.example.demo.modules.lessson.domain.usecases.student;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Course;
import com.example.demo.modules.lessson.domain.entities.Student;
import com.example.demo.modules.lessson.domain.exceptions.EntityAlreadyExistsException;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;
import com.example.demo.modules.lessson.domain.usecases.course.GetCourse;
import com.example.demo.modules.lessson.persistence.services.StudentService;

@Service
public class PostStudent {

    @Autowired
    private StudentService studentService;

    @Autowired
    private GetCourse courseService;

    private final String idErrorMessage = "The id field must abide the following pattern:\n\n" +
            "- contains at least 1 uppercase letter\n" +
            "- contains at least 1 lowercase letter\n" +
            "- contains at least 1 digit\n" +
            "- contains at least 1 symbol\n" +
            "- contains 8 charachters exactly.";

    public Student create(String id, String name, UUID courseId) {
        if (!isIdValid(id))
            throw new InvalidAttributeValueException(idErrorMessage);

        if (studentService.existsById(id))
            throw new EntityAlreadyExistsException(String.format("The id %s is already being used", id));

        Course course = courseService.getOne(courseId);
        Student student = new Student(id, name, course);
        Student newStudent = studentService.create(student);
        return newStudent;

    }

    private boolean isIdValid(String id) {
        return id.matches("^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[\\W_]).{8}$");
    }
}
