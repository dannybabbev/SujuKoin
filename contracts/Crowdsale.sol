pragma solidity ^0.4.8;


contract token { function transferFrom(address sender, address receiver, uint amount){  } }

contract Crowdsale {
    address public beneficiary;
    address public tokenAdmin;
    uint public fundingGoal; uint public amountRaised; uint public deadline; uint public price;
    token public tokenReward;
    mapping(address => uint256) public balanceOf;
    bool fundingGoalReached = false;
    event GoalReached(address beneficiary, uint amountRaised);
    event FundTransfer(address backer, uint amount, bool isContribution);
    bool public crowdsaleClosed = false;

    /* data structure to hold information about campaign contributors */

    /*  at initialization, setup the owner */
    function Crowdsale() {
        beneficiary = ;
        // Token admin address with total supply. Admin must approve transctions!
        tokenAdmin = ;
        // Finding goal in ether
        fundingGoal = 1 * 1 ether;
        // Length of sale in weeks
        deadline = now + 4 * 1 weeks;
        // Price of 1 token in ethers / decimals
        price = 0.01 / 100 * 1 ether;
        // Token used as reward address
        tokenReward = token(0xd0F820b980f9a08D407c49c2B9102EAb532b09A3);
    }

    /* The function without name is the default function that is called whenever anyone sends funds to a contract */
    function () payable {
        if (crowdsaleClosed) revert();
        uint amount = msg.value;
        balanceOf[msg.sender] = amount;
        amountRaised += amount;
        tokenReward.transferFrom(tokenAdmin, msg.sender, amount / price);
        FundTransfer(msg.sender, amount, true);
    }

    modifier afterDeadline() { if (now >= deadline) _; }

    /* checks if the goal or time limit has been reached and ends the campaign */
    function checkGoalReached() afterDeadline {
        if (amountRaised >= fundingGoal){
            fundingGoalReached = true;
            GoalReached(beneficiary, amountRaised);
        }
        crowdsaleClosed = true;
    }

    function safeWithdrawal() afterDeadline {
        if (beneficiary == msg.sender) {
            if (beneficiary.send(amountRaised)) {
                FundTransfer(beneficiary, amountRaised, false);
            }
        }
    }
}
