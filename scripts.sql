--Покажите  фамилию и имя клиентов из города Прага ?
select FirstName, LastName, City 
from customers
where City = 'Prague'

--Покажите  фамилию и имя клиентов у которых имя начинается букву M ? Содержит символ "ch"?
select FirstName, LastName
from customers
where FirstName like 'M%' and FirstName like '%ch%'

--Покажите название и размер музыкальных треков в Мегабайтах ?
select Name, Bytes
from tracks

--Покажите  фамилию и имя сотрудников кампании нанятых в 2002 году из города Калгари ?
select FirstName, LastName, HireDate, City 
from employees
where HireDate >= date('2002-01-01') and HireDate <= date('2002-12-12') and City = 'Calgary'

--Покажите  фамилию и имя сотрудников кампании нанятых в возрасте 40 лет и выше?
select FirstName, LastName, HireDate,BirthDate
from employees
WHERE HireDate >= date(BirthDate, '40 years')

select FirstName, LastName, HireDate,BirthDate
from employees
where strftime('%Y', HireDate)-strftime('%Y', BirthDate) >= 40

--Покажите покупателей-амерканцев без факса ?
select*
from customers
where country = 'USA' and Fax is null

--Покажите канадские города в которые сделаны продажи в августе и сентябре месяце?
select BillingCity, InvoiceDate, BillingCountry
from invoices
where BillingCountry = 'Canada' and (strftime('%m',InvoiceDate) = '08' or strftime('%m',InvoiceDate) = '09')

--Покажите  почтовые адреса клиентов из домена gmail.com ?
select Email
from customers
where Email like '%gmail.com%'

--Покажите сотрудников  которые работают в кампании уже 18 лет и более ?
select FirstName, LastName, HireDate
from employees
where strftime('2023')-strftime('%Y', HireDate) >= 18

--Покажите  в алфавитном порядке все должности в кампании  ?
select Title
from employees
order by Title asc

--Покажите  в алфавитном порядке Фамилию, Имя и год рождения покупателей  ?
select LastName||' '|| FirstName as FIO, Age
from customers
order by FIO asc

--Покажите название и длительность в секундах самой короткой песни
select Name, min(Milliseconds)
from tracks

--Сколько секунд длится самая короткая песня ?
select min(Milliseconds)
from tracks

--Покажите средний возраст клиента для каждой страны ?
select country, count(*), sum(age), sum(age)/count(*)
from customers
group by country

--Покафите Фамилии работников нанятых в октябре?
select LastName, HireDate
from employees
where strftime('%m',HireDate) = '10'

--Покажите фамилию самого старого по стажу сотрудника в кампании ?
select FirstName,min(HireDate) 
from employees

----------------------------------------------------------------------------------------------------------------------------

--Посчитайте общую сумму продаж в США в 1 квартале 2012 года? 
select sum(UnitPrice)
from sales as s
    inner join sales_items as st
        on s.salesId=st.salesId
where ShipCountry='USA' and SalesDate >= date('2012-01-01') and SalesDate < date('2012-04-01')

--Покажите имена клиентов, которых нет среди работников
select c.FirstName as 'customer name', e.FirstName as 'employee name'
from customers as c
left join employees as e
on c.FirstName = e.FirstName 
Where e.FirstName is null

--Посчитайте количество треков в каждом альбоме. В результате должно быть:  имя альбома и кол-во треков
select Title, Name, count(*) as 'Количество треков'
from tracks as t
left join albums as a
on t.albumId = a.AlbumId
Group BY Title

--Покажите фамилию и имя покупателей немцев сделавших заказы в 2009 году, товары которых были отгружены в город Берлин?
select FirstName,LastName
from customers as c
left join sales as s
on c.CustomerId = s.CustomerId
Where c.Country = 'Germany' and s.SalesDate >= date('2009-01-01') and SalesDate <= date('2009-12-31') and s.ShipCity = 'Berlin'

--Покажите фамилии  клиентов которые  купили больше 30 музыкальных треков ?
select c.LastName,t.name, count(*)
from customers as c
inner join sales as s
on c.CustomerId = s.CustomerId
inner join sales_items as si
on s.SalesId = si.SalesId
inner join tracks as t
on si.TrackId = t.TrackId
Group By c.LastName having count(*)>30 

--В базе есть таблица музыкальных треков и жанров Назовите среднюю стоимстость музыкального трека в каждом жанре?
select g.Name, t.UnitPrice, sum(t.UnitPrice)/count(*) as 'Средняя стоимость', count(*) as 'Count'
from tracks as t
inner join genres as g
on t.GenreId = g.GenreId
Group By g.Name

--В базе есть таблица музыкальных треков и жанров. Покажите жанры у которых средняя стоимость одного трека больше 1-го рубля
select g.Name, t.UnitPrice, sum(t.UnitPrice)/count(*) as 'Средняя стоимость', count(*) as 'Count'
from tracks as t
inner join genres as g
on t.GenreId = g.GenreId
Group By g.Name having sum(t.UnitPrice)/count(*) > 1



