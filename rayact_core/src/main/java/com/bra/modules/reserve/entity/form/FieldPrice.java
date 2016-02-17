package com.bra.modules.reserve.entity.form;

import com.google.common.collect.Lists;

import java.io.Serializable;
import java.util.List;

/**
 * 场地价格
 * Created by xiaobin on 16/1/11.
 */
public class FieldPrice implements Serializable{

    private String venueId;//所属场馆
    private String fieldId;//所属场地
    private String fieldName;//场地名称
    private List<TimePrice> timePriceList = Lists.newArrayList();//(时间:价格)对应关系


    public String getVenueId() {
        return venueId;
    }

    public void setVenueId(String venueId) {
        this.venueId = venueId;
    }

    public String getFieldId() {
        return fieldId;
    }

    public void setFieldId(String fieldId) {
        this.fieldId = fieldId;
    }

    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    public List<TimePrice> getTimePriceList() {
        return timePriceList;
    }

    public void setTimePriceList(List<TimePrice> timePriceList) {
        this.timePriceList = timePriceList;
    }
}