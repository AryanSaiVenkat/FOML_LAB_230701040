// const express = require("express");
// const mongoose = require("mongoose");
// const bcrypt = require("bcryptjs");
// const cors = require("cors");
// require("dotenv").config();

// const app = express();
// const PORT = process.env.PORT || 5000;

// // Enable CORS and JSON parsing
// app.use(cors());
// app.use(express.json());

// // MongoDB Connection
// const mongoURI =
//   "mongodb://sparnetoldmonk:0712@cluster0-shard-00-00.aprkj.mongodb.net:27017,cluster0-shard-00-01.aprkj.mongodb.net:27017,cluster0-shard-00-02.aprkj.mongodb.net:27017/?replicaSet=atlas-x5qnko-shard-0&ssl=true&authSource=admin&retryWrites=true&w=majority&appName=Cluster0";

// mongoose
//   .connect(mongoURI, {
//     useNewUrlParser: true,
//     useUnifiedTopology: true,
//   })
//   .then(() => console.log("MongoDB connected successfully"))
//   .catch((err) => console.error("MongoDB connection error:", err));

// // User Schema & Model
// const userSchema = new mongoose.Schema({
//   name: String,
//   phone: String,
//   email: String,
//   pin: String, // Hashed PIN
// });

// const User = mongoose.model("User", userSchema);

// // Route to Save User After PIN Validation
// app.post("/save_user", async (req, res) => {
//   try {
//     const { name, phone, email, pin } = req.body;
//     if (!name || !phone || !email || !pin) {
//       return res.status(400).json({ error: "All fields are required" });
//     }

//     // Hash the PIN before storing
//     const hashedPin = await bcrypt.hash(pin, 10);

//     const newUser = new User({
//       name,
//       phone,
//       email,
//       pin: hashedPin,
//     });

//     await newUser.save();
//     res.status(201).json({ success: true, message: "User saved successfully" });
//   } catch (error) {
//     console.error("Error saving user:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Login Route using phone number and PIN
// app.post("/login", async (req, res) => {
//   try {
//     const { phone, pin } = req.body;
//     if (!phone || !pin) {
//       return res.status(400).json({ error: "Phone and PIN are required" });
//     }

//     const user = await User.findOne({ phone });
//     if (!user) {
//       return res.status(401).json({ error: "User not found" });
//     }

//     const isMatch = await bcrypt.compare(pin, user.pin);
//     if (!isMatch) {
//       return res.status(401).json({ error: "Invalid PIN" });
//     }

//     res.status(200).json({
//       success: true,
//       message: "Login successful",
//       user: { name: user.name, phone: user.phone, email: user.email },
//     });
//   } catch (error) {
//     console.error("Login error:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Fetch User Data by Phone Number
// app.get("/user/:phone", async (req, res) => {
//   try {
//     const { phone } = req.params;
//     const user = await User.findOne({ phone });

//     if (!user) {
//       return res.status(404).json({ error: "User not found" });
//     }

//     res.status(200).json({ success: true, user: { name: user.name } });
//   } catch (error) {
//     console.error("Error fetching user:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Sample Route
// app.get("/", (req, res) => {
//   res.send("MongoDB Atlas connection successful!");
// });

// // Start Server
// app.listen(PORT, "0.0.0.0", () => {
//   console.log(`Server running on port ${PORT}`);
// });

// const express = require("express");
// const mongoose = require("mongoose");
// const bcrypt = require("bcryptjs");
// const cors = require("cors");
// require("dotenv").config();

// const app = express();
// const PORT = process.env.PORT || 5000;

// // Enable CORS and JSON parsing
// app.use(cors());
// app.use(express.json());

// // MongoDB Connection
// const mongoURI =
//   "mongodb://sparnetoldmonk:0712@cluster0-shard-00-00.aprkj.mongodb.net:27017,cluster0-shard-00-01.aprkj.mongodb.net:27017,cluster0-shard-00-02.aprkj.mongodb.net:27017/?replicaSet=atlas-x5qnko-shard-0&ssl=true&authSource=admin&retryWrites=true&w=majority&appName=Cluster0";

// mongoose
//   .connect(mongoURI, {
//     useNewUrlParser: true,
//     useUnifiedTopology: true,
//   })
//   .then(() => console.log("MongoDB connected successfully"))
//   .catch((err) => console.error("MongoDB connection error:", err));

