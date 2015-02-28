SELECT (f.year::text || '-' || f.month::text || '-' || f.day::text)::date 
as d_date,w.hour,o.name as o_airport,d.name as d_airport,
f.carrier,w.temp as d_temp,
f.dep_delay as d_delay,arr_delay as a_delay,air_time,
p.seats as seating FROM flights f
INNER JOIN (SELECT * FROM planes) p ON f.tailnum = p.tailnum
INNER JOIN (SELECT * FROM airports) d ON f.dest =d.faa
INNER JOIN (SELECT * FROM airports) o ON f.origin = o.faa
INNER JOIN (SELECT concat_ws('-',weather.year,weather.month,
weather.day,weather.hour) as w_date_hour,weather.* FROM weather) w 
ON concat_ws('-',f.year,f.month,f.day,f.hour) = w.w_date_hour AND 
f.origin = w.origin
WHERE (d.name='Los Angeles Intl')
AND ((f.year::text || '-' || f.month::text || '-' || f.day::text)::date 
BETWEEN '2013-02-23' AND '2013-03-01')
