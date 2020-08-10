## 1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.
use ipl;

select BIDDER_ID,sum(if(BID_STATUS='Won',1,0)) as No_of_wins,
sum(if(BID_STATUS='Lost',1,0)) as No_of_Loss,
sum(if(BID_STATUS='Won',1,0))+sum(if(BID_STATUS='Lost',1,0))+sum(if(BID_STATUS='bid',1,0)) as Total_betting,
(sum(if(BID_STATUS='Won',1,0))/(sum(if(BID_STATUS='Won',1,0))+sum(if(BID_STATUS='Lost',1,0))+sum(if(BID_STATUS='bid',1,0))))*100 as percentage_of_wins
from ipl_bidding_details
group by BIDDER_ID
order by 5 desc;

## 2.	Display the number of matches conducted at each stadium with stadium name, city from the database.

select STADIUM_NAME,CITY,count(ims.STADIUM_ID) as No_of_matches
from ipl_stadium join ipl_match_schedule ims using (STADIUM_ID)
group by STADIUM_NAME;

## 3.	In a given stadium, what is the percentage of wins by a team which has won the toss?

SELECT * FROM ipl.ipl_match;
set sql_safe_updates=0;
update ipl_match set MATCH_WINNER=2 where MATCH_WINNER>2;

select STADIUM_NAME,CITY,round(sum(if(TOSS_WINNER=MATCH_WINNER,1,0))/count(if(TOSS_WINNER=MATCH_WINNER,1,0)),2) as Per_of_Wins
from ipl_stadium join ipl_match_schedule ims using (STADIUM_ID)
join ipl_match using (MATCH_ID)
group by STADIUM_NAME;

## 4.	Show the total bids along with bid team and team name.

select TEAM_NAME,BID_TEAM,count(BIDDER_ID) as no_of_bids
from ipl_team it join ipl_bidding_details ibd on it.TEAM_ID=ibd.BID_TEAM
group by TEAM_NAME
order by 2;

## 5.	Show the team id who won the match as per the win details.

select TEAM_ID1,TEAM_ID2,WIN_DETAILS,if(MATCH_WINNER=1,TEAM_ID1,TEAM_ID2) Win_Team_ID,TEAM_NAME
from ipl_match im join ipl_team it
on it.TEAM_ID=if(MATCH_WINNER=1,TEAM_ID1,TEAM_ID2);

## 6.	Display total matches played, total matches won and total matches lost by team along with its team name.

select TEAM_NAME,its.TEAM_ID,sum(MATCHES_PLAYED) Total_Matches_Played,
sum(MATCHES_WON) Total_Matches_Won,
sum(MATCHES_LOST) Total_Matches_Lost
from ipl_team join ipl_team_standings its using (TEAM_ID)
group by TEAM_NAME;

## 7.	Display the bowlers for Mumbai Indians team.

select TEAM_NAME,PLAYER_NAME,PLAYER_ROLE
from ipl_team join ipl_team_players using (TEAM_ID)
join ipl_player using (PLAYER_ID)
group by TEAM_NAME,PLAYER_NAME,PLAYER_ROLE
having TEAM_NAME='Mumbai Indians' and PLAYER_ROLE='Bowler';

## 8.	How many all-rounders are there in each team, Display the teams with more than 4 
## all-rounder in descending order.

select TEAM_NAME,count(PLAYER_ROLE) as No_of_Players
from ipl_team join ipl_team_players using (TEAM_ID)
join ipl_player using (PLAYER_ID)
where PLAYER_ROLE='All-Rounder'
group by TEAM_NAME
order by No_of_Players desc;

select TEAM_NAME,count(PLAYER_ROLE) as No_of_Players
from ipl_team join ipl_team_players using (TEAM_ID)
join ipl_player using (PLAYER_ID)
where PLAYER_ROLE='All-Rounder'
group by TEAM_NAME
having No_of_Players>4 
order by No_of_Players desc;


