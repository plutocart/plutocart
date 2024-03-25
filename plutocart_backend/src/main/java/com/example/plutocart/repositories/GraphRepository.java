package com.example.plutocart.repositories;

import com.example.plutocart.entities.Graph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface GraphRepository extends JpaRepository<Graph, Integer> {

    @Transactional
    @Procedure(procedureName = "viewGraphByAccountIdAndStmType")
    List<Graph> viewGraphByAccountIdAndStmType(Integer accountId, Integer stmType);

}
