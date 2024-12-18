package com.example.demo.modules.lessson.persistence.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.modules.lessson.domain.entities.Student;

@Repository
public interface StudentRepositoty extends JpaRepository<Student, String>{
    
}
