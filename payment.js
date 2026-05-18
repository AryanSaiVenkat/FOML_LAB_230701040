const path = require("path");
require("dotenv").config({ path: path.resolve(__dirname, ".env") });

const stripePublishableKey = process.env.STRIPE_PUBLISHABLE_KEY || "";
const stripeSecretKey = process.env.STRIPE_SECRET_KEY || "";

module.exports = {
  stripePublishableKey,
  stripeSecretKey,
};