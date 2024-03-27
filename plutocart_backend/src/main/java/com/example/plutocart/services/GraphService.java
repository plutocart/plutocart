package com.example.plutocart.services;
import com.example.plutocart.auth.JwtUtil;
import com.example.plutocart.constants.ResultCode;
import com.example.plutocart.dtos.transaction.GraphDetailDTO;
import com.example.plutocart.dtos.transaction.GraphListDTO;
import com.example.plutocart.entities.Graph;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        BigDecimal totalAmountOther = new BigDecimal(0);
        BigDecimal totalAmount = new BigDecimal(0);

        Integer acId = globalValidationService.validationAccountId(accountId);

        GraphListDTO graphResponse = new GraphListDTO();

        List<Graph> graphList = graphRepository.viewGraphByAccountIdAndStmType(acId, stmType);
//        List<GraphDTO> graphDTOList = graphList.stream().map(graph -> modelMapper.map(graph, GraphDTO.class)).collect(Collectors.toList());
        Map<Integer, GraphDetailDTO> graphInfoList = new HashMap<>();
        for (int i = 0; i < graphList.size(); i++) {
            GraphDetailDTO graphDTO = new GraphDetailDTO();
//            if (graphInfoList.containsKey(graphList.get(i).getTranCategoryIdCategory().getId())) {
//
//            } else {
                graphDTO.setTransactionCategory(graphList.get(i).getTranCategoryIdCategory());
                graphDTO.setTotalInTransactionCategory(graphList.get(i).getTotalInGraph());

                graphInfoList.put(i, graphDTO);
//            }

            if(i > 4){
                totalAmountOther = totalAmountOther.add(graphList.get(i).getTotalInGraph());
            }
            
            totalAmount = totalAmount.add(graphList.get(i).getTotalInGraph());
        }
//        graphResponse.setGraphDTO(graphDTOList);
        graphResponse.setGraphStatementList(graphInfoList);
        graphResponse.setTotalAmountOther(totalAmountOther);
        graphResponse.setTotalAmount(totalAmount);

        response.setStatus(ResultCode.SUCCESS);
        response.setData(graphResponse);
        return response;
    }
}
