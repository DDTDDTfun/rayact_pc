package com.bra.modules.reserve.dao;

import com.bra.common.persistence.CrudDao;
import com.bra.common.persistence.annotation.MyBatisDao;
import com.bra.modules.reserve.entity.ReserveVenueConsItem;

import java.util.List;

/**
 * 场地预定
 * DAO接口
 * @author 11
 * @version 2016-01-06
 */
@MyBatisDao
public interface ReserveVenueConsItemDao extends CrudDao<ReserveVenueConsItem> {
    /**
     * 根据手机号码查询
     */
    List<ReserveVenueConsItem> findVenueConsByMoblie(ReserveVenueConsItem reserveVenueCons);

    List<ReserveVenueConsItem> findListByDate(ReserveVenueConsItem reserveVenueCons);

}