-- who is the senior most employee based on job title?

select*from employee
order by levels desc
limit 1

--which countries have the most invoices ?

select count(*) as c ,billing_country 
from invoice
group by billing_country
order by c desc

-- what are top 3 values of total invoices ?
select total from invoice
order by total desc
limit 3

-- which city has the best customer ?

select sum(total) as invoice_total, billing_city
from invoice
group by billing_city
order by invoice_total desc

-- who is has best customer?

select customer.customer_id,customer.first_name,customer.last_name,sum(invoice.total)as total
from customer
join invoice on customer.customer_id =invoice.customer_id
group by customer.customer_id
order by total desc
limit 3

-- questions set 2 -moderate
 
1-- write query to return the email, first name, last name,& genre of all rock music listeners.
-- return your list ordered alphabetically by email starting with a

select distinct email,first_name,last_name
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
  select track_id from track
  join genre on track.genre_id = genre.genre_id
  where genre.name like 'rock'
)
order by email;

2-- let invite the artist who have written the most 
-- rock music
--  in our dataset. write a query that returns the artist name and total track count
--  of the top 10 rock brands

select *from track

SELECT ARTIST.ARTIST_ID,
	ARTIST.NAME,
	COUNT(ARTIST.ARTIST_ID) AS NUMBER_OF_SONGS
FROM TRACK
JOIN ALBUM ON ALBUM.ALBUM_ID = TRACK.ALBUM_ID
JOIN ARTIST ON ARTIST.ARTIST_ID = ALBUM.ARTIST_ID
JOIN GENRE ON GENRE.GENRE_ID = TRACK.GENRE_ID
WHERE GENRE.NAME like 'rock'
GROUP BY ARTIST.ARTIST_ID
ORDER BY NUMBER_OF_SONGS DESC
LIMIT 10;
3-- return all the track name that have a song length longer than the 
-- average song length. return and name milliseconds for each 
-- track.order by the song length with the longest songs listed first

SELECT NAME,
	MILLISECONDS
FROM TRACK
WHERE MILLISECONDS >
		(SELECT AVG(MILLISECONDS) AS AVG_TRACK_LENGTH
			FROM TRACK)
ORDER BY MILLISECONDS DESC;

-- advanced questions

1-- find how mush amount spend by each customer on artists ?
-- write a query to return customer name, artist name and total spend 


WITH BEST_SELLING_ARTIST AS(
       SELECT ARTIST.ARTIST_ID AS ARTIST_ID,
		ARTIST.NAME AS ARTIST_NAME,
		SUM (INVOICE_LINE.UNIT_PRICE * INVOICE_LINE.QUANTITY)AS TOTAL_SALES
		FROM INVOICE_LINE
		JOIN TRACK ON TRACK.TRACK_ID = INVOICE_LINE.TRACK_ID
		JOIN ALBUM ON ALBUM.ALBUM_ID = TRACK.ALBUM_ID
		JOIN ARTIST ON ARTIST.ARTIST_ID = ALBUM.ARTIST_ID
		GROUP BY 1
		ORDER BY 3 DESC
		LIMIT 1
)
select c.customer_id, c.first_name,c.last_name, bsa.artist_name,
sum(il.unit_price*il.quantity) as amount_spend
from invoice i
join customer c on c.customer_id = i.customer_id
join invoice_line il on il.invoice_id = i.invoice_id
join track t on t.track_id = il.track_id
join album alb on alb.album_id = t.album_id
join best_selling_artist  bsa on bsa.artist_id = alb.artist_id
group by 1,2,3,4
order by 5 desc;


2-- we want to find out the most popular music genre for reach country

with popular_genre as 
(
select count (invoice_line.quantity)  as purchases, customer.country, genre.name, genre.genre_id,
row_number() over(partition by customer.country order by count(invoice_line.quantity) desc) as  rowno
from invoice_line
join invoice on invoice.invoice_id = invoice_line.invoice_id
join customer on customer.customer_id = invoice.customer_id
join track on track.track_id = invoice_line.track_id
join genre on genre.genre_id = track.genre_id
group by 2,3,4
order by 2 ASC,1 DESC
)
select *from popular_genre where rowno <=1



-- 3-- write a query that determines the customer that has spend
--  the most on for each country. write a query that returns the country along 
--  with the top customer and how much they spend.
WITH CUSTOMER_WITH_COUNTRY AS
	(SELECT CUSTOMER.CUSTOMER_ID,
			FIRST_NAME,
			LAST_NAME,
			BILLING_COUNTRY,
			SUM(TOTAL)AS TOTAL_SPENDING,
			ROW_NUMBER()OVER(PARTITION BY BILLING_COUNTRY
																				ORDER BY SUM (TOTAL) DESC) AS ROWNO
		FROM INVOICE
		JOIN CUSTOMER ON CUSTOMER.CUSTOMER_ID = INVOICE.CUSTOMER_ID
		GROUP BY 1,2,
			3,4
		ORDER BY 4 ASC,5 DESC)
SELECT*
FROM CUSTOMER_WITH_COUNTRY
WHERE ROWNO <= 1

























