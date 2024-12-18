package com.example.demo.modules.lessson.domain.entities;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "student", schema = "lesson", catalog = "lesson")
public class Student {

    @Id
    @Column(name = "student_id")
    private String id;

    private String name;

    @ManyToOne()
    @JoinColumn(name = "course_id")
    private Course course;

    @ManyToMany
    @JoinTable(
        joinColumns = @JoinColumn(name = "student_id"), 
        inverseJoinColumns = @JoinColumn(name = "subject_id")
    )
    private List<Subject> finishedSubjects;

    public Student(String id, String name, Course course){
        this.id = id;
        this.name = name;
        this.course = course;
        this.finishedSubjects = new ArrayList<>();

    }

    public void setName(String name) {
        this.name = name;
    }

}
