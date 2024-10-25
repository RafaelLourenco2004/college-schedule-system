package com.example.demo.modules.lessson.domain.entities;

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
@Table(name = "table", schema = "lesson", catalog = "lesson")
public class Student {

    @Id
    @Column(name = "student_id")
    private String id;

    private String name;

    @ManyToOne()
    @JoinColumn(name = "id")
    private Course course;

    @ManyToMany
    @JoinTable(
        joinColumns = @JoinColumn(name = "student_id"), 
        inverseJoinColumns = @JoinColumn(name = "subject_id")
    )
    private List<Subject> finishedSubjects;

    public void setName(String name) {
        this.name = name;
    }

}
