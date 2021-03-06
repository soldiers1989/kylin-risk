package com.rkylin.risk.core.service;

import com.rkylin.risk.core.entity.Authorization;
import com.rkylin.risk.core.entity.RiskGradeMerc;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 201508240185 on 2015/9/16.
 */
public interface RiskGradeMercService {

    List<HashMap> queryPayGradeMerc(Map<String, Object> map);

    RiskGradeMerc queryById(Integer id);

    RiskGradeMerc update(RiskGradeMerc grade);

    boolean updateRiskGradeList(String ids, String updateGrade, String reason, Authorization auth);

    boolean updateRiskStatusList(String ids, String status, Authorization auth);
}
