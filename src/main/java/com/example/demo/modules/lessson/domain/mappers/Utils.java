package com.example.demo.modules.lessson.domain.mappers;

import java.util.Optional;

import com.example.demo.modules.lessson.domain.exceptions.MissingFieldException;

public class Utils {

    public static Object getOrThrowIfMissing(Object o, String entity) {
        return Optional.ofNullable(o).orElseThrow(
                () -> new MissingFieldException(String.format("All fiels of %s must be provided", entity)));
    }
}
