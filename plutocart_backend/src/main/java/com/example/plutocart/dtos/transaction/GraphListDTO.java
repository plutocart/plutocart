package com.example.plutocart.dtos.transaction;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Getter
@Setter
public class GraphListDTO {
    private Map<String, GraphDetailDTO> graphStatementList;
    private BigDecimal totalAmount;
}
