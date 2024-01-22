const functions = require("firebase-functions");
const STRIPE_KEY = require("./variables");
const stripe = require("stripe")(STRIPE_KEY);

var admin = require("firebase-admin");

var serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();
const tripsColl = db.collection("trips");

exports.makeCustomToken = functions.https.onRequest(async (req, res) => {
  const instagramToken = req.query.instagramToken;

  admin
    .auth()
    .createCustomToken(instagramToken)
    .then(function (customToken) {
      console.log(customToken);
      res.json({ customToken: `${customToken}` });
    })
    .catch(function (error) {
      res.json({ result: `makeCustomToken error` });
      console.log("Error creating custom token:", error);
    });
});

exports.getRouteTrips = functions.https.onRequest(async (req, res) => {
  try {
    const { fromLat, fromLon, toLat, toLon, userId } = req.query;

    if (!fromLat || !fromLon || !toLat || !toLon) {
      return res
        .status(400)
        .send("From and To coordinates are required in the query.");
    }

    const fromCoordinates = {
      latitude: parseFloat(fromLat),
      longitude: parseFloat(fromLon),
    };

    const toCoordinates = {
      latitude: parseFloat(toLat),
      longitude: parseFloat(toLon),
    };

    const maxDistance = 2;

    const currentDateTime = new Date().toISOString().split(".")[0];

    const tripsSnapshot = await tripsColl
      .orderBy("travelledAt")
      .startAt(currentDateTime)
      .get();

    const trips = [];
    tripsSnapshot.forEach((doc) => {
      const tripData = doc.data();

      // Calculate distance between the trip and 'from' coordinates
      const distanceFrom = calculateDistance(
        fromCoordinates.latitude,
        fromCoordinates.longitude,
        tripData.departureDetails.address.latitude,
        tripData.departureDetails.address.longitude
      );

      // Calculate distance between the trip and 'to' coordinates
      const distanceTo = calculateDistance(
        toCoordinates.latitude,
        toCoordinates.longitude,
        tripData.destinationDetails.address.latitude,
        tripData.destinationDetails.address.longitude
      );

      // If the trip is within the 2km range for both 'from' and 'to' coordinates, include it
      if (
        distanceFrom <= maxDistance &&
        distanceTo <= maxDistance &&
        tripData.travellersId !== userId
      ) {
        trips.push(tripData);
      }
    });

    return res.status(200).json({ trips });
  } catch (error) {
    console.error("Error fetching trips:", error);
    return res.status(500).send("Internal Server Error");
  }
});

// Function to calculate distance between two sets of coordinates
function calculateDistance(lat1, lon1, lat2, lon2) {
  const R = 6371;
  const dLat = (lat2 - lat1) * (Math.PI / 180);
  const dLon = (lon2 - lon1) * (Math.PI / 180);
  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(lat1 * (Math.PI / 180)) *
      Math.cos(lat2 * (Math.PI / 180)) *
      Math.sin(dLon / 2) *
      Math.sin(dLon / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  const distance = R * c;
  return distance;
}

exports.stripePaymentIntentRequest = functions.https.onRequest(
  async (req, res) => {
    try {
      let customerId;

      const customerList = await stripe.customers.list({
        email: req.body.email,
        limit: 1,
      });

      if (customerList.data.length !== 0) {
        customerId = customerList.data[0].id;
      } else {
        const customer = await stripe.customers.create({
          email: req.body.email,
        });
        customerId = customer.data.id;
      }

      const ephemeralKey = await stripe.ephemeralKeys.create(
        { customer: customerId },

        { apiVersion: "2020-08-27" }
      );

      const paymentIntent = await stripe.paymentIntents.create({
        amount: parseInt(req.body.amount),
        currency: "usd",
        customer: customerId,
      });

      res.status(200).send({
        paymentIntent: paymentIntent.client_secret,
        ephemeralKey: ephemeralKey.secret,
        customer: customerId,
        success: true,
      });
    } catch (error) {
      res.status(404).send({ success: false, error: error.message });
    }
  }
);
