import { Product } from "../models/product.model.js";

const productController = {
  getProductsByCategory: async (req, res) => {
    try {
      const products = await Product.find({ category: req.query.category });
      res.json(products);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  },

  searchProducts: async (req, res) => {
    try {
      const products = await Product.find({
        name: { $regex: req.params.name, $options: "i" },
      });
      res.json(products);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  },

  rateProduct: async (req, res) => {
    try {
      const { id, rating } = req.body;
      let product = await Product.findById(id);
      
      product.ratings = product.ratings.filter(
        (r) => r.userId.toString() !== req.user
      );

      product.ratings.push({
        userId: req.user,
        rating,
      });

      product = await product.save();
      res.json(product);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  },

  getDealOfDay: async (req, res) => {
    try {
      let products = await Product.find({});
      products.sort((a, b) => {
        const aAvg = a.ratings.reduce((sum, r) => sum + r.rating, 0) / a.ratings.length;
        const bAvg = b.ratings.reduce((sum, r) => sum + r.rating, 0) / b.ratings.length;
        return bAvg - aAvg;
      });
      res.json(products[0]);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  },
};

export default productController;