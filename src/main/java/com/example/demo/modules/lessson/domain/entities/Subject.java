package com.example.demo.modules.lessson.domain.entities;

import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "subject", catalog = "lesson")
public class Subject {
    
    @Id
    @Column(name = "subject_id")
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    private String name;

    private Integer credit;

    private Semester semester;

    public void setName(String name) {
        this.name = name;
    }

    public void setCredit(Integer credit) throws Exception{
        if (credit <= 0) throw new Exception();
        this.credit = credit;
    }

    public void setSemester(Semester semester) {
        this.semester = semester;
    }

    




}
