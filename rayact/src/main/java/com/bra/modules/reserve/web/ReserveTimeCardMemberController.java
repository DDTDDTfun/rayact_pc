package com.bra.modules.reserve.web;

import com.bra.common.config.Global;
import com.bra.common.utils.StringUtils;
import com.bra.common.web.BaseController;
import com.bra.common.web.annotation.Token;
import com.bra.modules.reserve.entity.ReserveCardStatements;
import com.bra.modules.reserve.entity.ReserveMember;
import com.bra.modules.reserve.entity.ReserveTimecardMemberSet;
import com.bra.modules.reserve.entity.ReserveVenue;
import com.bra.modules.reserve.service.ReserveMemberService;
import com.bra.modules.reserve.service.ReserveTimecardMemberSetService;
import com.bra.modules.reserve.service.ReserveVenueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

/**
 * 次卡会员管理
 * Created by jiangxingqi on 2016/1/5.
 */
@Controller
@RequestMapping(value = "${adminPath}/reserve/timeCardMember")
public class ReserveTimeCardMemberController extends BaseController {

    @Autowired
    private ReserveMemberService reserveMemberService;

    @Autowired
    private ReserveTimecardMemberSetService timecardSetService;

    @Autowired
    private ReserveVenueService reserveVenueService;

    @ModelAttribute
    public ReserveMember get(@RequestParam(required=false) String id) {
        ReserveMember entity = null;
        if (StringUtils.isNotBlank(id)){
            entity = reserveMemberService.get(id);
        }
        if (entity == null){
            entity = new ReserveMember();
        }
        return entity;
    }

    @RequestMapping(value = "list")
    public String list(String cartType,ReserveMember reserveMember, HttpServletRequest request, HttpServletResponse response, Model model){
        reserveMember.setCartType("2");
       /* Page<ReserveMember> page = reserveMemberService.findPage(new Page<>(request, response), reserveMember);
        model.addAttribute("page", page);*/
        List<ReserveMember> memberList=reserveMemberService.findList(reserveMember);
        model.addAttribute("memberList", memberList);
        return "reserve/member/timeCardMemberList";
    }
    //储值冲次数
    @RequestMapping(value = "addTimeForm")
    public String addTimeForm(ReserveMember reserveMember, HttpServletRequest request, HttpServletResponse response, Model model){
        reserveMember = reserveMemberService.get(reserveMember);
        model.addAttribute("reserveMember", reserveMember);
        return "reserve/member/timeCardAddForm";
    }
    //次卡充值保存
    @RequestMapping(value = "addTime")
    public String addTime(String id, Double rechargeVolume,int time,String payType,RedirectAttributes redirectAttributes){
        ReserveMember reserveMember = reserveMemberService.get(id);
        int residue=reserveMember.getResidue();
        residue+=time;
        reserveMember.setResidue(residue);
        reserveMemberService.save(reserveMember);
        //记录次卡充值记录
        ReserveCardStatements statement=new ReserveCardStatements();
        statement.setReserveMember(reserveMember);
        statement.setTransactionVolume(rechargeVolume);
        statement.setTransactionType("7");
        statement.setPayType(payType);
        addMessage(redirectAttributes, "保存储值卡会员成功");
        return "redirect:"+ Global.getAdminPath()+"/reserve/timeCardMember/list";
    }

    @RequestMapping(value = "form")
    @Token(save=true)
    public String form(ReserveMember reserveMember, Model model) {
        List<ReserveTimecardMemberSet> timecardSetList=timecardSetService.findList(new ReserveTimecardMemberSet());
        List<ReserveVenue> venueList=reserveVenueService.findList(new ReserveVenue());
        model.addAttribute("venueList", venueList);
        model.addAttribute("timecardSetList", timecardSetList);
        model.addAttribute("reserveMember", reserveMember);
        return "reserve/member/timeCardMemberForm";
    }

    @RequestMapping(value = "save")
    @Token(remove=true)
    public String save(ReserveMember reserveMember, Model model, RedirectAttributes redirectAttributes) {
        reserveMember.setCartType("2");
        if(reserveMember.getResidue()==null){
            reserveMember.setResidue(0);
        }
        if(reserveMember.getId().isEmpty()){
            reserveMember.setValiditystart(new Date());
        }
        if (!beanValidator(model, reserveMember)){
            return form(reserveMember, model);
        }
        reserveMemberService.save(reserveMember);
        addMessage(redirectAttributes, "保存储值卡会员成功");
        return "redirect:"+ Global.getAdminPath()+"/reserve/timeCardMember/list";
    }

    @RequestMapping(value = "delete")
    public String delete(ReserveMember reserveMember, RedirectAttributes redirectAttributes) {
        reserveMemberService.delete(reserveMember);
        addMessage(redirectAttributes, "删除储值卡会员成功");
        return "redirect:"+Global.getAdminPath()+"/reserve/timeCardMember/list";
    }
}