// // User Schema & Model
// const userSchema = new mongoose.Schema({
//   name: String,
//   phone: String,
//   email: String,
//   pin: String, // Hashed PIN
// });

// const User = mongoose.model("User", userSchema);

// // Cart Item Schema & Model
// const cartItemSchema = new mongoose.Schema({
//   name: String,
//   description: String,
//   price: Number,
//   createdAt: {
//     type: Date,
//     default: Date.now,
//   },
// });

// const CartItem = mongoose.model("CartItem", cartItemSchema);

// // Route to Save User After PIN Validation
// app.post("/save_user", async (req, res) => {
//   try {
//     const { name, phone, email, pin } = req.body;
//     if (!name || !phone || !email || !pin) {
//       return res.status(400).json({ error: "All fields are required" });
//     }

//     const hashedPin = await bcrypt.hash(pin, 10);

//     const newUser = new User({
//       name,
//       phone,
//       email,
//       pin: hashedPin,
//     });

//     await newUser.save();
//     res.status(201).json({ success: true, message: "User saved successfully" });
//   } catch (error) {
//     console.error("Error saving user:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Login Route using phone number and PIN
// app.post("/login", async (req, res) => {
//   try {
//     const { phone, pin } = req.body;
//     if (!phone || !pin) {
//       return res.status(400).json({ error: "Phone and PIN are required" });
//     }

//     const user = await User.findOne({ phone });
//     if (!user) {
//       return res.status(401).json({ error: "User not found" });
//     }

//     const isMatch = await bcrypt.compare(pin, user.pin);
//     if (!isMatch) {
//       return res.status(401).json({ error: "Invalid PIN" });
//     }

//     res.status(200).json({
//       success: true,
//       message: "Login successful",
//       user: { name: user.name, phone: user.phone, email: user.email },
//     });
//   } catch (error) {
//     console.error("Login error:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Fetch User Data by Phone Number
// app.get("/user/:phone", async (req, res) => {
//   try {
//     const { phone } = req.params;
//     const user = await User.findOne({ phone });

//     if (!user) {
//       return res.status(404).json({ error: "User not found" });
//     }

//     res.status(200).json({ success: true, user: { name: user.name } });
//   } catch (error) {
//     console.error("Error fetching user:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // New Route: Save Item to Database
// app.post("/add_item", async (req, res) => {
//   try {
//     const { name, description, price } = req.body;

//     if (!name || !description || price === undefined) {
//       return res.status(400).json({ error: "Name, description, and price are required." });
//     }

//     const newItem = new CartItem({ name, description, price });
//     await newItem.save();

//     res.status(201).json({ success: true, message: "Item added successfully" });
//   } catch (error) {
//     console.error("Error saving item:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Sample Route
// app.get("/", (req, res) => {
//   res.send("MongoDB Atlas connection successful!");
// });

// // Start Server
// app.listen(PORT, "0.0.0.0", () => {
//   console.log(`Server running on port ${PORT}`);
// });

//2

// const express = require("express");
// const mongoose = require("mongoose");
// const bcrypt = require("bcryptjs");
// const cors = require("cors");
// require("dotenv").config();

// const app = express();
// const PORT = process.env.PORT || 5000;

// app.use(cors());
// app.use(express.json());

// // MongoDB Connection
// const mongoURI =
//   "mongodb://sparnetoldmonk:0712@cluster0-shard-00-00.aprkj.mongodb.net:27017,cluster0-shard-00-01.aprkj.mongodb.net:27017,cluster0-shard-00-02.aprkj.mongodb.net:27017/?replicaSet=atlas-x5qnko-shard-0&ssl=true&authSource=admin&retryWrites=true&w=majority&appName=Cluster0";

// mongoose
//   .connect(mongoURI, {
//     useNewUrlParser: true,
//     useUnifiedTopology: true,
//   })
//   .then(() => console.log("MongoDB connected successfully"))
//   .catch((err) => console.error("MongoDB connection error:", err));

// // Schemas
// const userSchema = new mongoose.Schema({
//   name: String,
//   phone: String,
//   email: String,
//   pin: String,
// });

// const cartItemSchema = new mongoose.Schema({
//   phone: String, // Link to user
//   name: String,
//   description: String,
//   price: Number,
//   createdAt: {
//     type: Date,
//     default: Date.now,
//   },
// });

