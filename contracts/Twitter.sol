// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

contract Twitter {

    uint16 public MAX_LENGTH_TWEET = 250;

    //struct
    struct Tweet {
        uint id;
        address author;
        string content;
        uint timestamp;
        uint likes;
    }

    mapping (address => Tweet[]) public tweets;
    address public owner;

    event tweetCreated(uint id, address author, string content, uint timestamp);
    event tweetLiked(address liker, address tweetAuthor, uint tweetId, uint likeCount);
    event tweetUnlike(address unliker, address tweetAuthor, uint tweetId, uint likecount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "YOU ARE NOT A OWNER!!");
        _;
    }

    function changeLengthTweet(uint16 newTweetLength) public onlyOwner {
        MAX_LENGTH_TWEET = newTweetLength;
    }

    function createTweet(string memory _tweet) public {
        require (bytes(_tweet).length <= MAX_LENGTH_TWEET, "Tweet is to long!!");

        Tweet memory newTweet = Tweet({ 
            id: tweets[msg.sender].length,
            author : msg.sender,
            content : _tweet,
            timestamp : block.timestamp,
            likes : 0
        });

        tweets[msg.sender].push(newTweet); 
        emit tweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp); 
    }
    
    function likeTweet(address author, uint id) external {
        require(tweets[author][id].id == id, "TWEET DOES NOT EXIST!!");
        tweets[author][id].likes++;
        emit tweetLiked(msg.sender, author, id, tweets[author][id].likes); 
    }
    function unlikeTweet(address author, uint id) external {
        require(tweets[author][id].id == id, "TWEET DOES NOT EXIST!!");
        require(tweets[author][id].likes > 0, "TWEET NOT HAVE LIKE!!");
        tweets[author][id].likes--;
        emit tweetUnlike(msg.sender, author, id, tweets[author][id].likes); 
    }

    function getTweet(uint _i) public view returns(Tweet memory){
        return tweets[msg.sender][_i];
    }

    function getAllTweet() public view returns(Tweet[] memory) { 
        return tweets[msg.sender]; 
    }
}
