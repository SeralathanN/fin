package com.teamone.tyremonitoring.repository;

import com.teamone.tyremonitoring.model.TyreData;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TyreDataRepository extends JpaRepository<TyreData, Long> {
}
