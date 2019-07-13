package estateforum.estateforum.controller;

import estateforum.estateforum.entity.Post;
import estateforum.estateforum.service.PostCommentsService;
import estateforum.estateforum.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * postComments class
 *
 * @author 符永锐
 * @date 2019/07/04*/
@RequestMapping(path = "/api/post")
@Controller
public class PostController {
    @Autowired
    PostService postService;
    @Autowired
    PostCommentsService postCommentsService;
    @RequestMapping(path = "/addPost")
    @ResponseBody
    public String addPost(@RequestParam String title, @RequestParam String postContent, @RequestParam String posterName,@RequestParam int communityId ){
        if(posterName.equals("")||postContent.equals("")||title.equals("")){
            return "信息不能为空";
        }
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String postTime = df.format(new Date());
        Post post=new Post(title,postContent,postTime,posterName,communityId);
        return postService.save(post);
        //return "发表帖子成功";
    }
    @GetMapping(path = "/findPost")
    @ResponseBody
    public List<Post> findPost(@RequestParam int communityId,@RequestParam int page,@RequestParam int size){
        return postService.findAllByCommunityId(communityId,page,size);
    }
    @GetMapping(path = "/deletePost")
    @ResponseBody String deletePost(@RequestParam String id){
        postService.deletePost(id);
         return "删除成功";
    }

}