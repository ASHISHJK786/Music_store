1. Albums and Artists



Q.1)Retrieve the list of all album titles along with their corresponding artist names.

select Album.title,artist.name 
from album
inner join  
artist
on album.artist_id =artist.artist_id;

Q.2) Count the number of albums each artist has produced.

SELECT artist_id, COUNT(album_id) AS no_of_albums
FROM album
GROUP BY artist_id
ORDER BY 
ARTIST_ID DESC
LIMIT 5;

Q.3) Find the artist with the maximum number of albums.

SELECT artist_id, COUNT(album_id) AS no_of_albums
FROM album
GROUP BY artist_id
ORDER BY 
no_of_albums DESC
LIMIT 1;

SELECT * FROM ARTIST
WHERE ARTIST_ID = '90';

Q.4) List all artists who have not produced any albums.

SELECT ARTIST_ID  FROM ALBUM 
WHERE ALBUM_ID = ' ';

Q.5) Display the album titles along with artist names, sorted by artist name.

SELECT  ALBUM.TITLE, ARTIST.NAME
FROM ALBUM
INNER JOIN ARTIST
ON 
ALBUM.ARTIST_ID = ARTIST.ARTIST_ID;



2. Customers and Invoices



SELECT * FROM CUSTOMER;
SELECT * FROM INVOICE;

Q.1) Retrieve the full name and email of all customers who have made at least one purchase.

SELECT 
customer.CUSTOMER_ID,
UPPER(customer.EMAIL) AS EMAIL,
customer.FIRST_NAME||''||customer.LAST_NAME AS FULL_NAME 
FROM CUSTOMER
INNER JOIN 
invoice  ON Customer.customer_id = Invoice.customer_id
GROUP BY 
Customer.customer_id,
FULL_NAME,
Email;


Q.2) Count the total number of invoices generated by each customer.

SELECT 
CUSTOMER_ID,
COUNT(INVOICE_ID) AS TOTAL_INVOICE 
FROM INVOICE 
GROUP BY 
CUSTOMER_ID
ORDER BY
TOTAL_INVOICE DESC
LIMIT 10;

Q.3) Find the total revenue generated by each customer.



SELECT 
CUSTOMER_ID,
ROUND(SUM(total)::numeric, 2) AS total_revenue
FROM
INVOICE
GROUP BY
CUSTOMER_ID
ORDER  BY
TOTAL_REVENUE DESC;

Q.4) List the customers who live in the same city as their billing city.

SELECT 
CUSTOMER.CUSTOMER_ID ,
CONCAT(CUSTOMER.FIRST_NAME,'',CUSTOMER.LAST_NAME) AS FULL_NAME,
CUSTOMER.ADDRESS,
INVOICE.BILLING_ADDRESS
FROM CUSTOMER 
INNER JOIN  INVOICE
ON 
CUSTOMER.CUSTOMER_ID = INVOICE.CUSTOMER_ID 
WHERE CUSTOMER.ADDRESS = INVOICE.BILLING_ADDRESS;

Q.5) Find the customers who havent provided their company name.

SELECT CUSTOMER_ID , 
CONCAT(FIRST_NAME,LAST_NAME) AS NAME 
FROM CUSTOMER 
WHERE CUSTOMER.COMPANY IS NULL;


3. Employees



Q.1) Retrieve a list of all employees who report to someone (i.e., have a manager).

SELECT*FROM EMPLOYEE
SELECT*FROM GENRE
SELECT EMPLOYEE_ID, REPORTS_TO  FROM EMPLOYEE 
WHERE REPORTS_TO IS NOT NULL;


Q.2) Find the employee with the earliest hire date.

SELECT 
FIRST_NAME,
LAST_NAME,
EMPLOYEE_ID, 
HIRE_DATE,
TITLE FROM EMPLOYEE
WHERE 
HIRE_DATE = (SELECT MAX(HIRE_DATE) FROM EMPLOYEE);

