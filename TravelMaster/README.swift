//
//  README.swift
//  TravelMaster
//
//  Created by Admin on 08/06/19.
//  Copyright © 2019 Imac. All rights reserved.
//




// AddData.swift
/*
 Conneced to add location view controller.
 name,image,loc_description -> name of location,url of image , description of the place.
 
 *** the image url MUST BE https and NOT http or image wont load***
 
 function dataentry() is called on hitting submit and it enters the values of the above 3 into the database table called places.
 if left blank it will fill nil and default values will become visible.
 */




//FirstViewController.swift
/*
 This is connected to the first screen that is visible on opening the app.
 it has 3 buttons : Login,register,Skip
 all three buttons are direct segues to their respective screens.
 
 login goes to login screen -> LOGINViewController.swift
 
 register goes to registration screen -> REGISTERViewController.swift
 
 skip will take you directly to the places. which is a table where all the places in the database are visibe. -> Places.swift
 
 also the database is initialised here.
 a database named maindb.sqlite is created if it dosent exist and opend.
 in this databse three tables are created if they dont already exist - user,places,review.
 
 user -> id(Integer with auto increment)
         name(String -> used for username)
         password(String )
 
 places -> id(Integer with auto increment)
           name(String)
           description(String)
           photo(String -> Here image url will be saved as string, typecasted later)
 
 review -> id(Integer with auto increment)
           identification(String -> This stores the id of the place for which the review was written)
           star(String -> Stores the number of stars given)
           description(String)
*/




//LOGINViewController.swift
/*
 This is connected to the login screen.
 logusername , logpassword -> username and password entered by the user.
 
 function checkfield() checks if either of the fields are empty. if true , shows an alert stating the field that is empty and prevents checking the database.
 
 function checklogin() loads the data base and for every username that matches the value of logusername, it tries for password. if both username and password match , it sets the value of check to true and breaks the loop.
 
    It also saves the username for future use in a Global Variable named squser.
 
 if after checklogin() , check == true ,
 the action function will segue to places screen -> places.swift
*/




//placedata.swift
/*
 This function is just a datatype.
 it is of the format :
 
 placedata(id:Int, name:String, description:String, imageurl:URL)
 
 and is later used to create an arrey :
 arrey: [placedata]
 
 that stores all values from one row of the places table from the database
 
 this arrey later loads the table in places.swift
*/




//Places.swift
/*
 This is connected to the places viewcontroller.
 It is of the type UIViewController that has a tableView in it.
 It is embedded in a navigation controller.
 
 tableView is the name of the tableView Variable.
 
 data is a arrey of the type [placedata].
 This arrey stores all data and is initialized as an empty arrey everytime the view loads.
 
 var data: [placedata] = []
 
 loaddata() is a function that returns an arrey of the type [placedata].
 
 first it creates another arrey ->
 var tempdata: [placedata] = []
 
 than it reads from the places table in the database. it starts at first row and fills all data in dataelement.
 
 dataelement is a variable of the type placedata.
 than it appends this dataelemnt to the tempdata arrey and loops to row 2 and so on till all rows have been traversed.
 
 once the loop ends the function will return the arrey tempdata.
 
 
 EXTENTION PLACES ->
 
this part determines the number of rows needed in the tableview , selects them one by one and fills them with the data from the arrey.
 
 When someone taps on a cell, it segues to PlacesExpandedViewController and passes identificationnum = id of the tapped cell(id of the place in that cell)
*/




//PlacesExpandedViewController.swift
/*
 This is connected to PlacesExpandedViewController.
 it has 3 variables : placename, image , descriptionlabel.
 
 placename -> changes navigation bar name
 image -> UIImageView to display image
 descriptionlabel -> displays description of the place.
 
 function loaddata() will search database to find the id that matches identificationnum
 when it does, it will load name,image and description corresponding to that id in the view controller.
 
 function placeimage() will take the imageurl generated in loaddata() , get image from it and load it in the imageView.
 */




//PlaceTableViewCell.swift
/*
 This is of the type UITableViewCell.
 It is connected to cell of table in places.swift.
 
 it has 4 outlets ->
 placeImageView: UIImageView!
 makerImageView: UIImageView!
 placeNameLabel: UILabel!
 locationLabel: UILabel!
 
 placeImageView is the image of that place from the database
 
 makerImageView is the logo of that placeType
 (for places releted to food there will be a logo, garden will have different logo ,etc.)
 
 placeNameLabel is the name of the place
 
 locationLabel is the average rating in stars
 
 
 
 function setdata() takes arguement of type placedata and fills makerImageView , placeNameLabel , locationLabel and calls loadImage() for loading image in the UIImageView
 
 function loadimage() takes arguement of the type URL , download and sets image in placeImageView of that cell.
*/




//REGISTERViewController.swift
/*
 This is connected to REGISTERViewController
 It has 3 outlets ->
 username: UITextField!
 password: UITextField!
 cpass: UITextField!
 
 and a variable max that is initialized to false.
 
 function empty() -> will check if any of the required fields are empty.
 
 if any field is empty , it will give an alert saying fields are empty and clear all fields so later function will not execute.
 
 if all fields are filled it will set max to true.
 
 
 function namecheck() -> this function checks the database and tries to match the username with existing usernames. if a match is found it gives an alert saying username already exists , clears the fields and sets max to false.
if no match is found , it sets max to true.
 
 
 function passcheck() -> it matches the passwords from the fields password and cpass. if they dont match it gives an alert saying passwords do not match and sets max to false.
 if the passwords match it sets max to true.
 
 NOTE : Where ever max is set to false , all values are cleared in order to prevent further execution.
 
 
 if after these three functions , max is true than the username and password is inserted into the users table , an alert saying success pops up and tapping ok segues to the login screen.
 */




//review.swift
/*
 just like the placedata, this is also a datatype.
 it is of the type ->
 
 review(star: Int,title: String,review: String)
 
 this is later used in creating an arrey of the type
 arrey:[review]
 
 for the reviewviewcontroller
*/




//ReviewAdd.swift
/*
 It is Connected to reviewaddViewController
 It has 6 outlets. 5 of them are images for giving stars that are overlayed with tapgestureRecogniser.
 the sixth one is for the description.
 
 the function submit() inserts the number of stars, description and identificationnum into the database and segues to the reviewViewController screen.
*/




//ReviewCell.swift
/*
 Similar to placedatacell , this only has outlet for the reviewtable cells and a function setdata() that takes arguement of the type review and fills the data in that cell.
*/




//ReviewViewController.swift
/*
 Similar to places.swift , this is connected to reviewViewController.
 
 It creates an empty arrey 'data' of the type review ->
 var data:[review] = []
 
 function loaddata() will search the review table in the database and create a dataelement ->
 
 dataelement: Review
 
 for every entry where identification matches identificationnum.
 this dataelement will them be appended to tempdata which is also an arrey of the type review. This arrey is always initialized empty.
 tempdata:[review]
 
 than when the entire table is scanned, it will return tempdata.
 
 
 extension ReviewViewController:
 This part will than take the arrey 'data' and create a UITable with data from this arrey.
*/
