package com.example.demo.modules.lessson.domain.usecases.lesson.creation;

import java.time.Duration;
import java.util.regex.Pattern;
import java.lang.StringBuilder;

import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;

import java.util.regex.Matcher;

public class DurationPatternFormatterImpl implements DurationPatternFormatter {

    private Pattern pattern;

    public DurationPatternFormatterImpl() {
        pattern = Pattern.compile("^(?:[0-9]|[1-5][0-9]|(?:[01]?[0-9]|2[0-3]):[0-5][0-9])$");
    }

    public Duration getDuration(String str) throws InvalidAttributeValueException {
        String durationPattern = getDurationPattern(str);
        Duration duration = Duration.parse(durationPattern);
        return duration;
    }

    private String getDurationPattern(String str) throws InvalidAttributeValueException {
        doesItMatch(str);
        StringBuilder builder = new StringBuilder("PT");

        String pattern = str.trim();
        if (pattern.length() == 2) {
            builder.append(pattern);
            builder.append("M");
        } else {
            String time[] = pattern.split(":");
            builder.append(time[0]);
            builder.append("H");
            builder.append(time[1]);
            builder.append("M");
        }
        return builder.toString();

    }

    private void doesItMatch(String str) throws InvalidAttributeValueException {
        Matcher matcher = pattern.matcher(str);
        if (!matcher.matches())
            throw new InvalidAttributeValueException(
                    "Lesson Duratio does not follow the expected pattern.");
    }
}
