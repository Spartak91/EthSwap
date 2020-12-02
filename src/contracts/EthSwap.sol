pragma solidity ^0.5.12;

import "./Token.sol";


contract EthSwap {
	string public name ="EthSwap Instant Exchange";
	Token public token;
	uint public rate = 100;

	event TokensPurchased(
		address account,
		address token,
		uint amount,
		uint rate
		);

event TokensSold(
		address account,
		address token,
		uint amount,
		uint rate
		);


	constructor(Token _token) public {
		token = _token;
	}




function buyTokens() public payable {
	uint tokenAmount = msg.value * rate;  //msg.value = how much ether was sent when this value was called
	
	require(token.balanceOf(address(this)) >= tokenAmount);   //balance eth swap

	token.transfer(msg.sender, tokenAmount);


 	emit TokensPurchased(msg.sender, address(token), tokenAmount, rate);
}

function sellTokens(uint _amount) public {
//user cant sell more tokens than they have
require(token.balanceOf(msg.sender) >= _amount);

//calculate amount eth
uint etherAmount = _amount / rate;

require (address(this).balance >= etherAmount);


//preform sell
token.transferFrom(msg.sender, address(this), _amount);
msg.sender.transfer(etherAmount);

emit TokensSold(msg.sender, address(token), _amount, rate);

}

}