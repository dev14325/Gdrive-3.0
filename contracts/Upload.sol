// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.5.0 < 0.9.0;
 

 contract Upload {
     struct Access {
         address user;
         bool access;
     }

     mapping(address=>string[]) value;
     mapping(address=>Access[]) accessList;
     mapping(address=>mapping(address=>bool)) ownerShip;
     mapping(address=>mapping(address=>bool)) prevData;

     function add(address _user,string memory url) external{
         value[_user].push(url);
     }

     function allow(address user) external{
         if(prevData[msg.sender][user]==true){
             for(uint i=0;i<accessList[msg.sender].length;i++){
                 if(accessList[msg.sender][i].user==user){
                      accessList[msg.sender][i].access= true;
                 }
             }
         }
         else{
            accessList[msg.sender].push(Access(user,true));
            prevData[msg.sender][user] = true;
         }
         ownerShip[msg.sender][user] = true;
        

     }

     function disAllow(address user) public {
         ownerShip[msg.sender][user] = false;
         for(uint i=0;i<accessList[msg.sender].length;i++){
             if(accessList[msg.sender][i].user == user){
                 accessList[msg.sender][i].access =  false;
             }

         }
     }
     function display(address _user) external view returns(string[] memory){
         require(_user==msg.sender || ownerShip[_user][msg.sender],"You don't have access");
        return  value[_user];

     }

     function shareAccess() external view returns(Access[] memory){
         return accessList[msg.sender];
     }
 }
