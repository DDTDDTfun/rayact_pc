package com.bra.modules.reserve.service;

import com.bra.common.service.CrudService;
import com.bra.modules.reserve.dao.FieldPriceSetDao;
import com.bra.modules.reserve.entity.ReserveFieldPriceSet;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by dell on 2016/2/25.
 */
@Service
@Transactional(readOnly = true)
public class FieldPriceSetService extends CrudService<FieldPriceSetDao,ReserveFieldPriceSet> {
}