Q.3) Count the number of employees reporting to each manager.

SELECT
EMPLOYEE_ID,
FIRST_NAME,
LAST_NAME 
FROM EMPLOYEE
WHERE REPORTS_TO = '1';


Q.4) Retrieve the full names of employees who share the same first name.

SELECT
Employee.FIRST_NAME||' '||Employee.LAST_NAME  AS FULL_NAME 
FROM 
EMPLOYEE
WHERE 
Employee.FIRST_NAME 
IN (
SELECT Employee.FIRST_NAME 
FROM EMPLOYEE 
GROUP BY Employee.FIRST_NAME 
HAVING COUNT(*) > 1 
)
ORDER BY 
Employee.FIRST_NAME, 
Employee.LAST_NAME;



Q.5) Display the employee names along with their titles and the name of their manager.

SELECT 
e1.FIRST_NAME || ' ' || e1.LAST_NAME AS EMPLOYEE_NAME,
e1.TITLE,
e2.FIRST_NAME || ' ' || e2.LAST_NAME AS MANAGER_NAME
FROM 
EMPLOYEE e1
LEFT JOIN 
EMPLOYEE e2 ON e1.REPORTS_TO = e2.EMPLOYEE_ID;

4. Genres and Tracks



Q.1) Count the number of tracks available in each genre.

SELECT COUNT(TRACK_ID) AS NO_OF_TRACK, GENRE_ID
FROM TRACK 
GROUP BY 
GENRE_ID 
ORDER BY NO_OF_TRACK DESC
LIMIT 10;

Q.2) Retrieve the genre that has the maximum number of tracks.

SELECT COUNT(TRACK_ID) AS NO_OF_TRACK, GENRE_ID
FROM TRACK 
GROUP BY 
GENRE_ID 
ORDER BY NO_OF_TRACK DESC
LIMIT 5;

Q.3)List all tracks that belong to the "Rock" genre.

SELECT 
TRACK.TRACK_ID, 
TRACK.NAME 
FROM 
TRACK
INNER JOIN 
GENRE ON TRACK.GENRE_ID = GENRE.GENRE_ID
WHERE 
GENRE.NAME = 'Rock';



Q.4)Find the genres that have fewer than 5 tracks.

select COUNT(track.track_id) AS TRACK_COUNT,
GENRE.name, 
GENRE.GENRE_ID
FROM TRACK 
INNER JOIN GENRE 
ON
TRACK.GENRE_ID= GENRE.GENRE_ID
GROUP BY GENRE.GENRE_ID
HAVING 
COUNT(track.track_id)<5;

Q.5)Retrieve the genre names and their corresponding track IDs.

SELECT GENRE.NAME,TRACK.TRACK_ID 
FROM TRACK
INNER JOIN 
GENRE
ON 
TRACK.GENRE_ID = GENRE.GENRE_ID;

5. Invoices and Invoice Lines




Q.1)Find the total amount billed on each invoice.

select INVOICE.INVOICE_ID,SUM(INVOICE.TOTAL)AS TOTAL_AMOUNT
FROM INVOICE
GROUP BY 
INVOICE_ID
ORDER BY 
INVOICE_ID  ASC;

Q.2)Retrieve the invoice details (date, billing city, total) for invoices over $50.

SELECT INVOICE.INVOICE_DATE, 
INVOICE.BILLING_CITY,
INVOICE.TOTAL 
FROM INVOICE
WHERE
INVOICE.TOTAL >50;


Q.3)List all invoices where the quantity of any item is greater than 5.

SELECT INVOICE.INVOICE_ID,
INVOICE.CUSTOMER_ID,
INVOICE.BILLING_CITY,
INVOICE_LINE.QUANTITY
FROM INVOICE
INNER JOIN INVOICE_LINE
ON 
INVOICE.INVOICE_ID = INVOICE_LINE.INVOICE_ID
GROUP BY 
INVOICE_LINE.QUANTITY,
INVOICE.INVOICE_ID
HAVING 
INVOICE_LINE.QUANTITY >5;

