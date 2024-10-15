import express from "express";
import auth from "../middlewares/auth.js";
import orderController from "../controllers/order.controller.js";

const orderRouter = express.Router();

orderRouter.post("/add-to-cart", auth, orderController.addToCart);
orderRouter.delete("/remove-from-cart/:id", auth, orderController.removeFromCart);
orderRouter.post("/save-user-address", auth, orderController.saveUserAddress);
orderRouter.post("/", auth, orderController.placeOrder);
orderRouter.get("/me", auth, orderController.getUserOrders);

export default orderRouter;