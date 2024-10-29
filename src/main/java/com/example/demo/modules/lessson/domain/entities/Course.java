package com.example.demo.modules.lessson.domain.entities;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.UUID;
import java.util.List;

import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "course", schema = "lesson", catalog = "lesson")
public class Course {

    @Id
    @Column(name = "course_id")
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    private String name;

    private Integer totalCredits;

    @Column(name = "acronym_id")
    private String acronymId;

    @OneToMany(mappedBy = "course", cascade = CascadeType.REMOVE)
    private List<Subject> subjects;

    @OneToMany(mappedBy = "course")
    private List<Student> enrolledStudents;

    public void setName(String name) {
        this.name = name;
    }

    public void setTotalCredits(Integer totalCredits) {
        if (totalCredits < 0)
            throw new InvalidAttributeValueException("Invalid value for field total credits");
        this.totalCredits = totalCredits;
    }

    public void setAcronymId(String acronymId) {
        this.acronymId = acronymId;
    }
}
