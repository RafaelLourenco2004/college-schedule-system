package com.example.demo.modules.lessson.domain.mappers;

import com.example.demo.modules.lessson.domain.dtos.ClassroomDto;
import com.example.demo.modules.lessson.domain.entities.Classroom;

public class ClassroomMapper {
    
    public static ClassroomDto toDto(Classroom classroom){
        ClassroomDto dto = new ClassroomDto();

        dto.setId(classroom.getId());
        dto.setName(classroom.getName());
        dto.setCapacity(classroom.getCapacity());
        dto.setSemester(classroom.getSemester());
        dto.setCourse(CourseMapper.toDto(classroom.getCourse()));

        return dto;

    }

}
