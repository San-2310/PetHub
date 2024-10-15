import express from "express";
import auth from "../middlewares/auth.js";
import productController from "../controllers/product.controller.js";

const productRouter = express.Router();

productRouter.get("/", auth, productController.getProductsByCategory);
productRouter.get("/search/:name", auth, productController.searchProducts);
productRouter.post("/rate", auth, productController.rateProduct);
productRouter.get("/deal-of-day", auth, productController.getDealOfDay);

export default productRouter;