Q.4)Retrieve the average unit price for all items on an invoice.


SELECT AVG(INVOICE_LINE.UNIT_PRICE*INVOICE_LINE.QUANTITY)
FROM INVOICE_LINE;


Q.5) Find the invoices that contain more than 10 items.

SELECT 
INVOICE_LINE.INVOICE_ID,
SUM(INVOICE_LINE.QUANTITY) AS TOTAL_ITEMS FROM 
INVOICE_LINE
GROUP BY 
INVOICE_LINE.INVOICE_ID
HAVING 
SUM(INVOICE_LINE.QUANTITY) >10 
ORDER BY 
SUM(INVOICE_LINE.QUANTITY) DESC
LIMIT 10;


6. Media Types

select 
media_type.media_type_id,
count(track.track_id)  as track,
media_type.name 
from
media_type
inner join
track 
on 
track.media_type_id = media_type.media_type_id
group by 
media_type.media_type_id,
media_type.name
order by 
media_type.media_type_id asc;

Q.2) Find the media type with the fewest number of tracks.

select 
media_type.media_type_id,
count(track.track_id)  as track,
media_type.name 
from
media_type
inner join
track 
on 
track.media_type_id = media_type.media_type_id
group by 
media_type.media_type_id,
media_type.name
order by 
track asc
limit 1 ;


Q.3) List all tracks that are available in the "MPEG audio file" format.

SELECT TRACK.TRACK_ID,TRACK.NAME 
FROM TRACK
INNER JOIN MEDIA_TYPE 
ON 
MEDIA_TYPE.MEDIA_TYPE_ID = TRACK.MEDIA_TYPE_ID
WHERE
MEDIA_TYPE.NAME = 'MPEG audio file';


Q.4) Retrieve the media type names along with their corresponding track IDs.

SELECT 
MEDIA_TYPE.NAME ,
TRACK.TRACK_ID
FROM MEDIA_TYPE 
INNER JOIN 
TRACK
ON 
TRACK.MEDIA_TYPE_ID = MEDIA_TYPE.MEDIA_TYPE_ID ;


Q.5) Find the media type that is most commonly used.

select 
media_type.media_type_id,
count(track.track_id)  as track,
media_type.name 
from
media_type
inner join
track 
on 
track.media_type_id = media_type.media_type_id
group by 
media_type.media_type_id,
media_type.name
order by 
track DESC
limit 1 ;

7. Playlists and Tracks



Q.1) Retrieve the number of tracks in each playlist.

SELECT 
playlist_track.playlist_id,
COUNT(playlist_track.TRACK_ID) as no_of_tracks
from playlist_track
group by 
playlist_track.playlist_id
order by 
no_of_tracks  desc;

Q.2) Find the playlist with the maximum number of tracks.

SELECT 
playlist.name,
playlist_track.playlist_id,
COUNT(playlist_track.TRACK_ID) as no_of_tracks
from playlist_track
inner join playlist
on 
playlist.playlist_id = PLAYLIST_TRACK.playlist_id
group by
playlist.name,
playlist_track.playlist_id
order by 
no_of_tracks  desc
limit 5;

Q.3) List all playlists that contain a track titled "Revelations"

SELECT 
track.track_id,
track.name,
playlist_track.playlist_id
FROM 
track
INNER JOIN 
playlist_track 
ON 
track.track_id = playlist_track.track_id
WHERE 
track.name = 'Revelations'
GROUP BY 
track.track_id,
track.name,
playlist_track.playlist_id;
	

Q.4) Find the playlists that have fewer than 10 tracks.


select count(track.track_id) as total_track,
playlist.playlist_id,
playlist.name
from
track
inner join PLAYLIST_track
on 
TRACK.track_id = playlist_track.track_id 
inner join 
playlist
on 
playlist.playlist_id = playlist_track.playlist_id 
group by 
playlist.playlist_id,
playlist.name
order by 
total_track asc
limit 5;


