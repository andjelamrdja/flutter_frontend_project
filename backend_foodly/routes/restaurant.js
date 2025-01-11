const router = require('express').Router();
const restaurantController = require('../controllers/restaurantController');

router.post("/", restaurantController.addRestaurant);

router.get("/all/:code", restaurantController.getAllNearByRestaurants);

router.get("/:code", restaurantController.getRandomRestaurants);

router.get("/byId/:id", restaurantController.getRestaurantById);

module.exports = router;