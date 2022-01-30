pragma solidity ^0.8.3;

contract RawMaterial {
   
    
    struct Materialdetails{
        
        uint prod_id;
        string name;
        uint weight;
        string  description;
        string  origin;
        address CurrentOwner;
        address[] PrevOwner;
        
    }
    mapping(uint => Materialdetails) public details;
    uint timestamp;
     address ContractOwner;
 
    constructor() public{
        ContractOwner = msg.sender;
        timestamp = block.timestamp;
    }
    
    function uploadMaterial(uint _prod_id,string memory _name, uint _weight, string memory _description, string memory _origin, address _CurrentOwner) public returns(bool){
        
        address[]memory array;
        details[_prod_id] = Materialdetails(_prod_id,_name,_weight,_description,_origin, _CurrentOwner, array);
        return true;
    }
    
    function transferMaterial(uint _prod_id, address _NewOwner) public returns(bool){
        // transactie overdracht van waarde ether
        require(details[_prod_id].CurrentOwner == msg.sender, "YOU are not the owner of this Raw materials");
        require(details[_prod_id].CurrentOwner != _NewOwner);
        details[_prod_id].PrevOwner.push(details[_prod_id].CurrentOwner);
        details[_prod_id].CurrentOwner = _NewOwner;
        return true;
    
    }
    
    function getDetails(uint _prod_id) public view returns(address CURRENT_OWNER, address[] memory PREVIOUS_OWNER){
        return(details[_prod_id].CurrentOwner, details[_prod_id].PrevOwner);
        
    }
}