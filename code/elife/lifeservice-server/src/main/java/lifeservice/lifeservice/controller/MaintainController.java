package lifeservice.lifeservice.controller;

import lifeservice.lifeservice.entity.Maintain;
import lifeservice.lifeservice.service.MaintainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * postComments class
 *
 * @author 符永锐
 * @date 2019/07/09*/
@RequestMapping(path = "/api/maintain")
@Controller
public class MaintainController {
    @Autowired
    private MaintainService maintainService;

    @RequestMapping(path = "/addMaintain")
    @ResponseBody
    public String addMaintain(@RequestParam String content, @RequestParam String username,@RequestParam String userphone){
        if("".equals(content)||"".equals(username)||"".equals(userphone)){
            return "信息不能为空";
        }
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String maintainTime = df.format(new Date());
        Maintain maintain=new Maintain(maintainTime,content,username,userphone);
        long saveReult=maintainService.saveMaintian(maintain);
        System.out.println(saveReult);
        if(saveReult!=0){
            return "增加物业维修请求成功";
        }else {
            return "增加物业维护请求失败";
        }

    }
    /**
     * 难点*/
    @RequestMapping(path = "/managerFindUnMaintain")
    @ResponseBody
    public List<Maintain> managerFindUnMaintain(@RequestParam int communityId,@RequestParam int pageNumber,@RequestParam int pageSize){

        return maintainService.findMaintainByCommunityId(communityId,pageNumber,pageSize);
    }
    @RequestMapping(path = "/managerFindHaveMaintain")
    @ResponseBody
    public List<Maintain> managerFindHaveMaintain(@RequestParam int communityId,@RequestParam int pageNumber,@RequestParam int pageSize){

        return maintainService.findHaveMaintainByCommunityId(communityId,pageNumber,pageSize);
    }
    @RequestMapping(path = "/userFindMaintain")
    @ResponseBody
    public List<Maintain> userFindMaintain(@RequestParam String username){
        List<Maintain> maintainList= maintainService.findbyUsernameAndStatus(username);
        if(!maintainList.isEmpty()){
            return maintainList;
        }
        else {
            return null;
        }
    }
    @RequestMapping(path = "/manageMaintain")
    @ResponseBody String manageMaintain(@RequestParam long id,@RequestParam int status,@RequestParam String maintainname,@RequestParam String phone,@RequestParam String managername){
        String managerResult= maintainService.managerMaintain(id,status,maintainname,phone,managername);
        if(managerResult.equals("完成管理物业维修")){
            return "完成管理物业维修";
        }
        return "管理物业维修失败";
    }
    @RequestMapping(path = "/editMaintain")
    @ResponseBody String editMaintain(@RequestParam long id,@RequestParam int status){
        String editResult=maintainService.userEditMaintain(id, status);
        if(editResult.equals("修改物业维修状态成功")){
            return "修改物业维修状态成功";
        }
        return "修改物业维修状态失败";
    }
    @RequestMapping(path = "/countMaintain")
    @ResponseBody
    public long countMaintain(@RequestParam int communityId){

        return maintainService.countMaintain(communityId);
    }
}