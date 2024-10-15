package com.example.demo.modules.lessson.domain.entities;

import java.util.UUID;

import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;
import com.example.demo.modules.lessson.persistence.converters.SemesterConverter;

import jakarta.persistence.Column;
import jakarta.persistence.Convert;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "subject", schema = "lesson", catalog = "lesson")
public class Subject {
    
    @Id
    @Column(name = "subject_id")
    private UUID id;

    private String name;

    private Integer credit;

    @Convert(converter = SemesterConverter.class)
    private Semester semester;

    public void setName(String name) {
        this.name = name;
    }

    public void setCredit(Integer credit) throws InvalidAttributeValueException{
        if (credit <= 0) throw new InvalidAttributeValueException("Credit must be greater than 0");
        this.credit = credit;
    }

    public void setSemester(Semester semester) {
        this.semester = semester;
    }

    




}
