package estateforum.estateforum.forumdao;

import estateforum.estateforum.formentity.Post;

import java.util.List;

/**
 * postComments class
 *
 * @author 符永锐
 * @date 2019/07/04*/
public interface PostDao {
    /**
     * 此函数存一条帖子
     * @param post 帖子*/
    void save(Post post);
    /**
     * 此函数以列表形式返回所有帖子
     * @return 以列表形式返回的所有帖子*/
    List<Post> findAll();
}
