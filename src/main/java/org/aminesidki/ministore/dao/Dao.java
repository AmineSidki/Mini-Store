package org.aminesidki.ministore.dao;

import java.util.List;

public interface Dao<T,ID> {
    T get(ID id);
    List<T> getAll();
    T save(T object);
    void delete(ID id);
}
