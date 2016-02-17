package com.bra.modules.reserve.service;

import com.bra.common.service.CrudService;
import com.bra.common.utils.DateUtils;
import com.bra.modules.reserve.dao.SmsDao;
import com.bra.modules.reserve.entity.Sms;
import com.bra.modules.reserve.utils.SmsUtils;
import org.apache.commons.collections.MapUtils;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by xiaobin on 16/2/17.
 */
public class SmsService extends CrudService<SmsDao, Sms> {

    public static final String apiKey = "d2baec7b5b432e059e4805aa58d76d96";
    private int randCount = 4;                      //验证码位数


    public Sms findByMobile(Sms sms) {
        return dao.findMobile(sms);
    }

    /**
     * 随机生成注册验证码并保存
     *
     * @return
     */
    @Transactional(readOnly = false)
    public boolean sendSms(Sms sms) {
        synchronized (apiKey) {
            Date date = DateUtils.addMinutes(new Date(), -1);
            sms.setCreateDate(date);
            //查询数据库记录
            Sms _sms = findByMobile(sms);
            if (_sms == null) {
                try {
                    //产生随机数
                    String randomStr = SmsUtils.getMobileCode(randCount);
                    //String json = SmsUtils.sendSms(apiKey, text + ":" + randomStr, sms.getMobile());
                    //Map<String,Object> statusCode = JsonUtils.readObjectByJson(json, Map.class);
                    Map<String, Object> statusCode = new HashMap<>();
                    statusCode.put("code", "1");
                    _sms = new Sms();
                    if (!"0".equals(MapUtils.getString(statusCode, "code"))) {
                        _sms.setMobile(sms.getMobile());
                        _sms.setCreateDate(DateUtils.addDays(new Date(), -10));
                        _sms.setMobileCode("发送失败");
                        _sms.setServiceId(sms.getServiceId());
                        _sms.setDelFlag("0");
                        return false;
                    } else {
                        _sms.setMobile(sms.getMobile());
                        _sms.setCreateDate(new Date());
                        _sms.setMobileCode(randomStr);
                        _sms.setServiceId(sms.getServiceId());
                        _sms.setDelFlag("0");
                    }
                    sms.preInsert();
                    dao.insert(sms);
                } catch (Exception e) {
                    return false;
                }
            } else {
                return false;
            }
            return true;
        }

    }


}