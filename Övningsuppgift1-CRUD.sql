USE everyloop3;
GO
SELECT * FROM GameOfThrones;

select 
    title,
    season,
    EpisodeInSeason,
    format(Season, 'S0#') + format(EpisodeInSeason, 'E0#') as 'Episodes',
    concat('S', format(Season, '00'), 'E', format(EpisodeInSeason, '00')) as 'Episodes'         
from
    GameOfThrones



select 
   firstname,
   lastname,
    concat(left(firstname, 2), left(lastname, 2)),
    lower(concat(left(firstname, 2), left(lastname, 2))),
    lower(left(firstname, 2)),
    concat(lower(left(firstname, 2)), left(lastname, 2))
from 
    users2


    

update users2 set UserName= lower(concat(left(firstname, 2), left(lastname, 2)))
update users2 set UserName = lower(left(firstname, 2) + left(lastname, 2));
UPDATE Users2 SET UserName = lower(substring (FirstName, 1, 2)) + lower(substring (LastName, 1, 2))



select * INTO Airports2 FROM Airports
select * from Airports2


update AirportsCopy set DST = isnull(DST, '-')
update AirportsCopy set Time = isnull(Time, '-')
update AirportsCopy set Time = coalesce(Time, '-'), DST = coalesce(DST, '-') where Time is null or DST is null;





