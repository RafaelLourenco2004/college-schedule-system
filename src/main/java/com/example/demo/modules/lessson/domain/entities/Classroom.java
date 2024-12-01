package com.example.demo.modules.lessson.domain.entities;

import java.util.UUID;

import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "classroom", schema = "lesson", catalog = "lesson")
public class Classroom {

    @Id
    @Column(name = "classroom_id")
    private UUID id;

    private String name;

    private Integer capacity;

    private Semester semester;

    @ManyToOne()
    @JoinColumn(name = "course_id")
    private Course course;

    public String getCourseAcronymId() {
        return course.getAcronymId();
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCapacity(Integer capacity) {
        this.capacity = capacity;
    }

    public void setSemester(Semester semester) {
        if (semester == null)
            throw new InvalidAttributeValueException("Semester must be between 1 and 8.");
        this.semester = semester;
    }

    public void setCourse(Course course) {
        this.course = course;
    }
}
