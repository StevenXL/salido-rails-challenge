# Wine API
This repository downloads data from the Wine.com API, stores it in a local
database, and exposes both a web-based interface for performing CRUD actions on
the resources as well as an API interface.

## Installation
1. Download / fork repository
2. Run `bundle install`
3. Create an API key at [wine.com](https://api.wine.com/)
4. Export key in Step 3 via `export WINE_API_KEY=<key>`
5. Run `rake db:drop && rake db:create && rake db:migrate && rake db:seed`


## Using the API
The API contains end-points for *almost* all of the models / relations in the
application, and is structured to adhere to **RESTful** actions. This means
that, to get a list of wines, for example, you would make a *GET* request to
`/api/v1/wines`.

### Base API endpoint
As mentioned above, all API calls will require a request to
`/api/<version>/<model>`.
Currently, the only version of the API is version 1, so a complete call would
look like this: `/api/v1/wines/`.

### Example Usage Based on Wine Model

#### Viewing All Wines
To view all wines, issue a **GET** request to `/api/v1/wines`.

#### Viewing a Single Wine
To view a single wine, issue a **GET** request to `/api/v1/wines/<wine_id>`.

#### Updating a Wine
Updating a wine can be done in two ways, but the only difference is how the
updated attributes are submitted to the server. For example, a wine's name can
be updated through **query strings**, by issuing a *PATCH / PUT* request to
`/api/v1/wines/<wine_id>?wine[name]=Nectar%20Of%20the%20Gods`.

**NOTE:** If using query strings to update a resource, make sure to encode the
query string, and to nest parameters appropriately.

A second option is to make a request to the server, and include a JSON
representation of the attributes in the body of the request.

#### Creating a Wine
Creating a wine is done via a *POST* request to `/api/v1/wines`. The attributes
to create a wine can be sent to the server via a query string or in the
request's body. (See section on updating a wine).

Note that, at a minimum, to create a wine you must provide the *name*,
*price_max*, *price_min*, and *price_retail* attributes. Optionally, you can
provide *appellation_id*, *varietal_id*, and *vineyard_id* to associate the new
wine with a specific appellation, varietal, or vineyard, respectively.

#### Destroying a Wine
A wine can be wiped from the database by making a *DELETE* request to the
following endpoint: `/api/v1/wines/<wine_id>`.
