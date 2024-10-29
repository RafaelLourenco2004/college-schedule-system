package com.example.demo.modules.lessson.persistence.repositories;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.modules.lessson.domain.entities.Classroom;

@Repository
public interface ClassroomRepository extends JpaRepository<Classroom, UUID>{
    
    boolean existsByName(String name);
}
