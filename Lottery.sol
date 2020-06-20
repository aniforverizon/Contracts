pragma solidity ^0.4.17;


contract Lottery{
    
    address public manager;
    
    address public winner;
    
    address[] public players;
    //first person instantiating the ccontract
    function Lottery() public {
        manager=msg.sender;
    }
    
    //to get a lottery ticket buy the ticket
    function enter() public payable{
        require(msg.value>0.01 ether);
        players.push(msg.sender);
        
    }
    
    function RandomGenerator() private view returns(uint){
        return uint(keccak256(block.difficulty,now ,players));
    }
    
    function pickWinner() public restricted{
        uint index=RandomGenerator()% players.length;
        
        players[index].transfer(this.balance);
        winner =players[index];
        players=new address[](0);
    }
    
    function getPlayers() public view returns ( address [] memory){
        return players;
    }
    
    modifier restricted(){
        require(msg.sender==manager);
        _;
    }
}