// const User = mongoose.model("User", userSchema);
// const CartItem = mongoose.model("CartItem", cartItemSchema);

// // Routes
// app.post("/save_user", async (req, res) => {
//   try {
//     const { name, phone, email, pin } = req.body;
//     if (!name || !phone || !email || !pin) {
//       return res.status(400).json({ error: "All fields are required" });
//     }

//     const hashedPin = await bcrypt.hash(pin, 10);

//     const newUser = new User({
//       name,
//       phone,
//       email,
//       pin: hashedPin,
//     });

//     await newUser.save();
//     res.status(201).json({ success: true, message: "User saved successfully" });
//   } catch (error) {
//     console.error("Error saving user:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// app.post("/login", async (req, res) => {
//   try {
//     const { phone, pin } = req.body;
//     if (!phone || !pin) {
//       return res.status(400).json({ error: "Phone and PIN are required" });
//     }

//     const user = await User.findOne({ phone });
//     if (!user) {
//       return res.status(401).json({ error: "User not found" });
//     }

//     const isMatch = await bcrypt.compare(pin, user.pin);
//     if (!isMatch) {
//       return res.status(401).json({ error: "Invalid PIN" });
//     }

//     res.status(200).json({
//       success: true,
//       message: "Login successful",
//       user: { name: user.name, phone: user.phone, email: user.email },
//     });
//   } catch (error) {
//     console.error("Login error:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// app.get("/user/:phone", async (req, res) => {
//   try {
//     const { phone } = req.params;
//     const user = await User.findOne({ phone });

//     if (!user) {
//       return res.status(404).json({ error: "User not found" });
//     }

//     res.status(200).json({ success: true, user: { name: user.name } });
//   } catch (error) {
//     console.error("Error fetching user:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Save cart item for a user
// app.post("/add_item", async (req, res) => {
//   try {
//     const { phone, name, description, price } = req.body;

//     if (!phone || !name || !description || price === undefined) {
//       return res
//         .status(400)
//         .json({ error: "Phone, name, description, and price are required." });
//     }

//     const newItem = new CartItem({ phone, name, description, price });
//     await newItem.save();

//     res
//       .status(201)
//       .json({ success: true, message: "Item added successfully" });
//   } catch (error) {
//     console.error("Error saving item:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Get cart items for a user
// app.get("/cart/:phone", async (req, res) => {
//   try {
//     const { phone } = req.params;
//     const items = await CartItem.find({ phone }).sort({ createdAt: -1 });

//     res.status(200).json({ success: true, cart: items });
//   } catch (error) {
//     console.error("Error fetching cart:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Home route
// app.get("/", (req, res) => {
//   res.send("MongoDB Atlas connection successful!");
// });

// // Start server
// app.listen(PORT, "0.0.0.0", () => {
//   console.log(`Server running on port ${PORT}`);
// });

//3

// const express = require("express");
// const mongoose = require("mongoose");
// const bcrypt = require("bcryptjs");
// const cors = require("cors");
// require("dotenv").config();
// const Stripe = require("stripe");
// const stripe = Stripe(process.env.STRIPE_SECRET_KEY || "stripe_secret_key_here");

// const app = express();
// const PORT = process.env.PORT || 5000;

// app.use(cors());
// app.use(express.json());

// // MongoDB Connection
// const mongoURI =
//   "mongodb://sparnetoldmonk:0712@cluster0-shard-00-00.aprkj.mongodb.net:27017,cluster0-shard-00-01.aprkj.mongodb.net:27017,cluster0-shard-00-02.aprkj.mongodb.net:27017/?replicaSet=atlas-x5qnko-shard-0&ssl=true&authSource=admin&retryWrites=true&w=majority&appName=Cluster0";

// mongoose
//   .connect(mongoURI, {
//     useNewUrlParser: true,
//     useUnifiedTopology: true,
//   })
//   .then(() => console.log("MongoDB connected successfully"))
//   .catch((err) => console.error("MongoDB connection error:", err));

// // Schemas
// const userSchema = new mongoose.Schema({
//   name: String,
//   phone: String,
//   email: String,
//   pin: String,
// });

