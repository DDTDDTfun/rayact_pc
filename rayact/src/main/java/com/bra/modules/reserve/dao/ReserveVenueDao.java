/**
 * Copyright &copy; 2012-2014 <a href="https://github.com.bra.>JeeSite</a> All rights reserved.
 */
package com.bra.modules.reserve.dao;

import com.bra.common.persistence.CrudDao;
import com.bra.common.persistence.annotation.MyBatisDao;
import com.bra.modules.reserve.entity.ReserveVenue;
import com.bra.modules.reserve.entity.form.ReserveVenueProjectFieldDayReport;
import com.bra.modules.reserve.entity.form.ReserveVenueProjectFieldIntervalReport;
import com.bra.modules.reserve.entity.form.ReserveVenueProjectIntervalReport;

import java.util.List;

/**
 * 场馆管理DAO接口
 * @author 肖斌
 * @version 2015-12-29
 */
@MyBatisDao
public interface ReserveVenueDao extends CrudDao<ReserveVenue> {
    List<ReserveVenueProjectFieldDayReport> dayReport(ReserveVenueProjectFieldDayReport dayReport);

    List<ReserveVenueProjectIntervalReport> reserveVenueProjectIntervalReport(ReserveVenueProjectIntervalReport reserveVenueProjectIntervalReport);

    List<ReserveVenueProjectFieldIntervalReport> reserveVenueProjectFieldIntervalReport(ReserveVenueProjectIntervalReport reserveVenueProjectIntervalReport);
}