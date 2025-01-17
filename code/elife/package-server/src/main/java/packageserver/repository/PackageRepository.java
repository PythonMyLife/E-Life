package packageserver.repository;

import packageserver.entity.Package;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;


/**
 * PackageRepository interface
 *
 * @author wyx
 * @date 2019.07.12
 */
public interface PackageRepository extends JpaRepository<Package, Integer> {

    /**
     * save package without id
     * @param time
     * @param status
     * @param managerName
     * @param username
     * @param communityId
     */
    @Modifying
    @Transactional(rollbackFor = Exception.class)
    @Query(value=" INSERT INTO package(time,status,managername,username,community_id) VALUES (?1,?2,?3,?4,?5) ",nativeQuery = true)
    void savePackage(String time, int status,String managerName,  String username,int communityId);


    /**
     * find newest package  by username
     *
     * @param username
     * @return List
     */
    @Query(value=" select * from package where username=?1 and status=0 order by id desc" ,nativeQuery = true)
    List<Package> findNew(String username);

    /**
     * return history from  table
     *
     * @param username
     * @param right
     * @param left
     * @return List
     */
    @Query(value=" select * from package where username=?1 order by id desc limit ?2,?3",nativeQuery = true)
    List<Package> findHistory(String username,int left,int right);

    /**
     * return history which not taken
     *
     * @param communityId
     * @param right
     * @param left
     * @return List
     */
    @Query(value=" select * from package where status=0 and community_id=?1 order by id desc limit ?2,?3",nativeQuery = true)
    List<Package> findHistoryManager(int communityId,int left,int right);



    @Query(value="select * from package  where username=?1",nativeQuery = true)
    List<Package> findPageNum(String username);

    @Modifying
    @Transactional(rollbackFor = Exception.class)
    @Query(value="select * from package b where community_id=?1 and status=0",nativeQuery = true)
    List<Package> findPageNumManager(int communityId);


}

