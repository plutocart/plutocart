package com.example.plutocart.controller;

import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.services.GraphService;
import com.example.plutocart.utils.GenericResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class GraphController {

    @Autowired
    GraphService graphService;

    @GetMapping("/account/{account-id}/graph/{stm-type}")
    private ResponseEntity<GenericResponse> getTransactionForGraphByAccountId(@RequestHeader("Authorization") String token,
                                                                              @PathVariable("account-id") String accountId,
                                                                              @PathVariable("stm-type") Integer stmType) throws PlutoCartServiceApiException {
        GenericResponse result = graphService.getTransactionForGraphByAccountId(accountId, stmType, token);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }
}
