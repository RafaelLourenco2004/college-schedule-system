package com.example.demo.modules.lessson.persistence.services;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.entities.LessonId;
import com.example.demo.modules.lessson.domain.entities.LessonTime;
import com.example.demo.modules.lessson.persistence.repositories.LessonDateRepository;
import com.example.demo.modules.lessson.persistence.repositories.LessonRepository;

@Service
public class LessonServiceImpl implements LessonService {

    @Autowired
    private LessonRepository repository;

    @Autowired
    private LessonDateRepository lessonDateRepository;

    public Lesson create(Lesson lesson) {
        return repository.save(lesson);
    }

    @Override
    public List<Lesson> getAll() {
        return repository.findAll();
    }

    @Override
    public Optional<Lesson> getOne(LessonId id) {
        return repository.findById(id);
    }

    @Override
    public void delete(Lesson lesson) {
        List<LessonDate> dates = lesson.getDates();
        dates.stream().forEach((date) -> lessonDateRepository.delete(date));
        repository.deleteById(lesson.getId());
    }

    @Override
    public List<Lesson> getAllLessonsWithinTimeRange(LessonTime start, LessonTime end) {
        LocalTime startTime = LocalTime.parse(start.getTime());
        LocalTime endTime = LocalTime.parse(end.getTime());

        List<Lesson> lessonsWithingTimeRange = new ArrayList<>();

        List<Lesson> lessons = getAll();
        List<LessonDate> dates;
        for (Lesson lesson : lessons) {
            dates = lesson.getDates();
            for (LessonDate date : dates) {
                if (!date.getStartTime().isBefore(startTime) && !date.getStartTime().isAfter(endTime))
                    lessonsWithingTimeRange.add(lesson);
            }
        }
        return lessonsWithingTimeRange;

    }
}
