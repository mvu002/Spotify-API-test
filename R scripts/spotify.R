library(httr)
library(jsonlite)
library(dplyr)

base_url <- "https://api.spotify.com/v1"
endpoint <- "users"
client_id <- "3ca616dca5ec45b0965634161bc1ead1"
OAuth_key <- "2cf381388a8a48fdbc1fbe008b46a3bb"
user_id <- "t860dyc2c1gefabyn7qlek97m"

url <- paste0(base_url,
              "/",
              endpoint,
              "/",
              user_id)

# Get access token through POST 
response <- POST(
  "https://accounts.spotify.com/api/token",
  config = authenticate(user = client_id,
                        password = OAuth_key),
  body = list(grant_type = "client_credentials"),
  encode = "form"
)

token <- content(response)
bearer.token <- paste(token$token_type, token$access_token)

my_profile <- GET(url, 
                  config = add_headers(Authorization = bearer.token))

stop_for_status(my_profile)

my_profile <- my_profile %>%
  content(type = "text") %>%
  fromJSON()

str(my_profile)
View(my_profile)
