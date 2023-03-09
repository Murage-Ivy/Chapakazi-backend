# CHAPAKAZI API

Chapakazi is a web based application designed to match homeowners with trustworthy handymen in their area at competitive prices. The Chapakazi API is a tool that offers details about available handymen, including their areas of expertise, customer ratings, and the types of jobs they perform. Users who register with the app can post jobs and access information on local handymen through the API.

</br> 

## Models indentifes and relationship 

* ```A customer has many jobs ```
* ``` A handyman has many jobs through job_handymen ```
* ``` A job has many handymen through job_handymen ```
* ``` A job_handymen belongs to a handyman ```
* ``` A job_handymen belongs toa job ```
* ``` A job belongs to a customer ```
* ``` A job belongs to a handyman ```
* ``` A customer has many reviews ```
* ``` A handyman has many reviews ```
* ``` A review belongs to customer ```
* ``` A review belongs to a handyman ```
* ``` A handyman has many messages ```
* ``` A customer has many messages ```
* ``` A message belongs to a customer ```
* ``` A message belongs to a handyman ```
