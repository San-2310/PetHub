import express from "express";
import mongoose from "mongoose";
import cors from "cors";
import cookieParser from "cookie-parser";
import userRouter from "./routes/userRoutes.js";
import petRouter from "./routes/petRoutes.js";
import productRouter from "./routes/productRoutes.js";
import orderRouter from "./routes/orderRoutes.js";

const app = express();

// Middleware
app.use(
  cors({
    origin: 'http://localhost:3000', // Adjust this to your frontend URL
    credentials: true,
  })
);

app.use((req, res, next) => {
  res.setHeader('Cross-Origin-Opener-Policy', 'cross-origin-allow-popups');
  next();
});

app.use(express.json({ limit: "16kb" }));
app.use(express.urlencoded({ extended: true, limit: "16kb" }));
app.use(express.static("public"));
app.use(cookieParser());

// Routes
app.use('/api/users/', userRouter);
app.use('/api/pets/', petRouter);
app.use('/api/products/', productRouter);
app.use('/api/orders/', orderRouter);

// MongoDB Connection
const connectDB = async () => {
  try {
    await mongoose.connect('mongodb://localhost:27017/techwizardtest', {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log("MongoDB connected");
  } catch (error) {
    console.error("MongoDB connection error: ", error);
    throw error;
  }
};

// Server Initialization
connectDB()
  .then(() => {
    const port = 8000;

    app.on("Error", (error) => {
      console.log("APP ERROR:", error);
      throw error;
    });

    app.listen(port, () => {
      console.log(`Server running on port: ${port}`);
    });
  })
  .catch((err) => {
    console.log("MongoDB CONNECTION FAILED:", err);
  });

export { app };