package notice.notice.serviceimpl;

import notice.notice.dao.NoticeDao;
import notice.notice.entity.Notice;
import notice.notice.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * postComments class
 *
 * @author 符永锐
 * @date 2019/07/05*/
@Service

public class NoticeServiceImpl implements NoticeService {
    @Autowired
    private NoticeDao noticeDao;
    @Override
    public int save(Notice notice){
        return noticeDao.save(notice);
    }
    @Override
    public List<Notice> findByUsername(String username){
        return noticeDao.findByUsername(username);
    }
    @Override
    public void deleteAllByUsername(String username){
        noticeDao.deleteAllByUsername(username);
    }
    @Override
    public String deleteByNotcieId(int noticeId){
        return noticeDao.deleteByNotcieId(noticeId);
    }
}
