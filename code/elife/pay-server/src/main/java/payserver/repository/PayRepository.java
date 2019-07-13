package payserver.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import payserver.entity.Pay;

import java.math.BigDecimal;
import java.util.List;


/**
 * PayRepository interface
 *
 * @author wyx
 * @date 2019.07.12
 */
public interface PayRepository extends JpaRepository<Pay, Integer> {

    /**
     * save bill without id
     * @param time
     * @param status
     * @param bill
     * @param managerName
     * @param username
     * @param communityId
     */
    @Modifying
    @Transactional(rollbackFor = Exception.class)
    @Query(value=" INSERT INTO pay(time,status,bill,managername,username,community_id) VALUES (?1,?2,?3,?4,?5,?6) ",nativeQuery = true)
    void savePay(String time, int status, BigDecimal bill, String managerName, String username, int communityId);


    /**
     * find newest Pay  by username
     *
     * @param username
     * @return List
     */
    @Query(value=" select * from pay where username=?1 and status=0",nativeQuery = true)
    List<Pay> findNew(String username);

    /**
     * return history from  table
     *
     * @param username
     * @return List
     */
    @Query(value=" select * from pay where username=?1",nativeQuery = true)
    List<Pay> findHistory(String username);

    /**
     * return history which not taken
     *
     * @param communityId
     * @return List
     */
    @Query(value=" select * from pay where status=0 and community_id=?1",nativeQuery = true)
    List<Pay> findUnPayManager(int communityId);
    /**
     * return history which not taken
     *
     * @param communityId
     * @return List
     */
    @Query(value=" select * from pay where status=1 and community_id=?1",nativeQuery = true)
    List<Pay> findPayHistoryManager(int communityId);

}
