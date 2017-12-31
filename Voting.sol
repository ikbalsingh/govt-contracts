pragma solidity ^0.4.0;

import "registration.sol";
import "SafeMath.sol";

contract VotingContract {
    using SafeMath for uint;


    CitizenRegistration _citizenInfo =  CitizenRegistration(0xbbf289d846208c16edc8474705c748aff07732db);
    uint id = 1;
    struct _Issue{
        string[2] _votingOptions;
        string _description;
        mapping (string => uint) votes;
        uint  _IssueID;
    }
    _Issue[] _Issues;
    mapping (uint => _Issue) _validIssues;
    mapping (address => uint) _votedCitizens;



    modifier _hasVotedBefore(address addr,uint issid){
        if(_votedCitizens[addr] == issid ){
            revert();
        }
        _;
    }
    function createIssue(string desc, string option1,string option2) public returns (uint){
        _Issue memory newIssue = _Issue([option1,option2],desc,id);
        _Issues.push(newIssue);
        _validIssues[id] = newIssue;
        id = id.add(1);
        return id.sub(1);
    }

    function voteForAnIssue (uint IssueID,string option) public _hasVotedBefore(msg.sender,IssueID) {
        _validIssues[IssueID].votes[option]++;
        _votedCitizens[msg.sender] = IssueID;
    }

    function getWinnerOption(uint IssueID) public view returns (string)  {
        var iss = _validIssues[IssueID];
        if(iss.votes[iss._votingOptions[0]] > iss.votes[iss._votingOptions[1]]){
           return iss._votingOptions[0];
        }else if(iss.votes[iss._votingOptions[0]] < iss.votes[iss._votingOptions[1]]){
            return  iss._votingOptions[1];
        }else{
            return "IT IS A TIE";
        }
    }
}
