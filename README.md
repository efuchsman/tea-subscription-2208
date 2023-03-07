<h1 align="center">Tea Subscription 2208</h1>
<div align="center">
  <a href="https://github.com/efuchsman/tea-subscription-2208">
    <img src="https://imageio.forbes.com/specials-images/imageserve/5f6c061ca71799093f55fd02/Aromatic-herbal-tea-/0x0.jpg" width="850" height="450">
  </a>
</div>

# Table of Contents
* [App Description](#app-description)
* [Database Schema](#database-schema)
* [System Requirements](#system-requirements)
* [Setup](#setup)
* [Respository](#repository)
* [Endpoints](#endpoints)


<h2>App Description</h2>

Tea-Subscription-2208 is an early-stage tea subscription API-service where a user can get a customer's active and canceled subscriptions, add subscriptions to a customer and cancel a customer's subscription. 


<h2 align="center">Database Schema</h2>
<div align="center">
  <a href="https://github.com/efuchsman/tea-subscription-2208">
    <img src="lib/images/tea_sub_db.png" alt="Database Schema" width="650" height="350">
  </a>
</div>


<h2>System Requirements</h2>

* Ruby 2.7.4 
* Rails 5.2.8.1
* If the user does not wish to download Ruby/Rails, they can simply download <a href="https://www.docker.com/products/docker-desktop/">Docker Desktop</a> to launch a development container of the app on their local device.


<h2>Setup</h2>

<h3>Setup for Ruby on Rails</h3>

1. Fork and Clone the repository
2. Install gem packages: `bundle install`
4. Setup the database: `rails db:{drop,create,migrate,seed}`
5. Run the server: `rails s`

<h3>Setup for Docker</h3>

1. Fork and Clone the repository
2. Open Docker Desktop and sign in
3. Builder docker image and launch server container: `docker-compose up --build` (You will only have to run `docker-compose up` after this unless you pull a newly updated version of the repository from GitHub)
4. Migrate the database: `docker-compose exec web bundle exec rake db:migrate`
5. Seed data: `docker-compose exec web bundle exec rake db:seed`
6. To close the the container: `Ctrl-C`
7. If you need to drop the database and reseed data: `docker-compose down --volumes`


<h4>Repository</h4>

https://github.com/efuchsman/tea-subscription-2208

<h2>Endpoints</h2>

<h3>Create a new customer</h3>

`POST '/api/v1/new-customer'`

```
{
    "first_name": "Eli",
    "last_name": "Fuchsman",
    "email": "eli@mail.com",
    "address": "Eli's address" 
}
```


<h4>Output:</h4>

```
{
    "success": "New customer successfully created"
}
```

<h4>Check your email for a welcome message:</h4>



<h3>GET a customer</h3>

`GET /api/v1/customer?id=1`

```
{
  "data": {
      "id": "1",
      "type": "customer",
      "attributes": {
          "first_name": "Eli",
          "last_name": "Fuchsman",
          "email": "eli@mail.com",
          "address": "Eli's address",
          "active_subscriptions": [],
          "canceled_subscriptions": []
      }
   }
}
```

<h3>Add a new subscription to a customer</h3>

`POST /api/v1/add-subscription`

<h4>Body:</h4>

```
{
    "customer_id": 1,
    "subscription_id":2
}
```

<h4>Output:</h4>

```
{
    "success": "Customer subscription has been successfully activated"
}
```

<h4>Check and See:</h4>


`GET /api/v1/customer?id=1`

```
{
    "data": {
        "id": "1",
        "type": "customer",
        "attributes": {
            "first_name": "Eli",
            "last_name": "Fuchsman",
            "email": "eli@mail.com",
            "address": "Eli's address",
            "active_subscriptions": [
                {
                    "id": 1,
                    "status": "active",
                    "customer_id": 1,
                    "subscription_id": 2,
                    "created_at": "2023-03-03T04:42:22.087Z",
                    "updated_at": "2023-03-03T04:42:22.087Z"
                }
            ],
            "canceled_subscriptions": []
        }
    }
}
```

<h3>Cancel a customer's active subscription</h3>

`PATCH /api/v1/cancel-subscription?id=1`

<h4>Output:</h4>

```
{
    "success": "Customer subscription has been successfully canceled"
}
```

<h4>Check and See:</h4>


`GET /api/v1/customer?id=1`

```
{
    "data": {
        "id": "1",
        "type": "customer",
        "attributes": {
            "first_name": "Eli",
            "last_name": "Fuchsman",
            "email": "eli@mail.com",
            "address": "Eli's address",
            "active_subscriptions": [],
            "canceled_subscriptions": [
                {
                    "id": 1,
                    "status": "canceled",
                    "customer_id": 1,
                    "subscription_id": 2,
                    "created_at": "2023-03-03T04:42:22.087Z",
                    "updated_at": "2023-03-03T04:46:17.449Z"
                }
            ]
        }
    }
}
```



## Contact 

<table align="center">
  <tr>
    <td><img src="https://avatars.githubusercontent.com/u/104859844?s=150&v=4"></td>
  </tr>
  <tr>
    <td>Eli Fuchsman</td>
  </tr>
  <tr>
    <td>
      <a href="https://github.com/efuchsman">GitHub</a><br>
      <a href="https://www.linkedin.com/in/elifuchsman/">LinkedIn</a>
   </td>
  </tr>
</table>


<h3><b>Acknowledgements</b></h3>

Turing School of Software Design: [https://turing.edu/](https://turing.edu/)
<br>
<p>Image Source:</p>
<p> https://www.forbes.com/sites/lanabandoim/2020/09/24/here-is-why-your-next-cup-of-tea-will-cost-more-money/?sh=1ee194285cf6</p>