Q.5) Retrieve the playlist names along with the track IDs of their songs.

select playlist.name,
track.track_id,
track.name
from playlist
inner join 
playlist_track
on 
playlist_track.playlist_id = playlist_track.playlist_id
inner join track
on 
track.track_id = playlist_track.track_id;

8. General Queries



Q.1) Retrieve the full names and email addresses of customers who have interacted with "Sales Support" employees.

SELECT 
CONCAT(CUSTOMER.FIRST_NAME,'',CUSTOMER.LAST_NAME) AS FULL_NAME,
CUSTOMER.EMAIL 
FROM CUSTOMER 
WHERE 
CUSTOMER.SUPPORT_REP_ID IS NOT NULL;

Q.2) Find the total number of invoices generated in each country.

select count(invoice) as  total_invoice, billing_country 
from invoice 
group by billing_country
order by 
total_invoice desc;

Q.3) List all the employees who were hired in the same year.

SELECT 
E1.FIRST_NAME,
E1.HIRE_DATE 
FROM 
EMPLOYEE E1 
INNER JOIN 
EMPLOYEE E2
ON 
EXTRACT(YEAR FROM E1.HIRE_DATE) = EXTRACT(YEAR FROM E2.HIRE_DATE)
WHERE 
E1.EMPLOYEE_ID <> E2.EMPLOYEE_ID;


Q.4) Find the total revenue generated by each country.

SELECT BILLING_COUNTRY,SUM (TOTAL) AS TOTAL_REVENUE
FROM INVOICE 
GROUP BY 
BILLING_COUNTRY
ORDER BY TOTAL_REVENUE DESC;

Q.5) Retrieve the full names of customers who have made purchases in more than one city.

select
customer.first_name||' '|| customer.last_name as full_name
from customer
inner join 
invoice on customer.customer_id = invoice.customer_id
group by 
customer.customer_id,
full_name
having 
count(distinct invoice.billing_city)> 1;

9. Advanced Queries




Q.1)Find the average revenue per invoice for each customer.

SELECT  
customer.customer_id,
customer.first_name || ' ' || customer.last_name AS full_name,
AVG(invoice_line.unit_price * invoice_line.quantity) AS average_revenue
FROM 
invoice_line
INNER JOIN 
invoice ON invoice.invoice_id = invoice_line.invoice_id
INNER JOIN 
customer ON customer.customer_id = invoice.customer_id
GROUP BY 
customer.customer_id, 
customer.first_name, 
customer.last_name;

Q.2) List all customers whose invoices have a total amount greater than the average invoice amount.

SELECT  
customer.customer_id,
customer.first_name || ' ' || customer.last_name AS full_name,
sum(invoice.total) as Total_amount
FROM 
invoice
INNER JOIN 
invoice_line ON invoice.invoice_id = invoice_line.invoice_id
INNER JOIN 
customer ON customer.customer_id = invoice.customer_id
GROUP BY 
customer.customer_id, 
customer.first_name, 
customer.last_name
having
sum(invoice.total) > AVG(invoice_line.unit_price * invoice_line.quantity)
order by 
customer.customer_id
asc;


Q.3) Retrieve the names of employees who have managed more than 5 different employees.

select 
manager.first_name||' '||manager.last_name as full_name,
COUNT(employee.employee_id) AS num_of_employees_managed
from employee
as manager
INNER JOIN 
employee AS employee ON manager.employee_id = employee.reports_to
GROUP BY 
manager.employee_id, 
manager.first_name, 
manager.last_name
HAVING 
COUNT(employee.employee_id) > 5;

Q.4) Find the employees who have been with the company for more than 10 years.

select 
employee.employee_id,
employee.first_name||' '||employee.last_name as full_name,
employee.hire_date
from employee
where 
extract(year from age(current_date,hire_date))>10;


