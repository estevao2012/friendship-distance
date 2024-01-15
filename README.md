# Friendship Distance
Is six degrees of separation rule true?

## Commands

### Set up

```bash
docker-compose build
docker-compose run --rm web rails db:migrate
docker-compose run --rm web rails db:seed
docker-compose up

```

### Run tests

```bash
docker-compose run --rm web rspec
```

## Data set

- *Users:* Responsible for store the users
- *Friendship:* Responsible for store the relationship between 2 users. 

## Architecture decisions

### Using Dijkstra algorithm to calculate shortest path

Major decision on the project. From production perspective, it won't make much sense, because as the size of users and friendship grows, harder will be manage in memory all the dependencies. It's mainly used to facilitate the work on low env, and demonstrate all the pieces. 

It's possible to change the usage of this in memory algorithm with some GraphDB for production usage.

### Rails is not your application

Rails is a delivery mechanism, and the real business logic is under `lib/application`. 
Ref: https://www.youtube.com/watch?v=WpkDN78P884&pp=ygUabG9zdCBhcmNoaXRlY3R1cmUgdW5jbGVib2I%3D

*NOTE:* Due time constraint I preferred to keep CRUD operations under Rails patterns. Production scenario, it's preferable to move it also under lib/application, so that we have control over the database coupling and other delivery mechanisms.

### UseCases are the entrypoints for the business

The UseCases pattern is used to control the flow of our business logic. The responsibility of this pattern is to manage the errors and call the domains that will manage the data life cycle. On a layered architecture, it lives on the application layer

### Services, Repositories, and Domain
These are patterns that live on business layer, they are responsible for decouple the business logic from the infrastructure and framework pieces. 

Repositories are responsible for isolate the domain from the database, Services are responsible for manage common business logic, and Domain are the business objects (Value Objects, and Entities).

## F.A.Q

### Why are you using Rails Models to CRUD?

Time constraint, Rails contains out of box scaffold which generates most of the boilerplate for CRUD. In a production environment, I'd prefer to encapsulate the CRUD operations under UseCase, so it can be reused on other places like cronjobs, queues, bash commands.

### Why SQLite?

Time constraint, and easy to set up. I preferred to use dijkstra algorithm to calculate shortest path, and calculate the separation degree in memory. Any other relational database would have similar result on the overall performance.

### Why not using GraphDB?

Time constraint. In a production environment, it's very likely we want to use an GraphDB to store the nodes (Friends) and vectors (relations). They are better to handle a large amount of data. 

*Note:* The approach used to calculate the graph in memory is purely a time constraint decision

### How to change using GraphDB?

Update repositories implementation with some data layer pointing to the GraphDB. I preferred to keep the dijkstra associated to the FriendshipRepository to easily replace all this calcs by replacing the FriendshipRepository implementation.

### Why calculate separation degree inside the repository?

On the future, I expect we would use a GraphDB like Neo4j which can contain this type of operation out of box.
Therefore, makes sense keep the Dijkstra’s Shortest Path Algorithm on the data layer to allow future enhancements with minor code changes.

### Direction matters!!

The problem don't specify if direction matters, so for simplicity, I decided that direction matters, therefore A->B doesn't mean B->A.
It's possible address this issue by changing the way we store the friend relation, always storing bi-directional on friendship controller.

Example

```ruby
    @friendship = Friendship.new(user_source_id: friendship_params[:user_source_id], user_destine_id: friendship_params[:user_destine_id])
    @friendship = Friendship.new(user_source_id: friendship_params[:user_destine_id], user_destine_id: friendship_params[:user_source_id])
```

## API

### Check Separation Degree 

Luke Skywalker separation degree from Boba Fett:
```bash
curl 'http://localhost:3000/friendships/degree.json?friendship\[user_source_id\]=1&friendship\[user_destine_id\]=10'
```

In order to test others just replace `user_source_id` and `user_destine_id` on the curl request

#### Seeds IDS

```ruby
luke = User.create(name: 'Luke Skywalker') #id: 1
leia = User.create(name: 'Leia Skywalker') #id: 2
padme = User.create(name: 'Padme Amidala') #id: 3
palpatine = User.create(name: 'Senator Palpatine') #id: 4
darth = User.create(name: 'Darth Vader') #id: 5
han = User.create(name: 'Han Solo') #id: 6
chewbacca = User.create(name: 'Chewbacca') #id: 7
lando = User.create(name: 'Lando Calrissian') #id: 8
jabba = User.create(name: 'Jabba the Hutt') #id: 9
boba = User.create(name: 'Boba Fett') #id: 10
jar = User.create(name: 'Jar Jar Binks') #id: 11
c3p0 = User.create(name: 'C3P0') #id: 12
r2d2 = User.create(name: 'R2D2') #id: 13
yoda = User.create(name: 'Yoda') #id: 14
```

### User CRUD

Index
```bash
curl 'http://localhost:3000/users.json'
```

Show
```bash
curl 'http://localhost:3000/users/1.json'
```

Create
```bash
curl -XPOST "http://localhost:3000/users.json" -d '{ "user": { "name": "Estevao" } }' -H "Content-type: application/json"
```

Update
```bash
curl -XPUT "http://localhost:3000/users/15.json" -d '{ "user": { "name": "Step" } }' -H "Content-type: application/json"
```

Delete
```bash
curl -XDELETE "http://localhost:3000/users/15.json" -H "Content-type: application/json"
```

### Friendship CRUD

Friendship is the pair of user source and destine.

Create
```bash
curl -XPOST "http://localhost:3000/friendships.json" -d '{ "friendship": { "user_source_id": "1", "user_destine_id": "3" } }' -H "Content-type: application/json"
```

Delete
```bash
curl -XDELETE "http://localhost:3000/friendships/57.json" -H "Content-type: application/json"
```