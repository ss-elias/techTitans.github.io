// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.18;

contract DisasterDonation {

    /* structure for the donations */
    struct Donation {
        uint256 donationId;
        address donatedBy;
        uint256 amount;
        string message;
        uint256 timestamp;
    }
    struct Campaign {
        uint256 campaignID;
        string CampaignName;
        address donateTo;
        uint256 AmountRequired;
        uint256 date;
    }

    /* state variables */
    mapping(address => Donation[]) internal donations;
    Campaign[] public NewCampaign;
    uint256 public donationCount = 0;
    uint256 internal idCount = 0;
    uint256 internal campaignid;
    address payable public owner;

    /* set the constructor */
    constructor() payable {
        /* deposit ether when the contract is created */
        owner = payable(msg.sender);
    }

    /* event and function to create a new campaign */
    event newCampaign(uint256 cid,string _cname,uint256 _amnt,uint256 time);
    function createCampaign(string memory cname,uint256 amnt) public {
        require(msg.sender == owner,"Only the owner can create a campaign!!");
        uint256 campaignId = idCount++;
        Campaign memory newcampaign  = Campaign({
            campaignID: campaignId,
            CampaignName: cname,
            AmountRequired: amnt,
            donateTo: msg.sender,
            date: block.timestamp+30
        });
        NewCampaign.push(newcampaign);
        emit newCampaign(campaignId, cname, amnt,block.timestamp+30);
    }
    
    /* event and function to deposit a donation */
    event Deposit(address sender,uint256 amount,uint256 _balance);
    function donate(string memory _message,address payable _donatedBy) public payable {

        /* require statements to ensure proper donation */
        require(msg.sender == owner,"ONLY THIS PERSON CAN RECEIVE AN AMOUNT");
        require(msg.value > 0,"YOU HAVE TO DONATE AN AMOUNT");

        uint256 donationId = idCount++;
        Donation memory newDonation = Donation({
            donationId: donationId,
            donatedBy: _donatedBy,
            amount: msg.value,
            message: _message,
            timestamp: block.timestamp
        });
        donations[msg.sender].push(newDonation);
        donationCount++;
        emit Deposit(msg.sender,msg.value,address(this).balance);
    }

    /* function to get the details of a campaign */
    function GetCampaign(uint256 _i) public view returns (Campaign memory) {
        require(_i < NewCampaign.length, "Index out of bounds");
        return NewCampaign[_i];
    }

    /* function to get all the  donations of the organization */
    function getAllDonation(address _owner) public view returns(Donation[] memory) {
        return donations[_owner];
    }

    /* function to get a donation */
    function getDonation(uint256 _i) public view returns(Donation memory) {
        return donations[msg.sender][_i];
    }

    /* function to get the balance of the account */
    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }

    modifier onlyOwner() { /* to ensure only the owner can withdraw the funds */
        require(msg.sender == owner,"You are not the owner");
        _;
    }
    /* function to withdraw funds */
    event Withdraw(uint256 amount,uint256 balance);
    function withdraw(uint256 amt) public onlyOwner{
        owner.transfer(amt);
        emit Withdraw(amt,address(this).balance);
    }

    /* function to transfer funds */
    event Transfer(address to,uint256 _amount,uint256 _bal);
    function transferFunds(address payable sendTo,uint256 amnt) public onlyOwner {
        sendTo.transfer(amnt);
        emit Transfer(sendTo,amnt,address(this).balance);
    }
    
}
