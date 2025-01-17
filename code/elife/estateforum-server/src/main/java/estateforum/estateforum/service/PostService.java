package estateforum.estateforum.service;

import estateforum.estateforum.entity.Post;
import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

/**
 * postComments class
 *
 * @author 符永锐
 * @date 2019/07/04
 * @author ztHou
 * @date 2019/08/15
 * */

public interface PostService {
    /**
     * 此函数存一条帖子
     * @param title 帖子
     * @param postContent post content
     * @param tag tag
     * @param posterName poster name
     * @param communityId community id
     * @param photo photo
     * @return 返回成功储存的id号*/
    String save(String title, String tag, String postContent, String posterName, int communityId, List<MultipartFile> photo) throws IOException;
    /**
     * 此函数以列表形式返回所有帖子
     * @return 以列表形式返回的所有帖子
     * @param communityId 小区id
     * @param page 当前页数
     * @param size 大小*/
    JSONArray findAllByCommunityId(int communityId, int page, int size)throws IOException;
    /**
     *该方法返回特定id的的帖子
     * @param  id 指定的帖子id
     * @return 返回指定的帖子*/
    Post findPost(String id);
    /**
     *该方法删除特定pid的的帖子
     * @param  id 指定的帖子id*/
    void deletePost(String id);

    /**
     * 该方法返回大图
     * @param path 图片路径
     * @return 大图
     */
    JSONObject getBigPhoto(String path);

    /**
     * 该方法返回小区所有的标签
     * @param communityId 小区id
     * @return 标签列表
     */
    JSONArray getAllTags(Long communityId);

    /**
     * 此函数以列表形式返回所有帖子
     * @return 以列表形式返回的所有帖子
     * @param communityId 小区id
     * @param tag 标签
     * @param page 当前页数
     * @param size 大小*/
    JSONArray findAllByCommunityIdAndTag(int communityId, String tag, int page, int size)throws IOException;

}
