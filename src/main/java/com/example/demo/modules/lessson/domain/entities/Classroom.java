package com.example.demo.modules.lessson.domain.entities;

import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
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
}
