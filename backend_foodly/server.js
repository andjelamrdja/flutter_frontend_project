const express = require('express')
const app = express()
const dotenv = require('dotenv');
const mongoose = require('mongoose');
const CategoryRoute = require('./routes/category');
const RestaurantRoute = require('./routes/restaurant');

dotenv.config();

mongoose.connect(process.env.MONGOURL)
.then (() => console.log("Foodly connected to database"))
.catch((err) => console.log(err))

app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use("/api/category", CategoryRoute);
app.use("/api/restaurant", RestaurantRoute);


app.listen(process.env.PORT || 6013, () => console.log(`Foodly Backend is running on port ${process.env.PORT}!`))