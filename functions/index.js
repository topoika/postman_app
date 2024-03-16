const functions = require("firebase-functions");
const STRIPE_KEY = require("./variables");
const stripe = require("stripe")(STRIPE_KEY);
var serviceAccount = require("./serviceAccountKey.json");

var admin = require("firebase-admin");
// const { error } = require("firebase-functions/logger");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
const db = admin.firestore();

const generateResponse = function (intent) {
  switch (intent.status) {
    case "requires_action":
      return {
        clientSecret: intent.client_secret,
        requiresAction: true,
        status: intent.status,
      };
    case "succeeded":
      return {
        clientSecret: intent.client_secret,
        status: intent.status,
        paymentId: intent.id,
      };
    case "requires_payment_method":
      return {
        error: "Your card was deniced, please provide a new payment method",
      };
    default:
      return {
        error: "Failed",
      };
  }
};

exports.StripePayEndpointMethodId = functions.https.onRequest(
  async (req, res) => {
    const { paymentMethodId, currency, useStripeSdk, amount, return_url } =
      req.body;
    try {
      if (paymentMethodId) {
        const params = {
          amount: amount,
          confirm: true,
          confirmation_method: "manual",
          currency: currency,
          payment_method: paymentMethodId,
          use_stripe_sdk: useStripeSdk,
          return_url: return_url,
        };
        const intent = await stripe.paymentIntents.create(params);
        console.log("Intent: " + intent);
        return res.send(generateResponse(intent));
      }
      return res.sendStatus(400);
    } catch (e) {
      return res.send({ error: e.message });
    }
  }
);
exports.StripePayEndpointIntentId = functions.https.onRequest(
  async (req, res) => {
    const { paymentIntentId, return_url } = req.body;
    try {
      if (paymentIntentId) {
        const intent = await stripe.paymentIntents.confirm(paymentIntentId, {
          return_url: return_url,
        });
        console.log("Intent: " + intent);
        return res.send(generateResponse(intent));
      }
      return res.sendStatus(400);
    } catch (e) {
      return res.send({ error: e.message });
    }
  }
);