Q.5) Retrieve the top 5 genres based on the number of tracks.

select 
count(track.track_id) as Track_count,
genre.genre_id,
genre.name 
from track
inner join 
genre
on genre.genre_id =track.genre_id 
group by
genre.name,
genre.genre_id
order by
Track_count desc
limit 5;



10. Combined Queries



Q.1) Find the total revenue generated by each genre.

SELECT  GENRE.GENRE_ID,
GENRE.NAME,
SUM(INVOICE_LINE.UNIT_PRICE * INVOICE_LINE.QUANTITY)AS REVENUE
FROM GENRE 
INNER JOIN TRACK
ON 
TRACK.GENRE_ID = GENRE.GENRE_ID
INNER JOIN  INVOICE_LINE
ON 
INVOICE_LINE.TRACK_ID = TRACK.TRACK_ID
group by 
GENRE.GENRE_ID,
GENRE.NAME
order by 
revenue desc;


Q.2) Retrieve the names of customers who have purchased tracks from more than 3 different genres.

SELECT 
concat(CUSTOMER.first_NAME,'',last_name) as customer_name
FROM 
CUSTOMER
INNER JOIN 
INVOICE ON CUSTOMER.CUSTOMER_ID = INVOICE.CUSTOMER_ID
INNER JOIN 
INVOICE_LINE ON INVOICE.INVOICE_ID = INVOICE_LINE.INVOICE_ID
INNER JOIN 
TRACK ON INVOICE_LINE.TRACK_ID = TRACK.TRACK_ID
INNER JOIN 
GENRE ON TRACK.GENRE_ID = GENRE.GENRE_ID
GROUP BY 
customer_name
HAVING 
COUNT(DISTINCT GENRE.GENRE_ID) > 3;

Q.3) List the top 3 employees in terms of the number of customers they support.

SELECT 
EMPLOYEE.EMPLOYEE_ID,
CONCAT(EMPLOYEE.FIRST_NAME,' ',EMPLOYEE.LAST_NAME) AS EMP_NAME,
COUNT(CUSTOMER.CUSTOMER_ID) AS CUSTOMER_COUNT
FROM 
EMPLOYEE
INNER JOIN 
CUSTOMER ON CAST(EMPLOYEE.EMPLOYEE_ID AS VARCHAR)=CAST(CUSTOMER.SUPPORT_REP_ID AS VARCHAR)
GROUP BY 
EMPLOYEE.EMPLOYEE_ID,
EMP_NAME
ORDER BY 
CUSTOMER_COUNT DESC
LIMIT 3;

Q.4) Find the customer with the maximum total purchase amount.

SELECT CUSTOMER.CUSTOMER_ID,
CONCAT(CUSTOMER.FIRST_NAME,CUSTOMER.LAST_NAME) AS FULL_NAME,
SUM(TOTAL) AS AMOUNT
FROM INVOICE 
INNER JOIN CUSTOMER
ON
CUSTOMER.CUSTOMER_ID = INVOICE.CUSTOMER_ID 
GROUP BY 
CUSTOMER.CUSTOMER_ID
ORDER BY AMOUNT DESC
LIMIT 1;


Q.5) Retrieve the names of the top 5 artists based on the number of tracks sold.

SELECT 
ARTIST.NAME, 
SUM(INVOICE_LINE.QUANTITY) AS TRACKS_SOLD
FROM 
ARTIST
INNER JOIN 
ALBUM ON ARTIST.ARTIST_ID = ALBUM.ARTIST_ID
INNER JOIN 
TRACK ON ALBUM.ALBUM_ID = TRACK.ALBUM_ID
INNER JOIN 
INVOICE_LINE ON TRACK.TRACK_ID = INVOICE_LINE.TRACK_ID
GROUP BY 
ARTIST.NAME
ORDER BY 
TRACKS_SOLD DESC
LIMIT 5;