// const cartItemSchema = new mongoose.Schema({
//   phone: String,
//   name: String,
//   description: String,
//   price: Number,
//   createdAt: {
//     type: Date,
//     default: Date.now,
//   },
// });

// const User = mongoose.model("User", userSchema);
// const CartItem = mongoose.model("CartItem", cartItemSchema);

// // Routes

// // Register user
// app.post("/save_user", async (req, res) => {
//   try {
//     const { name, phone, email, pin } = req.body;
//     if (!name || !phone || !email || !pin) {
//       return res.status(400).json({ error: "All fields are required" });
//     }

//     const hashedPin = await bcrypt.hash(pin, 10);

//     const newUser = new User({
//       name,
//       phone,
//       email,
//       pin: hashedPin,
//     });

//     await newUser.save();
//     res.status(201).json({ success: true, message: "User saved successfully" });
//   } catch (error) {
//     console.error("Error saving user:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Login
// app.post("/login", async (req, res) => {
//   try {
//     const { phone, pin } = req.body;
//     if (!phone || !pin) {
//       return res.status(400).json({ error: "Phone and PIN are required" });
//     }

//     const user = await User.findOne({ phone });
//     if (!user) {
//       return res.status(401).json({ error: "User not found" });
//     }

//     const isMatch = await bcrypt.compare(pin, user.pin);
//     if (!isMatch) {
//       return res.status(401).json({ error: "Invalid PIN" });
//     }

//     res.status(200).json({
//       success: true,
//       message: "Login successful",
//       user: { name: user.name, phone: user.phone, email: user.email },
//     });
//   } catch (error) {
//     console.error("Login error:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Get user by phone
// app.get("/user/:phone", async (req, res) => {
//   try {
//     const { phone } = req.params;
//     const user = await User.findOne({ phone });

//     if (!user) {
//       return res.status(404).json({ error: "User not found" });
//     }

//     res.status(200).json({ success: true, user: { name: user.name } });
//   } catch (error) {
//     console.error("Error fetching user:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Add item to cart
// app.post("/add_item", async (req, res) => {
//   try {
//     const { phone, name, description, price } = req.body;

//     if (!phone || !name || !description || price === undefined) {
//       return res
//         .status(400)
//         .json({ error: "Phone, name, description, and price are required." });
//     }

//     const newItem = new CartItem({ phone, name, description, price });
//     await newItem.save();

//     res
//       .status(201)
//       .json({ success: true, message: "Item added successfully" });
//   } catch (error) {
//     console.error("Error saving item:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Get cart items by phone
// app.get("/cart/:phone", async (req, res) => {
//   try {
//     const { phone } = req.params;
//     const items = await CartItem.find({ phone }).sort({ createdAt: -1 });

//     res.status(200).json({ success: true, cart: items });
//   } catch (error) {
//     console.error("Error fetching cart:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Delete specific item from cart
// app.delete("/cart/delete/:id", async (req, res) => {
//   try {
//     const { id } = req.params;
//     await CartItem.findByIdAndDelete(id);

//     res.status(200).json({ success: true, message: "Item deleted successfully" });
//   } catch (error) {
//     console.error("Error deleting by ID:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Empty entire cart for a user
// app.delete("/cart/:phone", async (req, res) => {
//   try {
//     const { phone } = req.params;
//     await CartItem.deleteMany({ phone });

//     res.status(200).json({ success: true, message: "Cart emptied successfully" });
//   } catch (error) {
//     console.error("Error emptying cart:", error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });

// // Home
// app.get("/", (req, res) => {
//   res.send("MongoDB Atlas connection successful!");
// });

// // Start server
// app.listen(PORT, "0.0.0.0", () => {
//   console.log(`Server running on port ${PORT}`);
// });

const express = require("express");
const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");
const cors = require("cors");
const path = require("path");
require("dotenv").config({ path: path.resolve(__dirname, ".env") });
const Stripe = require("stripe");
const stripe = Stripe(
  process.env.STRIPE_SECRET_KEY || "stripe_secret_key_here",
);

const app = express();
const PORT = process.env.PORT || 5000;

// Enable CORS & JSON parsing
app.use(cors());
app.use(express.json());

// MongoDB Connection
// Replace with your actual MongoDB Atlas connection string in an environment variable.
const mongoURI =
  process.env.MONGODB_URI || "your_mongodb_connection_string_here";
