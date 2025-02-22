package com.example.demo.modules.lessson.domain.usecases.lesson;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonId;
import com.example.demo.modules.lessson.domain.entities.LessonTime;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.persistence.services.LessonService;

@Service
public class GetLesson {

    @Autowired
    private LessonService lessonService;

    public List<Lesson> getAll() {
        return lessonService.getAll();
    }

    public Lesson getOne(LessonId id) {
        return lessonService.getOne(id).orElseThrow(() -> new NotFoundException(
                "Could not find lesson of id %s."));
        // return lessonService.getOne(id).orElseThrow(() -> new NotFoundException(
        // String.format("Could not find lesson of id %s.", id.toString())));
    }

    public List<Lesson> getAllLessonsWithinTimeRange(String start, String end) {
        LessonTime startTime = LessonTime.toLessonTime(start);
        LessonTime endTime = LessonTime.toLessonTime(end);

        if (startTime == null || endTime == null)
            throw new InvalidAttributeValueException(
                    "Time range provided does not follow the expected pattern HH:mm");

        List<Lesson> lessonsWithinTimeRange = lessonService.getAllLessonsWithinTimeRange(startTime, endTime);
        return lessonsWithinTimeRange;
    }
}
