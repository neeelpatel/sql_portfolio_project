use class001;

select * from tank_data;
select count(*) from tank_data; 

ALTER TABLE class001.tank_data CHANGE `Ep. No.` epno int NULL;

#total episode 
select distinct epno from tank_data;
select count(distinct epno) from tank_data; 
select max(epno) from tank_data ;

#piches converted
select count(distinct brand) from tank_data;

#amountfunding - if greater than 0 
#total number of pitches that get amountfunding
select sum(a.converted) fund_recevied,count(*)total_pitches from(
select `Amount Invested lakhs` , case when `Amount Invested lakhs`  > 0 then 1 else 0 end as 'converted' from tank_data )a;

# to find the success rate devide fund_receive/total_pitches
#note:if you get o as a result convert it into float using cast 
select sum(a.converted)/count(*)*100 success_rate from(
select `Amount Invested lakhs` , case when `Amount Invested lakhs`  > 0 then 1 else 0 end as 'converted' from tank_data )a;

#total female 
select sum(Female) from tank_data; 

#total male
select sum(male) from tank_data;

#gender ratio
select sum(female)/sum(male) from tank_data;

#total invested amount
select sum(`Amount Invested lakhs`) from tank_data ;

select * from tank_data td ;

#avg euity taken : it effect only when it get greater than 0% 

select avg(`Equity Taken %`) from tank_data 
where `Equity Taken %` >0;

#highest deal taken
select max(`Amount Invested lakhs`) from tank_data ;

#highest euity taken
select max(`Equity Taken %`) from tank_data ;

#count pitches that have atleast one female
select count(*) from tank_data 
where Female >0;

#another way
select sum(a.female_count) from 
(select female ,case when female > 0 then 1 else 0 end as female_count from tank_data)a ;

#total number of piches  converted that having atleast 1 female
select * from tank_data ;

select sum(b.female_count)from(
select *,case when a.female>0 then 1 else 0 end as female_count from(select * from tank_data 
where deal !='no deal')a)b;

#another way
select count(*) from tank_data 
where deal != 'no deal' and female>0; 

#total number of average teammembers
select avg(`Team members`) from tank_data;
select * from tank_data;
#amount invested per deal
select deal,avg(`Amount Invested lakhs`) total_invested from tank_data 
group by Deal ;

select avg(`Amount Invested lakhs`) from tank_data 
where deal != 'no deal';


#avgage group of contenstants
select `Avg age` ,count(`Avg age`)total_contenstants from tank_data
group by `Avg age` 
order by total_contenstants desc;

#location frm which highest numnber of piches comes
select Location,count(*)cnt from tank_data 
group by Location 
order by cnt desc;

#sector group of contanstants
select * from tank_data ;
select Sector ,count(*)no_deal from tank_data 
group by Sector 
order by no_deal desc;

select * from tank_data ;

#partner deal
select Partners,count(Partners)cnt  from tank_data 
where Partners != '-'
group by Partners 
order by cnt desc;

#making matrix
select 'ashneer' as key count(`Ashneer Amount Invested`)total_deal  from tank_data where `Ashneer Amount Invested` is not null ;


#invested_deal matrix
select 'ashneer' as key count(`Ashneer Amount Invested`)invested_deal  from tank_data 
where `Ashneer Amount Invested` is not null and `Ashneer Amount Invested` !=0;

select 'ashneer' as key 
sum(`Ashneer Amount Invested`)invested_amount,avg(`Ashneer Equity Taken %`)avg_euity from tank_data 
where `Ashneer Equity Taken %`  is not null and `Ashneer Equity Taken %`  !=0 ;

#combine using join
#result of ashneer
select m.keyy,m.total_deal,m.invested_deal,n.invested_amount,n.avg_euity from 
(select a.keyy,a.total_deal,b.invested_deal from(
select 'ashneer' as keyy,count(`Ashneer Amount Invested`)total_deal  from tank_data where `Ashneer Amount Invested` is not null )a 
inner join(
select 'ashneer' as keyy,count(`Ashneer Amount Invested`)invested_deal  from tank_data 
where `Ashneer Amount Invested` is not null and `Ashneer Amount Invested` !=0) b
on a.keyy = b.keyy)m
inner join 
(select 'ashneer' as keyy,sum(`Ashneer Amount Invested`)invested_amount,avg(`Ashneer Equity Taken %`)avg_euity from tank_data 
where `Ashneer Equity Taken %`  is not null and `Ashneer Equity Taken %`  !=0 )n
on m.keyy = n.keyy

#startup in which highest amount has been invested in each sector
select c.* from
(select Brand,sector,`Amount Invested lakhs` ,rank() over(partition by Sector order by `Amount Invested lakhs` desc) rank_  from tank_data )c
where c.rank_ = 1;