mongoose
  .connect(mongoURI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => console.log("✅ MongoDB connected"))
  .catch((err) => console.error("❌ MongoDB connection error:", err));

// ===================== 🔹 Schemas =====================
const userSchema = new mongoose.Schema({
  name: String,
  phone: String,
  email: String,
  pin: String,
});

const cartItemSchema = new mongoose.Schema({
  phone: String,
  name: String,
  description: String,
  price: Number,
  imagePath: String, // ✅ Add this line
  createdAt: { type: Date, default: Date.now },
});

const User = mongoose.model("User", userSchema);
const CartItem = mongoose.model("CartItem", cartItemSchema);

// ===================== 👤 Auth Routes =====================
app.post("/save_user", async (req, res) => {
  try {
    const { name, phone, email, pin } = req.body;
    if (!name || !phone || !email || !pin) {
      return res.status(400).json({ error: "All fields are required" });
    }

    const hashedPin = await bcrypt.hash(pin, 10);

    const newUser = new User({ name, phone, email, pin: hashedPin });
    await newUser.save();

    res.status(201).json({ success: true, message: "User saved successfully" });
  } catch (error) {
    console.error("Error saving user:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.post("/login", async (req, res) => {
  try {
    const { phone, pin } = req.body;
    if (!phone || !pin)
      return res.status(400).json({ error: "Phone and PIN required" });

    const user = await User.findOne({ phone });
    if (!user) return res.status(401).json({ error: "User not found" });

    const isMatch = await bcrypt.compare(pin, user.pin);
    if (!isMatch) return res.status(401).json({ error: "Invalid PIN" });

    res.status(200).json({
      success: true,
      message: "Login successful",
      user: { name: user.name, phone: user.phone, email: user.email },
    });
  } catch (error) {
    console.error("Login error:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.get("/user/:phone", async (req, res) => {
  try {
    const { phone } = req.params;
    const user = await User.findOne({ phone });
    if (!user) return res.status(404).json({ error: "User not found" });

    res.status(200).json({ success: true, user: { name: user.name } });
  } catch (error) {
    console.error("Error fetching user:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// ===================== 🛒 Cart Routes =====================
app.post("/add_item", async (req, res) => {
  try {
    const { phone, name, description, price, imagePath } = req.body;

    console.log("📥 Received item:", req.body); // <-- ADD THIS

    if (!phone || !name || !description || price === undefined || !imagePath) {
      return res.status(400).json({ error: "All fields are required" });
    }

    const newItem = new CartItem({
      phone,
      name,
      description,
      price,
      imagePath, // ✅ ENSURE THIS IS BEING STORED
    });

    await newItem.save();

    res.status(201).json({ success: true, message: "Item added to cart" });
  } catch (error) {
    console.error("Error saving item:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.get("/cart/:phone", async (req, res) => {
  try {
    const { phone } = req.params;
    const items = await CartItem.find({ phone }).sort({ createdAt: -1 });
    res.status(200).json({ success: true, cart: items });
  } catch (error) {
    console.error("Error fetching cart:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.delete("/cart/delete/:id", async (req, res) => {
  try {
    await CartItem.findByIdAndDelete(req.params.id);
    res.status(200).json({ success: true, message: "Item deleted" });
  } catch (error) {
    console.error("Delete error:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.delete("/cart/:phone", async (req, res) => {
  try {
    await CartItem.deleteMany({ phone: req.params.phone });
    res.status(200).json({ success: true, message: "Cart cleared" });
  } catch (error) {
    console.error("Clear cart error:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// ===================== 💳 Stripe Payment =====================
app.post("/create-payment-intent", async (req, res) => {
  try {
    const { amount } = req.body;
    if (!amount) return res.status(400).json({ error: "Amount is required" });

    const paymentIntent = await stripe.paymentIntents.create({
      amount, // amount in cents (e.g., for USD)
      currency: "usd",
      automatic_payment_methods: { enabled: true },
    });

    res.status(200).json({ clientSecret: paymentIntent.client_secret });
  } catch (error) {
    console.error("Stripe error:", error);
    res.status(500).json({ error: "Payment creation failed" });
  }
});

// ===================== 🔄 Home Route =====================
app.get("/", (req, res) => {
  res.send("Sparnet backend is live!");
});

// ===================== 🚀 Start Server =====================
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
