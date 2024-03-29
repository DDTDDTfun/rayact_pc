package com.bra.modules.reserve.web;

import com.bra.common.config.Global;
import com.bra.common.utils.StringUtils;
import com.bra.common.web.BaseController;
import com.bra.common.web.annotation.Token;
import com.bra.modules.reserve.entity.*;
import com.bra.modules.reserve.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

/**
 * 场地订单Controller
 *
 * @author 肖斌
 * @version 2016-01-19
 */
@Controller
@RequestMapping(value = "${adminPath}/reserve/reserveVenueOrder")
public class ReserveVenueOrderController extends BaseController {

    @Autowired
    private ReserveTimecardMemberSetService reserveTimecardMemberSetService;
    @Autowired
    private ReserveVenueOrderService reserveVenueOrderService;
    @Autowired
    private ReserveVenueVisitorsSetService reserveVenueVisitorsSetService;
    @Autowired
    private ReserveTutorService reserveTutorService;
    @Autowired
    private ReserveMemberService reserveMemberService;
    @Autowired
    private ReserveProjectService reserveProjectService;

    @RequestMapping(value = "list")
    public String list(ReserveVenueVisitorsSet visitorsSet, Model model) {
        List<ReserveVenueVisitorsSet> visitorsSets = reserveVenueVisitorsSetService.findList(visitorsSet);
        model.addAttribute("visitorsSets", visitorsSets);

        ReserveProject project = new ReserveProject();
        project.setTicketType("2");
        List<ReserveProject> projects = reserveProjectService.findList(project);
        if (visitorsSet.getProject() != null && StringUtils.isNotBlank(visitorsSet.getProject().getId())) {
            model.addAttribute("projectId", visitorsSet.getProject().getId());
        }
        model.addAttribute("projects", projects);
        return "reserve/visitorsSetOrder/list";
    }

    @RequestMapping(value = "form")
    @Token(save = true)
    public String form(String vsId, Model model) {
        ReserveVenueVisitorsSet set = reserveVenueVisitorsSetService.get(vsId);
        model.addAttribute("visitorsSet",set);
        //教练
        model.addAttribute("tutors", reserveTutorService.findList(new ReserveTutor()));
        //会员
        model.addAttribute("memberList", reserveMemberService.findList(new ReserveMember()));
        return "reserve/visitorsSetOrder/form";
    }
    //确认购买 表单
    @RequestMapping(value = "detail")
    @Token(save = true)
    public String detail(ReserveVenueOrder reserveVenueOrder, Model model) {
        model.addAttribute("venueOrder", reserveVenueOrder);
        return "reserve/visitorsSetOrder/detail";
    }
    //确认购买
    @RequestMapping(value = "save")
    @ResponseBody
  /*  @Token(remove = true)*/
    public String save(ReserveVenueOrder reserveVenueOrder, Model model, RedirectAttributes redirectAttributes) {

        ReserveTimecardMemberSet memberTimecarSet=null;
        ReserveVenueVisitorsSet typeSet = reserveVenueOrder.getVisitorsSet();//获得场次票的属性
        typeSet=reserveVenueVisitorsSetService.get(typeSet);
        ReserveProject p = typeSet.getProject();
        //如果是会员预订
        if(reserveVenueOrder.getMember()!=null&& StringUtils.isNoneEmpty(reserveVenueOrder.getMember().getId())){
            ReserveMember member=reserveMemberService.get(reserveVenueOrder.getMember());
            memberTimecarSet = member.getTimecardSet();//该用户不拥有打折次卡
            if(memberTimecarSet==null){
                return "2";//new ViewResult(false, "该用户没有次卡！");
            }
            memberTimecarSet=reserveTimecardMemberSetService.get(memberTimecarSet);
            ReserveProject project = memberTimecarSet.getReserveProject();

            if(p.getId().equals(project.getId())){
                int residue=member.getResidue();
                int orderResidue=reserveVenueOrder.getCollectCount();
                if(orderResidue>residue){
                    return "3";//new ViewResult(false, "该用户剩余次数不足！剩余次数="+residue);
                }
                residue-=orderResidue;//次数减
                member.setResidue(residue);
                reserveMemberService.save(member);
                reserveVenueOrderService.save(reserveVenueOrder);//会员预订保存
            }else{
                return "4";//new ViewResult(false, "该用户的次票不可在该场地使用！");
            }
        }else{
            reserveVenueOrderService.save(reserveVenueOrder);//非会员
        }
        return "1";//new ViewResult(true, "保存成功");
    }

    @RequestMapping(value = "delete")
    public String delete(ReserveVenueOrder reserveVenueOrder, RedirectAttributes redirectAttributes) {
        reserveVenueOrderService.delete(reserveVenueOrder);
        addMessage(redirectAttributes, "删除场地订单成功");
        return "redirect:" + Global.getAdminPath() + "/reserve/reserveVenueOrder/?repage";
    }

}