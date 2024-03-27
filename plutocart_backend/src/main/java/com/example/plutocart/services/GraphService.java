package com.example.plutocart.services;

import com.example.plutocart.auth.JwtUtil;
import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.transaction.GraphDTO;
import com.example.plutocart.dtos.transaction.GraphDetailDTO;
import com.example.plutocart.dtos.transaction.GraphListDTO;
import com.example.plutocart.entities.Graph;
import com.example.plutocart.entities.TransactionCategory;
import com.example.plutocart.exceptions.PlutoCartServiceApiException;
import com.example.plutocart.exceptions.PlutoCartServiceApiForbidden;
import com.example.plutocart.repositories.GraphRepository;
import com.example.plutocart.repositories.TransactionCategoryRepository;
import com.example.plutocart.repositories.TransactionRepository;
import com.example.plutocart.utils.GenericResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.text.StringCharacterIterator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class GraphService {

    @Autowired
    GlobalValidationService globalValidationService;
    @Autowired
    TransactionRepository transactionRepository;
    @Autowired
    TransactionCategoryRepository transactionCategoryRepository;
    @Autowired
    GraphRepository graphRepository;
    @Autowired
    ModelMapper modelMapper;

    @Transactional
    public GenericResponse getTransactionForGraphByAccountId(String accountId, Integer stmType, String token) throws PlutoCartServiceApiException {
        String userId = JwtUtil.extractUsername(token);
        if (userId == null || !userId.equals(accountId))
            throw new PlutoCartServiceApiForbidden(ResultCode.FORBIDDEN, "invalid account id key");

        GenericResponse response = new GenericResponse();
        BigDecimal totalIncome = new BigDecimal(0);

        Integer acId = globalValidationService.validationAccountId(accountId);

        GraphListDTO graphResponse = new GraphListDTO();

        List<Graph> graphList = graphRepository.viewGraphByAccountIdAndStmType(acId, stmType);
//        List<GraphDTO> graphDTOList = graphList.stream().map(graph -> modelMapper.map(graph, GraphDTO.class)).collect(Collectors.toList());

        Map<String, GraphDetailDTO> graphInfoList = new HashMap<>();
        for (int i = 0; i < graphList.size(); i++) {
            GraphDetailDTO graphDTO = new GraphDetailDTO();
//            if (graphInfoList.containsKey(graphList.get(i).getTranCategoryIdCategory().getId())) {
//
//            } else {
                graphDTO.setTransactionCategory(graphList.get(i).getTranCategoryIdCategory());
                graphDTO.setTotalInTransactionCategory(graphList.get(i).getTotalInGraph());

                graphInfoList.put("graphTransactionCategory", graphDTO);
//            }
            totalIncome = totalIncome.add(graphList.get(i).getTotalInGraph());
        }
//        graphResponse.setGraphDTO(graphDTOList);
        graphResponse.setGraphStatementList(graphInfoList);
        graphResponse.setTotalAmount(totalIncome);

        response.setStatus(ResultCode.SUCCESS);
        response.setData(graphResponse);
        return response;
    }
}
