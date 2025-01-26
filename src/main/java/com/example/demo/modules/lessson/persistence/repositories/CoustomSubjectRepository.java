package com.example.demo.modules.lessson.persistence.repositories;

import com.example.demo.modules.lessson.domain.entities.Subject;

public interface CoustomSubjectRepository {

    void persistSubject(Subject subject);

    void flushChanges();
}
